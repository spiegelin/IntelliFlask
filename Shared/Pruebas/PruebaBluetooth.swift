//
//  PruebaBluetooth.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 12/03/23.
//

import SwiftUI
import CoreBluetooth

class BluetoothDelegate: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {

    var centralManager: CBCentralManager?
    var peripheral: CBPeripheral?
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // Escanea y conecta con el dispositivo
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // Conecta con el dispositivo
        self.peripheral = peripheral
        self.peripheral?.delegate = self
        central.connect(self.peripheral!, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Inicia la búsqueda de servicios en el dispositivo
        peripheral.discoverServices(nil)
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                // Inicia la búsqueda de características en el servicio
                peripheral.discoverCharacteristics(nil, for: service)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                // Configura la característica para notificaciones
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let value = characteristic.value {
            // Almacena la respuesta del dispositivo en una variable
            let response = String(data: value, encoding: .utf8)
            print("Received: \(response ?? "")")
        }
    }
    
    func writeValue(data: String) {
        if let characteristic = getCharacteristic() {
            let value = data.data(using: .utf8)
            peripheral?.writeValue(value!, for: characteristic, type: .withResponse)
        }
    }
    
    private func getCharacteristic() -> CBCharacteristic? {
        if let services = peripheral?.services {
            for service in services {
                if let characteristics = service.characteristics {
                    for characteristic in characteristics {
                        if characteristic.uuid == CBUUID(string: "4fafc201-1fb5-459e-8fcc-c5c9c331914b") {
                            return characteristic
                        }
                    }
                }
            }
        }
        return nil
    }
    
}


struct PruebaBluetooth: View {
    
    let delegate = BluetoothDelegate()
    @State var inputText: String = ""
    
    var body: some View {
        VStack {
            TextField("Input text", text: $inputText)
                .padding()
            Button("Send") {
                delegate.writeValue(data: inputText)
            }
        }
        .onAppear {
            // Configura y activa el Bluetooth
            delegate.centralManager = CBCentralManager(delegate: delegate, queue: nil
            )
        }
    }
}


struct PruebaBluetooth_Previews: PreviewProvider {
    static var previews: some View {
        PruebaBluetooth()
    }
}
