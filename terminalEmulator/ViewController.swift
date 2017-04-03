//
//  ViewController.swift
//  terminalEmulator
//
//  Created by Martin Bradford Gago on 21/02/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import Cocoa
import ORSSerial

class ViewController: NSViewController, ORSSerialPortDelegate {
    
    @IBOutlet weak var SubmitBtn: NSButton!
    
    @IBOutlet var reqTV: NSTextView!
   
    @IBOutlet var responseTV: NSTextView!
    
    @IBOutlet weak var serialPortPopup: NSPopUpButton!
    
    @IBOutlet weak var connectBtn: NSButton!
    
    var serialPort: ORSSerialPort? {
                
        didSet {
            oldValue?.close()
            oldValue?.delegate = nil
            serialPort?.delegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let serialPortManager = ORSSerialPortManager.shared();
        let ports = serialPortManager.availablePorts;
       
        var portNames = [String]();
        
        for port in ports{
            portNames.append(port.name);
        }
        
        serialPortPopup.removeAllItems();
        serialPortPopup.addItems(withTitles: portNames)
        
        
                    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    @IBAction func submitClick(_ sender: NSButton) {
      
        let tempString = reqTV.textStorage?.string;
        
        if let data = tempString?.data(using: String.Encoding.utf8) {
            self.serialPort?.send(data)
        }
        
        responseTV.scrollToEndOfDocument(SubmitBtn);
    }
    
   
    @IBAction func connectClick(_ sender: Any) {
        let portToUse = serialPortPopup.titleOfSelectedItem;
        
        serialPort = ORSSerialPort(path: portToUse!)
        serialPort?.baudRate = 9800
        serialPort?.numberOfStopBits = 1
        
        serialPort?.open()
        
        connectBtn.isEnabled = false;

    }
    
    
    func serialPort(_ serialPort: ORSSerialPort, didReceive data: Data) {
        if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
            self.responseTV.textStorage?.mutableString.append(string as String)
            self.responseTV.needsDisplay = true
        }
    }
    
    func serialPortWasRemoved(fromSystem serialPort: ORSSerialPort) {
        self.serialPort = nil
      
    }
    
    override func viewDidDisappear() {
        super.viewDidDisappear();
        
 
    }
    
}

