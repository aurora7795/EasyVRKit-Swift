//
//  Protocols.swift
//  EasyVRKit
//
//  Created by Martin Bradford Gago on 08/03/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import Foundation


/**
 * Created by Martin Bradford Gago on 09/02/2017.
 */

public class Protocol {
    public static  let STS_MASK: Character = "k"; // mask of active groups <1-8>
    public static  let STS_COUNT: Character = "c"; // count of commands <1> (or number of ws <1>)
    public static  let STS_AWAKEN: Character = "w"; // back from power down mode
    public static  let STS_DATA: Character = "d"; // provide training <1>, conflict <2>, command label <3-35> (counted string)
    public static  let STS_ERROR: Character = "e"; // signal error code <1-2>
    public static  let STS_INVALID: Character = "v"; // invalid command or argument
    public static  let STS_TIMEOUT: Character = "t"; // timeout expired
    public static  let STS_LIPSYNC: Character = "l"; // lipsync stream follows
    public static   let STS_INTERR: Character = "i"; // back from aborted recognition (see 'break')
    public static   let STS_SUCCESS: Character = "o"; // no errors status
    public static  let STS_RESULT: Character = "r"; // recognised sd command <1> - training similar to sd <1>
    public static  let STS_SIMILAR: Character = "s"; // recognised si <1> (in mixed si/sd) - training similar to si <1>
    public static   let STS_OUT_OF_MEM: Character = "m"; // no more available commands (see 'group')
    public static  let STS_ID: Character = "x"; // provide version id <1>
    public static  let STS_PIN: Character = "p"; // return pin state <1>
    public static  let STS_TABLE_SX: Character = "h"; // table entries count <1-2> (10-bit), table name <3-35> (counted string)
    public static  let STS_GRAMMAR: Character = "z"; // si grammar: flags <1>, word count <2>, labels... <3-35> (n counted strings)
    public static  let STS_TOKEN: Character = "f"; // received sonicnet token <1-2>
    public static  let STS_MESSAGE: Character = "g"; // message status <1> (0=empty, 4/8=bits format), length <2-7>
    public static let CMD_BREAK: Character = "b"; // abort recog or ping
    public static  let CMD_SLEEP: Character = "s"; // go to power down
    public static  let CMD_KNOB: Character = "k"; // set si knob <1>
    public static  let CMD_MIC_DIST: Character = "k"; // set microphone (<1>=-1) distance <2>
    public static   let CMD_LEVEL: Character = "v"; // set sd level <1>
    public static  let CMD_VERIFY_RP: Character = "v"; // verify filesystem (<1>=-1) with flags <2> (0=check only, 1=fix)
    public static  let CMD_LANGUAGE: Character = "l"; // set si language <1>
    public static  let CMD_LIPSYNC: Character = "l"; // start real-time lipsync (<1>=-1) with threshold <2-3>, timeout <4-5>
    public static  let CMD_TIMEOUT: Character = "o"; // set timeout <1>
    public static   let CMD_RECOG_SI: Character = "i"; // do si recog from ws <1>
    public static    let CMD_TRAIN_SD: Character = "t"; // train sd command at group <1> pos <2>
    public static   let CMD_TRAILING: Character = "t"; // set trailing (<1>=-1) silence <2> (0-31 = 100-875 milliseconds)
    public static   let CMD_GROUP_SD: Character = "g"; // insert new command at group <1> pos <2>
    public static  let CMD_UNGROUP_SD: Character = "u"; // remove command at group <1> pos <2>
    public static  let CMD_RECOG_SD: Character = "d"; // do sd recog at group <1> (0 = trigger mixed si/sd)
    public static  let CMD_DUMP_RP: Character = "d"; // dump message (<1>=-1) at pos <2>
    public static  let CMD_ERASE_SD: Character = "e"; // reset command at group <1> pos <2>
    public static   let CMD_ERASE_RP: Character = "e"; // erase recording (<1>=-1) at pos <2>
    public static   let CMD_NAME_SD: Character = "n"; // label command at group <1> pos <2> with length <3> name <4-n>
    public static    let CMD_COUNT_SD: Character = "c"; // get command count for group <1>
    public static    let CMD_DUMP_SD: Character = "p"; // read command data at group <1> pos <2>
    public static    let CMD_PLAY_RP: Character = "p"; // play recording (<1>=-1) at pos <2> with flags <3>
    public static   let CMD_MASK_SD: Character = "m"; // get active group mask
    public static   let CMD_RESETALL: Character = "r"; // reset all memory (commands/groups and messages), with <1>='R'
    public static   let CMD_RESET_SD: Character = "r"; // reset only commands/groups, with <1>='D'
    public static   let CMD_RESET_RP: Character = "r"; // reset only messages, with <1>='M'
    public static    let CMD_RECORD_RP: Character = "r"; // record message (<1>=-1) at pos <2> with bits <3> and timeout <4>
    public static    let CMD_ID: Character = "x"; // get version id
    public static    let CMD_DELAY: Character = "y"; // set transmit delay <1> (log scale)
    public static    let CMD_BAUDRATE: Character = "a"; // set baudrate <1> (bit time, 1=>115200)
    public static   let CMD_QUERY_IO: Character = "q"; // configure, read or write I/O pin <1> of type <2>
    public static  let CMD_PLAY_SX: Character = "w"; // wave table entry <1-2> (10-bit) playback at volume <3>
    public static let CMD_PLAY_DTMF: Character = "w"; // play (<1>=-1) dial tone <2> for duration <3>
    public static   let CMD_DUMP_SX: Character = "h"; // dump wave table entries
    public static   let CMD_DUMP_SI: Character = "z"; // dump si settings for ws <1> (or total ws count if -1)
    public static   let CMD_SEND_SN: Character = "j"; // send sonicnet token with bits <1> index <2-3> at time <4-5>
    public static   let CMD_RECV_SN: Character = "f"; // receive sonicnet token with bits <1> rejection <2> timeout <3-4>
    public static  let CMD_FAST_SD: Character = "f"; // set sd/sv (<1>=-1) to use fast recognition <2> (0=normal/default, 1=fast)
    public static  let CMD_SERVICE: Character = "~"; // send service request
    public static   let SVC_EXPORT_SD: Character = "X"; // request export of command <2> in group <1> as raw dump
    public static   let SVC_IMPORT_SD: Character = "I"; // request import of command <2> in group <1> as raw dump
    public static    let SVC_VERIFY_SD: Character = "V"; // verify training of imported raw command <2> in group <1>
    public static   let STS_SERVICE: Character = "~"; // get service reply
    public static   let SVC_DUMP_SD: Character = "D"; // provide raw command data <1-512> followed by checksum <513-516>
    // protocol arguments are in the range 0x40 (-1) to 0x60 (+31) inclusive
    public static let ARG_MIN: Int = 0x40;
    public static let ARG_MAX: Int = 0x60;
    public static let ARG_ZERO: Int = 0x41;
    public static let ARG_ACK: Int = 0x20; // to read more status arguments
    
