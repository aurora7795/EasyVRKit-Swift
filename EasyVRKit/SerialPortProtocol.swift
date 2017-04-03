//
//  SerialPortProtocol.swift
//  EasyVRKit
//
//  Created by Martin Bradford Gago on 22/02/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import Foundation

protocol SerialPortProtocol {
    init(port: String, baudRate: Int);
    
    func Read() -> Character;
    
    func Write(request: Character) ;
    
    func SetTimeout(timeout: Int);
    
    func Close();
}
