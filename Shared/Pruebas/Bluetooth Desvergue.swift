//
//  Bluetooth Desvergue.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 11/03/23.
//
/*
import SwiftUI
import CoreBluetooth


struct Bluetooth_Desvergue: View {
    
    @State private var devices = [CBPeripheral]()
    @ObservedObject var bleManager: BLEManager
    
    var body: some View {
        VStack {
            List(devices, id: \.identifier) { device in
                Text(device.name ?? "Unknown Device")
            }
            .onAppear {
                BLECentral.shared.startScan()
                
                Text(bleManager.receivedData)
                Button("Send Command", action: {
                    bleManager.sendCommand(command: "Hi from the app")
                })
            }
        }
    }
}



class BLECentral: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    static let shared = BLECentral()
    private var centralManager: CBCentralManager!
    private var peripheral: CBPeripheral!
    private var characteristic: CBCharacteristic!
    weak var delegate: BLECentralDelegate?

    
    func startScan() {
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }
    
    func stopScan() {
        centralManager.stopScan()
    }
    
    func connect(to peripheral: CBPeripheral) {
        self.peripheral = peripheral
        self.peripheral.delegate = self
        centralManager.connect(peripheral, options: nil)
    }
    
    func disconnect() {
        if let peripheral = peripheral {
            centralManager.cancelPeripheralConnection(peripheral)
        }
    }
    
    func writeCommand(command: String) {
        let data = command.data(using: .utf8)!
        peripheral.writeValue(data, for: characteristic, type: .withResponse)
    }
    
    // MARK: - CBCentralManagerDelegate
    
    func centralManagerDidUpdateState(_central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        } else {
            print("Bluetooth is not available")
        }
    }
    
    func centralManager(_central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        print("Discovered \(peripheral.name ?? "Unknown") (\(peripheral.identifier.uuidString))")
        delegate?.didDiscoverPeripheral(peripheral)
    }
    
    func centralManager(_central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to \(peripheral.name ?? "Unknown") (\(peripheral.identifier.uuidString))")
        peripheral.discoverServices(nil)
        delegate?.didConnectPeripheral(peripheral)
    }
    
    func centralManager(_central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        print("Disconnected from \(peripheral.name ?? "Unknown") (\(peripheral.identifier.uuidString))")
        delegate?.didDisconnectPeripheral(peripheral)
    }
    
    // MARK: - CBPeripheralDelegate
    
    func peripheral(_peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let error = error {
            print("Error discovering services: \(error.localizedDescription)")
            return
        }
        
        guard let services = peripheral.services else { return }
        
        for service in services {
            print("Discovered service \(service.uuid.uuidString)")
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }
    
    func peripheral(_peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let error = error {
            print("Error discovering characteristics: \(error.localizedDescription)")
            return
        }
        
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            print("Discovered characteristic \(characteristic.uuid.uuidString)")
            if characteristic.properties.contains(.write) {
                self.characteristic = characteristic
            }
            peripheral.setNotifyValue(true, for: characteristic)
        }
    }
    
    func peripheral(_peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error updating value for characteristic: (error.localizedDescription)")
            return
        }
        guard let data = characteristic.value else { return }
        
        let dataString = String(data: data, encoding: .utf8)!
        print("Received data: \(dataString)")
        delegate?.didReceiveData(dataString)
    }
    
    /*
    
    func centralManager(_central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        print("Connected to "(peripheral.name ?? 'Unknown')" "(peripheral.identifier.uuidString))
        peripheral.discoverServices(nil)
        peripheral.delegate = self // set the delegate to self
        delegate?.didConnectPeripheral(peripheral)
    }
     */
}
        

class BLEManager: ObservableObject {
    
    @Published var receivedData = ""
    
    private var central: BLECentral
    
    init(central: BLECentral) {
        self.central = central
        self.central.delegate = self
    }
    
    func sendCommand(command: String) {
        central.writeCommand(command: command)
    }
    
    
}

extension BLEManager: BLECentralDelegate {
    func didReceiveData(data: String) {
        receivedData = data
    }

}

*/

/////// AQUI


import SwiftUI
import CoreBluetooth

class BluetoothViewModel: NSObject, ObservableObject {
    private var centralManager: CBCentralManager?
    public var peripherals: [CBPeripheral] = []
    @Published var peripheralNames: [String] = []
    @Published var selectedPeripheral: CBPeripheral?
    @Published var connectionStatus: String = ""
    //private var characteristic: CBCharacteristic? = nil
    
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
