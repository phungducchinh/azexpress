

import Foundation

extension NSString {
    static let charMinus: unichar = "-".utf16.first!;
    static let charDot: unichar = ".".utf16.first!;
    static let char0: unichar = "0".utf16.first!;
    static let char9: unichar = "9".utf16.first!;
    
    func checkIsEnteringDecimal(fractionDigits: UInt?) -> Bool {
        if (length > 0) {
            var idx: Int = 0;
            
            var c = character(at: idx);
            if (c == NSString.charMinus) {
                idx += 1;
            }
            
            //before dot
            while (idx < length) {
                c = character(at: idx);
                idx += 1;
                
                if (c == NSString.charDot) {
                    break;
                    
                }else if (c < NSString.char0 || c > NSString.char9){
                    return false;
                }
            }
            //after dot
            var countFractionDigits = 0;
            while (idx < length) {
                countFractionDigits += 1;
                if let fractionDigits = fractionDigits,
                    countFractionDigits > fractionDigits {
                    return false;
                }
                
                c = character(at: idx);
                idx += 1;
                
                if (c == NSString.charDot) {
                    return false;
                    
                }else if (c < NSString.char0 || c > NSString.char9){
                    return false;
                }
            }
        }
        return true;
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    func isEmail() -> Bool {
        let pattern = "^([A-Za-z0-9+_\\.-]+)@([A-Za-z0-9_\\.-]+)\\.([a-zA-Z\\.]{2,6})$"
        let test = NSPredicate(format:"SELF MATCHES %@", pattern)
        return test.evaluate(with: self)
    }
    
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
