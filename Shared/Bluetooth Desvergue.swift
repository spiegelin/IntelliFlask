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
        guard let peripheral = selectedPeripheral else { return }
        centralManager?.connect(peripheral, options: nil)
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
        if !peripherals.contains(peripheral) {
            self.peripherals.append(peripheral)
            self.peripheralNames.append(peripheral.name ?? "unnamed device")
        }
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        self.connectionStatus = "Conexión Exitosa"
        print("Conectado")
    }
    
    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        self.connectionStatus = "No se completó la Conexión"
        print("No jaló la conexión")
    }
    
    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        self.connectionStatus = "Desconectado"
        print("Desconectado")
    }
}

struct Bluetooth_Desvergue: View {
    @ObservedObject private var bluetoothViewModel = BluetoothViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                List(bluetoothViewModel.peripheralNames, id: \.self) { peripheralName in
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
