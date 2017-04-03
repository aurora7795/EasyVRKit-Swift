    //
    //  SerialPort.swift
    //  EasyVRKit
    //
    //  Created by Martin Bradford Gago on 22/02/2017.
    //  Copyright © 2017 Martin Bradford Gago. All rights reserved.
    //
    
    import Foundation
    import ORSSerial;
    
    class ORSSerialPortWrapper: NSObject, SerialPortProtocol, ORSSerialPortDelegate {
        
        var _timeout:Int = 0;
        var  _buffer:Data;
        private var internalBuffer: Character;
        private var hasBeenRead: Bool = true;
        
        required init(port: String, baudRate: Int){
            self._buffer = Data();
            self.internalBuffer = "±";
           
            serialPort = ORSSerialPort(path: port)!
            serialPort?.numberOfStopBits = 1
            self.serialPort?.baudRate = NSNumber(value: baudRate);
            
            serialPort?.open();
            
            super.init();
        }
        
        private var serialPort: ORSSerialPort? {
            
            didSet {
                oldValue?.close()
                oldValue?.delegate = nil
                serialPort?.delegate = self
            }
        }
        
        public func SetTimeout(timeout: Int) {
            _timeout = timeout;
        }
        
        public func Write(request: Character) {
            
            let tempString = "\(request)";
            
            if let data = tempString.data(using: String.Encoding.utf8) {
                self.serialPort?.send(data)
            }
        }
        
        public func Read() -> Character {          
            
            return internalBuffer;
            
        }
        
        func serialPortWasRemoved(fromSystem serialPort: ORSSerialPort) {
            self.serialPort = nil
        }
        
        func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
            if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                let tempChar = Character(UnicodeScalar(string.character(at: 0))!) ;
                internalBuffer = tempChar;
                hasBeenRead = false;
            }
        }
        
        func ClosePort(){
            serialPort?.close();
        }
        
        
    }
