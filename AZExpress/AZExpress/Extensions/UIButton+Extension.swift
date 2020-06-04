
import UIKit

extension UIButton {
    var title: String? {
        get {
            return title(for: .normal);
        }
        set {
            setTitle(newValue, for: .normal);
        }
    }
    
    var textColor: UIColor? {
        get {
            return titleColor(for: .normal);
        }
        set {
            setTitleColor(newValue, for: .normal);
        }
    }
    
    var attributedTitle: NSAttributedString? {
        get {
            return attributedTitle(for: .normal);
        }
        set {
            setAttributedTitle(newValue, for: .normal);
        }
    }
    
    var image: UIImage? {
        get {
            return image(for: .normal);
        }
        set {
            setImage(newValue, for: .normal);
        }
    }
    
    var backgroundImage: UIImage? {
        get {
            return backgroundImage(for: .normal);
        }
        set {
            setBackgroundImage(newValue, for: .normal);
        }
    }
    
    // MARK: -
    
    func setShadow(shadowOpacity: CGFloat,shadowOffset: CGSize,shadowRadius: CGFloat,shadowColor: UIColor){
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = Float(shadowOpacity)
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
    }
    
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        if buttonType == .system {
            print("WARNING: Set Background for System Button [\(self)] will not correct.")
        }
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1);
        UIGraphicsBeginImageContext(rect.size);

        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor);
            context.fill(rect);
        }
        
        let colorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        self.setBackgroundImage(colorImage, for: forState);
    }
}