    /**
     * Language to use for recognition of built-in words
     */
    
    public enum Language: Int {
        case ENGLISH = 0 //*< Uses the US English word sets
        case ITALIAN = 1 //*< Uses the Italian word sets
        case JAPANESE = 2 //*< Uses the Japanese word sets
        case GERMAN = 3 //*< Uses the German word sets
        case SPANISH = 4 //*< Uses the Spanish word sets
        case FRENCH = 5 //*< Uses the French word sets
    }
    
    /**
     * Special group numbers for recognition of custom commands
     */
    
    public enum Group: Int {
        case TRIGGER = 0 //*< The trigger group (shared with built-in trigger word)
        case PASSWORD = 16 //*< The password group (uses speaker verification technology)
        
    }
    
    /**
     * Index of built-in word sets
     */
    
    public enum Wordset: Int {
        case TRIGGER_SET = 0 //*< The built-in trigger word set
        case ACTION_SET = 1  //*< The built-in action word set
        case DIRECTION_SET = 2 //*< The built-in direction word set
        case NUMBER_SET = 3 //*< The built-in number word set
    }
    
    /**
     * Microphone distance from the user's mouth,
     * used by all recognition technologies
     */
    
    public enum Distance: Int {
        case
        HEADSET = 1, //*< Nearest range (around 5cm)
        ARMS_LENGTH, //*< Medium range (from about 50cm to 1m)
        FAR_MIC //*< Farthest range (up to 3m)
        
    }
    
