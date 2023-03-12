//
//  Bluetooth Desvergue.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 11/03/23.
//

import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    public var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    @Published var selectedPeripheral: CBPeripheral?
    @Published var connectionStatus: String = ""
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
    
    func connect() {
        if let peripheral = selectedPeripheral {
            centralManager?.connect(peripheral, options: nil)
        }
    }
    
    func disconnect() {
        guard let peripheral = selectedPeripheral else { return }
        centralManager?.cancelPeripheralConnection(peripheral)
    }
    
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if let peripheralName = peripheral.name {
            if !peripheralNames.contains(peripheralName) {
                self.peripherals.append(peripheral)
                self.peripheralNames.append(peripheralName)
            }
        }
    }

    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.connectionStatus = "Conexión Exitosa"
        print("Conectado")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            self.connectionStatus = "No se completó la Conexión: \(error.localizedDescription)"
        } else {
            self.connectionStatus = "No se completó la Conexión"
        }
        print("No jaló la conexión")
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        if let error = error {
            self.connectionStatus = "Desconectado: \(error.localizedDescription)"
        } else {
            self.connectionStatus = "Desconectado"
        }
        print("Desconectado")
    }

}

struct Bluetooth_Desvergue: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    private var characteristic: CBCharacteristic? = nil
    @State private var receivedMessage: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                List(Array(bluetoothViewModel.peripheralNames), id: \.self) { peripheralName in
                    Button(action: {
                        if let index = bluetoothViewModel.peripheralNames.firstIndex(of: peripheralName) {
                            bluetoothViewModel.selectedPeripheral = bluetoothViewModel.peripherals[index]
                            bluetoothViewModel.connect()
                        }
                    }) {
                        Text(peripheralName)
                    }
                }
                .navigationTitle("Dispositivos Cerca")
                Spacer()
                Button("Desconectar", action: {
                    bluetoothViewModel.disconnect()
                }).offset(x:-100).padding()
                Text(bluetoothViewModel.connectionStatus).offset(x:100, y:-45)
                
                if let selectedPeripheral = bluetoothViewModel.selectedPeripheral {
                    VStack {
                        Button("Enviar mensaje") {
                            let data = "Hola desde el celular".data(using: .utf8)!
                            selectedPeripheral.writeValue(data, for: characteristic!, type: .withoutResponse)
                        }
                        Text("Mensaje recibido: \(receivedMessage ?? "N/A")")
                    }
                }
            }
        }
        .onAppear() {
            bluetoothViewModel.objectWillChange.send()
        }
        .onDisappear() {
            bluetoothViewModel.disconnect()
        }
    }
}


struct Bluetooth_Desvergue_Previews: PreviewProvider {
    static var previews: some View {
        Bluetooth_Desvergue()
    }
}


















/*
class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    private var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    
    override init() {
        super.init()
        self.centralManager = CBCentralManager(delegate: self, queue: .main)
    }
}

extension BluetoothViewModel: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            self.centralManager?.scanForPeripherals(withServices: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
        }
    }
}

struct Bluetooth_Desvergue: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            List(bluetoothViewModel.peripheralNames, id: \.self) { peripheral in
                Text(peripheral)
            }
            .navigationTitle("Peripherals")
        }
    }
}












struct Bluetooth_Desvergue_Previews: PreviewProvider {
    static var previews: some View {
        Bluetooth_Desvergue()
    }
}

*/
