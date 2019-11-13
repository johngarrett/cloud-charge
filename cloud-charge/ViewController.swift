import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    var centralManager: CBCentralManager?
    var nearbyDevices = [UUID]() {
        didSet{
            for device in self.centralManager!.retrievePeripherals(withIdentifiers: nearbyDevices) {
                print( " We are connected to: \(device.name ?? "null")")
//                device.discoverCharacteristics([CBUUID.BatteryLevel], for: .notify)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.centralManager = CBCentralManager(delegate: self, queue: nil)
    }
}

extension ViewController : CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            central.scanForPeripherals(withServices: nil, options: nil)
        }
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        nearbyDevices.append(peripheral.identifier)
    }
}