    /**
     * Confidence thresholds for the knob settings,
     * used for recognition of built-in words or custom grammars
     * (not used for the mixed trigger group)
     */
    
    public enum Knob: Int {
        case
        LOOSER = 0, //*< Lowest threshold, most results reported
        LOOSE, //*< Lower threshold, more results reported
        TYPICAL, //*< Typical threshold (default)
        STRICT, //*< Higher threshold, fewer results reported
        STRICTER //*< Highest threshold, fewest results reported
        
    }
    
    /**
     * Strictness values for the level settings,
     * used for recognition of custom commands
     * (not used for the mixed trigger group)
     */
    
    public enum Level: Int {
        case
        EASY = 1, //*< Lowest value, most results reported
        NORMAL, //*< Typical value (default)
        HARD, //*< Slightly higher value, fewer results reported
        HARDER, //*< Higher value, fewer results reported
        HARDEST; //*< Highest value, fewest results reported
        
        
    }
    
    /**
     * Trailing silence settings used for recognition of built-in words or
     * custom grammars (including the mixed trigger group), in a range from
     * 100ms to 875ms in steps of 25ms.
     */
    
    public enum TrailingSilence: Int {
        
        case TRAILING_MAX = 31 //*< Highest value (875ms), maximum latency
        case TRAILING_100MS = 0 //*< Silence duration is 100ms (Lowest)
        case TRAILING_200MS = 4 //*< Silence duration is 200ms
        case TRAILING_300MS = 8 //*< Silence duration is 300ms
        case TRAILING_400MS = 12 //*< Silence duration is 400ms (Default)
        case TRAILING_500MS = 16 //*< Silence duration is 500ms
        case TRAILING_600MS = 20 //*< Silence duration is 600ms
        case TRAILING_700MS = 24 //*< Silence duration is 700ms
        case TRAILING_800MS = 28 //*< Silence duration is 800ms
        
    }
    
    /**
     * Latency settings used for recognition of custom commands or passwords
     * (excluding the mixed trigger group)
     */
    
    public enum CommandLatency: Int {
        case
        MODE_NORMAL = 0, //*< Normal settings (default), higher latency
        MODE_FAST; //*< Fast settings, better response time
        
    }
    
    /**
     * Constants to use for baudrate settings
     */
    
    public enum Baudrate: Int {
        case B115200 = 1 //*< 115200 bps
        case B57600 = 2 //*< 57600 bps
        case B38400 = 3 //*< 38400 bps
        case B19200 = 6 //*< 19200 bps
        case B9600 = 12 //*< 9600 bps (default)
    }
    
    /**
     * constants for choosing wake-up method in sleep mode
     */
    
    public enum WakeMode: Int {
        case
        WAKE_ON_CHAR, //*< Wake up on any character received
        WAKE_ON_WHISTLE, //*< Wake up on whistle or any character received
        WAKE_ON_LOUDSOUND, //*< Wake up on a loud sound or any character received
        WAKE_ON_2CLAPS_LOW, //*< Wake up on double hands-clap or any character received (Low Sensitivity)
        WAKE_ON_2CLAPS_MID, //*< Wake up on double hands-clap or any character received (Medium Sensitivity)
        WAKE_ON_2CLAPS_HIGH, //*< Wake up on double hands-clap or any character received (High Sensitivity)
        WAKE_ON_3CLAPS_LOW, //*< Wake up on triple hands-clap or any character received (Low Sensitivity)
        WAKE_ON_3CLAPS_MID, //*< Wake up on triple hands-clap or any character received (Medium Sensitivity)
        WAKE_ON_3CLAPS_HIGH; //*< Wake up on triple hands-clap or any character received (High Sensitivity)
        
    }
    
    /**
     * Hands-clap sensitivity for wakeup from sleep mode.
     * Use in combination with #WAKE_ON_2CLAPS or #WAKE_ON_3CLAPS
     */
    
