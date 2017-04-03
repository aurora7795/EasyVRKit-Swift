//
//  EasyVRLibrary.swift
//  EasyVRKit
//
//  Created by Martin Bradford Gago on 08/03/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import Foundation


class EasyVRLibrary {
    
    var EASYVR_RX_TIMEOUT = 50;
    var EASYVR_STORAGE_TIMEOUT = 50;
    static var DEF_TIMEOUT: Int?;
    var STORAGE_TIMEOUT: Int;
    var EASYVR_WAKE_TIMEOUT = 20;
    var EASYVR_PLAY_TIMEOUT = 50;
    var EASYVR_TOKEN_TIMEOUT = 150;
    var NO_TIMEOUT = 0;
    var Group: Int = 0;
    var Id: Int = 0;
    var Value: Int = 0;
    private var _status: Status;
    
    static var _serialPort: SerialPortProtocol?;
    
    enum EasyVRError: Error {
        case IllegalArgument(String)
    }
    
    public init(portName: String, baudRate: Int) {
        
        EasyVRLibrary.DEF_TIMEOUT = EASYVR_RX_TIMEOUT;
        STORAGE_TIMEOUT = EASYVR_STORAGE_TIMEOUT;
        _status = Status();
        
        // Create the serial port with basic settings
        EasyVRLibrary._serialPort = SwiftSerialWrapper(port: portName, baudRate: baudRate);
        
        Value = -1;
        Group = -1;
        Id = -1;
        _status.V = 0;
    }
    
    private func SendCommand(command: Character) {
        
        EasyVRLibrary._serialPort?.Write(request: command);
        
    }
    
    private func ReceiveArgument(responseAsInteger: inout Int) -> Bool {
        
        self.SendCommand(command: Character(UnicodeScalar(Protocol.ARG_ACK)!))
        
        //  do {
        responseAsInteger = ArgumentEncoding.ConvertArgumentCode(argumentCode: GetResponse());
        return responseAsInteger >= Protocol.ARG_MIN && responseAsInteger <= Protocol.ARG_MAX;
        // } catch (TimeoutException) {
        //   return false;
    }
    
    
    private func ReceiveArgument(responseAsCharacter: inout Character) -> Bool {
        
        self.SendCommand(command: Character(UnicodeScalar(Protocol.ARG_ACK)!));
        
        responseAsCharacter = GetResponse();
        
        return Int(String(responseAsCharacter))! >= -1 && Int(String(responseAsCharacter))! <= 31;
    }
    
    
    private func GetResponse(timeout: Int = DEF_TIMEOUT!) -> Character {
        
        EasyVRLibrary._serialPort?.SetTimeout(timeout: timeout);
        
        let temp = EasyVRLibrary._serialPort?.Read();
        
        return (Character?(temp!))!;
    }
    
    
    private func SendArgument(argument: Int) {
        do {
            try EasyVRLibrary._serialPort?.Write(request: ArgumentEncoding.IntToArgumentChar(integer: argument));
        } catch {
            print("Error sending argument: \(argument)");
        }
    }
    
    
    /// Closes the current serial port connection to the EasyVR module.
    public func CloseConnection() {
        EasyVRLibrary._serialPort?.Close();
    }
    
    
    /// Adds a new custom command to a group.
    ///
    /// - Parameters:
    ///   - group: (0-16) is the target group, or one of the values in #Groups
    ///   - index: (0-31) is the index of the command within the selected group
    /// - Returns: true if the operation is successful
    /// - Throws: IllegalArgument if group or index are out of bounds
    public func AddCommand(group: Int, index: Int) throws -> Bool {
        if (group < 0 || group > 16) {
            throw EasyVRError.IllegalArgument("group");
        }
        if (index < 0 || index > 31) {
            throw EasyVRError.IllegalArgument("index");
        }
        
        SendCommand(command: Protocol.CMD_GROUP_SD);
        SendArgument(argument: group);
        SendArgument(argument: index);
        
        var rx: Character;
        rx = GetResponse(timeout: STORAGE_TIMEOUT);
        if (rx == Protocol.STS_SUCCESS) {
            return true;
        }
        
        _status.V = 0;
        
        if (rx == Protocol.STS_OUT_OF_MEM) {
            _status.MemFull = true;
        }
        
        return false;
    }
    
