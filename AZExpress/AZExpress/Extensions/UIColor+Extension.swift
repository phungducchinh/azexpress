
import UIKit

extension UIColor {
    convenience init(hex: UInt, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(hex & 0x0000FF) / 255.0,
            alpha: alpha)
    }
    
    //TODO: it's may not correct.
    func toTintColor() -> UIColor {
        var red: CGFloat = 0;
        var green: CGFloat = 0;
        var blue: CGFloat = 0;
        var alpha: CGFloat = 0;
        guard getRed(&red, green: &green, blue: &blue, alpha: &alpha) else {
            return self;
        }
        
        let delta: CGFloat = 0.12;
        
        red = min(red + delta, 1.0)
        green = min(green + delta, 1.0)
        blue = min(blue + delta, 1.0)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha);
    }
}