    public enum ClapSense: Int {
        case
        CLAP_SENSE_LOW, //*< Lowest threshold
        CLAP_SENSE_MID, //*< Typical threshold
        CLAP_SENSE_HIGH //*< Highest threshold
        
    }
    
    /**
     * Pin configuration options for the extra I/O connector
     */
    
    public enum PinConfig: Int {
        case
        OUTPUT_LOW, //*< Pin is a low output (0V)
        OUTPUT_HIGH, //*< Pin is a high output (3V)
        INPUT_HIZ, //*< Pin is an high impedance input
        INPUT_STRONG, //*< Pin is an input with strong pull-up (~10K)
        INPUT_WEAK //*< Pin is an input with weak pull-up (~200K)
        
    }
    
    /**
     * Available pin numbers on the extra I/O connector
     */
    
    public enum PinNumber: Int {
        case
        IO1 = 1, //*< Identifier of pin IO1
        IO2, //*< Identifier of pin IO2
        IO3, //*< Identifier of pin IO3
        IO4, //*< Identifier of pin IO4 (only EasyVR3)
        IO5, //*< Identifier of pin IO5 (only EasyVR3)
        IO6     //*< Identifier of pin IO6 (only EasyVR3)
        
    }
    
    /**
     * Some quick volume settings for the sound playback functions
     * (any value in the range 0-31 can be used)
     */
    
    public enum SoundVolume: Int {
        case VOL_MIN = 0 //*< Lowest volume (almost mute)
        case VOL_HALF = 7 //*< Half scale volume (softer)
        case VOL_FULL = 15 //*< Full scale volume (normal)
        case VOL_DOUBLE = 31 //*< Double gain volume (louder)
        
    }
    
    /**
     * Special sound index values, always available even when no soundtable is present
     */
    
    public enum SoundIndex {
        case BEEP //*< Beep sound
    }
    
    /**
     * Flags used by custom grammars
     */
    
    public enum GrammarFlag: Int {
        case GF_TRIGGER = 0x10 //*< A bit mask that indicate grammar is a trigger (opposed to commands)
        
    }
    
    /**
     * Noise rejection level for SonicNet token detection (higher value, fewer results)
     */
    
    public enum RejectionLevel: Int {
        case
        REJECTION_MIN, //*< Lowest noise rejection, highest sensitivity
        REJECTION_AVG, //*< Medium noise rejection, medium sensitivity
        REJECTION_MAX; //*< Highest noise rejection, lowest sensitivity
        
    }
    
    /**
     * Playback speed for recorded messages
     */
    
    public enum MessageSpeed: Int {
        case
        SPEED_NORMAL, //*< Normal playback speed
        SPEED_FASTER; //*< Faster playback speed
        
    }
    
    /**
     * Playback attenuation for recorded messages
     */
    
    public enum MessageAttenuation: Int {
        case
        ATTEN_NONE, //*< No attenuation (normalized volume)
        ATTEN_2DB2, //*< Attenuation of -2.2dB
        ATTEN_4DB5, //*< Attenuation of -4.5dB
        ATTEN_6DB7; //*< Attenuation of -6.7dB
        
    }
    
    /**
     * Type of recorded message
     */
    
    public enum MessageType: Int {
        case MSG_EMPTY = 0 //*< Empty message slot
        case MSG_8BIT = 8 //*< Message recorded with 8-bits PCM
    }
    
    /**
     * Threshold for real-time lip-sync
     */
    
    public enum LipsyncThreshold: Int {
        case RTLS_THRESHOLD_DEF = 270 //*< Default threshold
        case RTLS_THRESHOLD_MAX = 1023; //*< Maximum threshold
    }
    
    /**
     * Error codes used by various functions
     */
    
    public enum ErrorCode: Int {
        //-- 0x: Data collection errors (patgen, wordspot, t2si)
        case ERR_DATACOL_TOO_LONG = 0x02 //*< too long (memory overflow)
        case ERR_DATACOL_TOO_NOISY = 0x03 //*< too noisy
        case ERR_DATACOL_TOO_SOFT = 0x04 //*< spoke too soft
        case ERR_DATACOL_TOO_LOUD = 0x05 //*< spoke too loud
        case ERR_DATACOL_TOO_SOON = 0x06 //*< spoke too soon
        case ERR_DATACOL_TOO_CHOPPY = 0x07 //*< too many segments/too complex
        case ERR_DATACOL_BAD_WEIGHTS = 0x08 //*< invalid SI weights
        case ERR_DATACOL_BAD_SETUP = 0x09 //*< invalid setup
        