    /// Sets the new communication speed. You need to modify the baudrate of the
    /// underlying Stream object accordingly, after the function returns successfully.
    ///
    /// - Parameter baudRate: one of values in #Baudrate
    /// - Returns: true if the operation is successful
    public func ChangeBaudrate(baudRate: Protocol.Baudrate) -> Bool {
        SendCommand(command: Protocol.CMD_BAUDRATE);
        SendArgument(argument: baudRate.rawValue);
        
        return GetResponse() == Protocol.STS_SUCCESS;
    }
    
    /// Performs a memory check for consistency.
    /// If a memory write or erase operation does not complete due to unexpecte conditions, like power losses, the
    /// memory contents may be corrupted.
    /// When the check fails #getError() returns #ERR_CUSTOM_INVALID.
    ///
    /// - Returns: true if the operation is successful
    public func CheckMessages() -> Bool {
        SendCommand(command: Protocol.CMD_VERIFY_RP);
        SendArgument(argument: -1);
        SendArgument(argument: 0);
        
        var rx:Character;
        rx = GetResponse(timeout: STORAGE_TIMEOUT);
        ReadStatus(rx: rx);
        return (_status.V == 0);
    }
    
    /// Starts listening for a SonicNet token. Manually check for completion with #hasFinished().
    ///
    /// The module is busy until token detection completes and it cannot accept other commands.You can interrupt
    /// listening with #stop().
    ///
    /// - Parameters:
    ///   - bits: (4 or 8) specifies the length of received tokens
    ///   - rejection: rejection (0-2) specifies the noise rejection level, it can be one of the values in #RejectionLevel
    ///   - timeout: (1-28090) is the maximum time in milliseconds to keep listening for a valid token or (0) to listen without time limits.
    public func DetectToken(bits: Protocol.BitNumber,rejection: Protocol.RejectionLevel,timeout: Int ) {
        
        var tempTimeout = timeout;
        
        SendCommand(command: Protocol.CMD_RECV_SN);
        SendArgument(argument: bits.rawValue);
        SendArgument(argument: rejection.rawValue);
        
        if (tempTimeout > 0){
            tempTimeout = (tempTimeout * 2 + 53) / 55; // approx / 27.46 - err < 0.15%
        }
        SendArgument(argument: (tempTimeout >> 5) & 0x1F);
        SendArgument(argument: tempTimeout & 0x1F);
    }
    
    /// <summary>
    ///     Retrieves the contents of a built-in or a custom grammar.
    ///     Command labels contained in the grammar can be obtained by calling #getNextWordLabel()
    /// </summary>
    /// <param name="grammar">(0-31) is the target grammar, or one of the values in #Wordset</param>
    /// <param name="flags">is a variable that holds some grammar flags when the function returns. See #GrammarFlag</param>
    /// <param name="count">count is a variable that holds the number of words in the grammar when the function returns.</param>
    /// <returns>true if the operation is successful</returns>
    
