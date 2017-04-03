//
//  ArgumentEncoding.swift
//  EasyVRKit
//
//  Created by Martin Bradford Gago on 08/03/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import Foundation

public enum ArgumentCode: Character {
    case ArgNegOne = "@"
    case Arg0 = "A"
    case Arg1 = "B"
    case Arg2 = "C"
    case Arg3 = "D"
    case Arg4 = "E"
    case Arg5 = "F"
    case Arg6 = "G"
    case Arg7 = "H"
    case Arg8 = "I"
    case Arg9 = "J"
    case Arg10 = "K"
    case Arg11 = "L"
    case Arg12 = "M"
    case Arg13 = "N"
    case Arg14 = "O"
    case Arg15 = "P"
    case Arg16 = "Q"
    case Arg17 = "R"
    case Arg18 = "S"
    case Arg19 = "T"
    case Arg20 = "U"
    case Arg21 = "V"
    case Arg22 = "W"
    case Arg23 = "X"
    case Arg24 = "Y"
    case Arg25 = "Z"
    case Arg26 = "^"
    case Arg27 = "["
    case Arg28 = "\\"
    case Arg29 = "]"
    case Arg30 = "_"
    case Arg31 = "`"
}

public class ArgumentEncoding {

    static func ConvertArgumentCode(argumentCode: Character) -> Int {

        let asArgCode: ArgumentCode = ArgumentCode.init(rawValue: argumentCode)!

        switch (asArgCode) {
        case ArgumentCode.ArgNegOne:
            return -1;
        case ArgumentCode.Arg0:
            return 0;
        case ArgumentCode.Arg1:
            return 1;
        case ArgumentCode.Arg2:
            return 2;
        case ArgumentCode.Arg3:
            return 3;
        case ArgumentCode.Arg4:
            return 4;
        case ArgumentCode.Arg5:
            return 5;
        case ArgumentCode.Arg6:
            return 6;
        case ArgumentCode.Arg7:
            return 7;
        case ArgumentCode.Arg8:
            return 8;
        case ArgumentCode.Arg9:
            return 9;
        case ArgumentCode.Arg10:
            return 10;
        case ArgumentCode.Arg11:
            return 11;
        case ArgumentCode.Arg12:
            return 12;
        case ArgumentCode.Arg13:
            return 13;
        case ArgumentCode.Arg14:
            return 14;
        case ArgumentCode.Arg15:
            return 15;
        case ArgumentCode.Arg16:
            return 16;
        case ArgumentCode.Arg17:
            return 17;
        case ArgumentCode.Arg18:
            return 18;
        case ArgumentCode.Arg19:
            return 19;
        case ArgumentCode.Arg20:
            return 20;
        case ArgumentCode.Arg21:
            return 21;
        case ArgumentCode.Arg22:
            return 22;
        case ArgumentCode.Arg23:
            return 23;
        case ArgumentCode.Arg24:
            return 24;
        case ArgumentCode.Arg25:
            return 25;
        case ArgumentCode.Arg26:
            return 26;
        case ArgumentCode.Arg27:
            return 27;
        case ArgumentCode.Arg28:
            return 28;
        case ArgumentCode.Arg29:
            return 29;
        case ArgumentCode.Arg30:
            return 30;
        case ArgumentCode.Arg31:
            return 31;

        }

    }

    enum SwitchStatementError: Error {
        case NoMatchingCase

    }

    public static func IntToArgumentCode(integer: Int) throws -> ArgumentCode {
        switch (integer) {
        case -1:
            return ArgumentCode.ArgNegOne;
        case 0:
            return ArgumentCode.Arg0;
        case 1:
            return ArgumentCode.Arg1;
        case 2:
            return ArgumentCode.Arg2;
        case 3:
            return ArgumentCode.Arg3;
        case 4:
            return ArgumentCode.Arg4;
        case 5:
            return ArgumentCode.Arg5;
        case 6:
            return ArgumentCode.Arg6;
        case 7:
            return ArgumentCode.Arg7;
        case 8:
            return ArgumentCode.Arg8;
        case 9:
            return ArgumentCode.Arg9;
        case 10:
            return ArgumentCode.Arg10;
        case 11:
            return ArgumentCode.Arg11;
        case 12:
            return ArgumentCode.Arg12;
        case 13:
            return ArgumentCode.Arg13;
        case 14:
            return ArgumentCode.Arg14;
        case 15:
            return ArgumentCode.Arg15;
        case 16:
            return ArgumentCode.Arg16;
        case 17:
            return ArgumentCode.Arg17;
        case 18:
            return ArgumentCode.Arg18;
        case 19:
            return ArgumentCode.Arg19;
        case 20:
            return ArgumentCode.Arg20;
        case 21:
            return ArgumentCode.Arg21;
        case 22:
            return ArgumentCode.Arg22;
        case 23:
            return ArgumentCode.Arg23;
        case 24:
            return ArgumentCode.Arg24;
        case 25:
            return ArgumentCode.Arg25;
        case 26:
            return ArgumentCode.Arg26;
        case 27:
            return ArgumentCode.Arg27;
        case 28:
            return ArgumentCode.Arg28;
        case 29:
            return ArgumentCode.Arg29;
        case 30:
            return ArgumentCode.Arg30;
        case 31:
            return ArgumentCode.Arg31;
        default:
            throw SwitchStatementError.NoMatchingCase;
        }
    }


    static func IntToArgumentChar(integer: Int) throws -> Character {
        let temp = try IntToArgumentCode(integer: integer);

        let tempChar: Character = temp.rawValue
        return tempChar;
    }
    
    static func CharToByte(char: Character) -> UInt8 {
        var tempString = String(char);
        let array = tempString.utf8;
        let buffer = [UInt8](array);
        return buffer[0];
    }
}