        //-- 1x: Recognition errors (si, sd, sv, train, t2si)
        case ERR_RECOG_FAIL = 0x11 //*< recognition failed
        case ERR_RECOG_LOW_CONF = 0x12 //*< recognition result doubtful
        case ERR_RECOG_MID_CONF = 0x13 //*< recognition result maybe
        case ERR_RECOG_BAD_TEMPLATE = 0x14 //*< invalid SD/SV template
        case ERR_RECOG_BAD_WEIGHTS = 0x15 //*< invalid SI weights
        case ERR_RECOG_DURATION = 0x17 //*< incompatible pattern durations
        
        //-- 2x: T2si errors (t2si)
        case ERR_T2SI_EXCESS_STATES = 0x21 //*< state structure is too big
        case ERR_T2SI_BAD_VERSION = 0x22 //*< RSC code version/Grammar ROM dont match
        case ERR_T2SI_OUT_OF_RAM = 0x23 //*< reached limit of available RAM
        case ERR_T2SI_UNEXPECTED = 0x24 //*< an unexpected error occurred
        case ERR_T2SI_OVERFLOW = 0x25 //*< ran out of time to process
        case ERR_T2SI_PARAMETER = 0x26 //*< bad macro or grammar parameter
        
        case ERR_T2SI_NN_TOO_BIG = 0x29 //*< layer size out of limits
        case ERR_T2SI_NN_BAD_VERSION = 0x2A //*< net structure incompatibility
        case ERR_T2SI_NN_NOT_READY = 0x2B //*< initialization not complete
        case ERR_T2SI_NN_BAD_LAYERS = 0x2C //*< not correct number of layers
        
        case ERR_T2SI_TRIG_OOV = 0x2D //*< trigger recognized Out Of Vocabulary
        case ERR_T2SI_TOO_SHORT = 0x2F //*< utterance was too short
        
        //-- 3x: Record and Play errors (standard RP and messaging)
        case ERR_RP_BAD_LEVEL = 0x31 //*<  play - illegal compression level
        case ERR_RP_NO_MSG = 0x38 //*<  play, erase, copy - msg doesn't exist
        case ERR_RP_MSG_EXISTS = 0x39 //*<  rec, copy - msg already exists
        
        //-- 4x: Synthesis errors (talk, sxtalk)
        case ERR_SYNTH_BAD_VERSION = 0x4A //*< bad release number in speech file
        case ERR_SYNTH_ID_NOT_SET = 0x4B //*< (obsolete) bad sentence structure
        case ERR_SYNTH_TOO_MANY_TABLES = 0x4C //*< (obsolete) too many talk tables
        case ERR_SYNTH_BAD_SEN = 0x4D //*< (obsolete) bad sentence number
        case ERR_SYNTH_BAD_MSG = 0x4E //*< bad message data or SX technology files missing
        
        //-- 8x: Custom errors
        case ERR_CUSTOM_NOTA = 0x80 //*< none of the above (out of grammar)
        case ERR_CUSTOM_INVALID = 0x81 //*< invalid data (for memory check)
        
        //-- Cx: Internal errors (all)
        case ERR_SW_STACK_OVERFLOW = 0xC0 //*< no room left in software stack
        case ERR_INTERNAL_T2SI_BAD_SETUP = 0xCC //*< T2SI test mode error
    }
    
    /**
     * Type of Bridge mode requested
     */
    
    public enum BridgeMode: Int {
        
        case
        BRIDGE_NONE, //*< Bridge mode has not been requested
        BRIDGE_NORMAL, //*< Normal bridge mode (EasyVR baudrate 9600)
        BRIDGE_BOOT; //*< Bridge mode for EasyVR bootloader (baudrate 115200)
        
    }
    
    public enum BitNumber: Int {
        case
        BITS_4 = 4,
        BITS_8 = 8;
        
    }
    
}