    public func DumpGrammar(grammar: Int, flags: inout uint8, count: inout Int) throws -> Bool
    {
        if (grammar < 0 || grammar > 31) {
            throw EasyVRError.IllegalArgument("grammar");
        }
        
        SendCommand(command: Protocol.CMD_DUMP_SI);
        SendArgument(argument: grammar);
        
        if (GetResponse() != Protocol.STS_GRAMMAR)
        {
            count = 0;
            flags = 0;
            return false;
        }
        
        var rx: Character = "±";
        if (!ReceiveArgument(responseAsCharacter: &rx))
        {
            count = 0;
            flags = 0;
            return false;
        }
        
        let tempRx = ArgumentEncoding.CharToByte(char: rx)
        flags = (tempRx == -1 ? 32 : tempRx);
        
        if (!ReceiveArgument(responseAsCharacter: &rx))
        {
            count = 0;
            return false;
        }
        
        count = Int(tempRx);
        return true;
    }
    
    
    /// Plays a phone tone and waits for completion
    ///
    /// - Parameters:
    ///   - tone: is the index of the tone (0-9 for digits, 10 for '*' key, 11 for '#' key and 12-15 for extra keys
    ///           'A' to 'D', -1 for the dial tone)
    ///   - duration: (1-32) is the tone duration in 40 milliseconds units, or  in seconds for the dial tone
    /// - Returns: true if the operation is successful
    /// - Throws: IllegalArgument if tone or duration are outside of acceptable bounds
    public func PlayPhoneTone(tone: Int, duration: Int) throws -> Bool {
        if (tone < -1 || tone > 15) {
            throw EasyVRError.IllegalArgument("Tone");
        }
        if (duration < 1 || duration > 32) {
            throw EasyVRError.IllegalArgument("Duration");
        }
        
        SendCommand(command: Protocol.CMD_PLAY_DTMF);
        
        SendArgument(argument: -1);
        SendArgument(argument: tone);
        SendArgument(argument: duration);
        
        let response = GetResponse();
        return response == Protocol.STS_SUCCESS;
    }
    
    
    private func ReadStatus(rx: Character) {
        _status.V = 0;
        Value = 0;
        
        var tempRx = rx;
        
        switch (tempRx) {
        case Protocol.STS_SUCCESS:
            return;
            
        case Protocol.STS_SIMILAR:
            
            _status.Builtin = true;
            if(self.ReceiveArgument(responseAsCharacter: &tempRx)){
                Value = Int(String(tempRx))!;
                return;
            }
            
            
        case Protocol.STS_RESULT:
            _status.Command = true;
            
            if(ReceiveArgument(responseAsCharacter: &tempRx)){
                Value = Int(String(tempRx))!;
                return;
            }
            break;
            
        case Protocol.STS_TOKEN:
            _status.Token = true;
            
            if(ReceiveArgument(responseAsCharacter: &tempRx)){
                Value = Int(String(tempRx))! << 5;
                
                if(ReceiveArgument(responseAsCharacter: &tempRx)){
                    Value |= Int(String(tempRx))!;
                    
                    return;
                }
            }
            break;
        case Protocol.STS_AWAKEN:
            _status.Awakened = true;
            return;
            
        case Protocol.STS_TIMEOUT:
            _status.Timeout = true;
            return;
            
        case Protocol.STS_INVALID:
            _status.Invalid = true;
            return;
            
        case Protocol.STS_ERROR:
            _status.Error = true;
            
            if(ReceiveArgument(responseAsCharacter: &tempRx)){
                Value = Int(String(tempRx))! << 4;
                
                if(ReceiveArgument(responseAsCharacter: &tempRx)){
                    Value |= Int(String(tempRx))!;
                    return;
                }
            }
            break;
        default:
            // unexpected condition (communication error)
            _status.V = 0;
            _status.Error = true;
            Value = 0;
            break;
        }
        
    }
    
    func ResetAll() -> Bool {
        SendCommand(command: Protocol.CMD_RESETALL);
        SendCommand(command: "R");
        
        return GetResponse(timeout: 50) == Protocol.STS_SUCCESS;
    }
    
    /// Status object used to keep track of Easy VR module between operations
    
    private class Status {
        var Awakened: Bool = false;
        var Builtin: Bool = false;
        var Command: Bool = false;
        var Conflict: Bool = false;
        var Error: Bool = false;
        var Invalid: Bool = false;
        var MemFull: Bool = false;
        var Timeout: Bool = false;
        var Token: Bool = false;
        var V: UInt8 = 0;
        
        public init() {
            
        }
        
    }
    
}

