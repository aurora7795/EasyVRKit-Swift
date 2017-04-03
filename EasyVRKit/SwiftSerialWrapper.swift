   import Foundation;
   
   class SwiftSerialWrapper: NSObject, SerialPortProtocol {
    
    private var serialPort: SerialPort;
    
    public let InfiniteTimeout = 0;
    
    required init(port: String, baudRate: Int){
        serialPort = SerialPort(path: port);
        
        super.init()
        
        do{
            print("Attempting to open port: \(port)")
            try serialPort.openPort()
            print("Serial port \(port) opened successfully.")           
            
            serialPort.setSettings(receiveRate: .baud9600	, transmitRate: .baud9600, minimumBytesToRead: 1	)            
        }
        catch PortError.failedToOpen {
            print("Serial port \(port) failed to open. You might need root permissions.")
        }
        catch{
            print("Error: \(error)")
        }
        
    }
    
    func Read() -> Character{
        do{
            let unicodeScharar = try serialPort.readChar();
            let char = Character(unicodeScharar)
            return char	;
        }
        catch{
            print("Error: \(error)")
            return "±"
        }
    }
    
    func Write(request: Character) {
        
        do{
            try serialPort.writeChar(unicodeScalarCodePoint(char: request));
        }
        catch{
            print("Error: \(error)")
        }
    }
    
    func SetTimeout(timeout: Int) {
        serialPort.setSettings(receiveRate: .baud9600, transmitRate: .baud9600, minimumBytesToRead: 1, timeout: timeout, parityType: .none, sendTwoStopBits: false, dataBitsSize: .bits8, useHardwareFlowControl: false, useSoftwareFlowControl: false, processOutput: false)    }
    
    func unicodeScalarCodePoint(char: Character) -> UnicodeScalar
    {
        let characterString = String(describing: char)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex]
    }
    
    func Close(){
        serialPort.closePort();
    }
    
    
   }
