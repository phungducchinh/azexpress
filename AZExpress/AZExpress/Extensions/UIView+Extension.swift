
import UIKit

extension UIView {
    
    //MARK: Finding
    
    func findNextResponder(withClass cls : AnyClass) -> UIResponder? {
        var current : UIResponder? = self;
        while let aCurrent = current {
            if aCurrent.isKind(of: cls) {
                return current;
            }
            
            current = aCurrent.next;
        }
        return nil;
    }
    
    func getSuperView(withClass cls: AnyClass) -> Any? {
        var obj = self.superview;
        while let anObj = obj {
            if anObj.isKind(of: cls) {
                return anObj;
                
            }else{
                obj = anObj.superview;
            }
        }
        return nil;
    }
    
    //MARK: Style
    
    func setBorder(color: UIColor?, lineW: CGFloat) {
        self.layer.borderColor = color?.cgColor;
        self.layer.borderWidth = lineW;
    }
    
    func setRoundary(radius: CGFloat) {
        self.clipsToBounds = true;
        self.layer.cornerRadius = radius;
    }
    
    func getRoundary() -> (clipsToBounds: Bool, radius: CGFloat) {
        return (clipsToBounds: self.clipsToBounds, radius: self.layer.cornerRadius);
    }
    
    func setShadow(color: UIColor, x: CGFloat, y: CGFloat, blur: CGFloat) {
        layer.shadowOffset = .init(width: x, height: y);
        layer.shadowRadius = blur;
        layer.shadowOpacity = 1;
        layer.shadowColor = color.cgColor;
        self.clipsToBounds = false;
    }
    
    //MARK: Others
    
    func removeAllConstraints() {
        removeConstraints(self.constraints);
    }
    
    func removeAllConstraintsIncludesSubviews() {
        removeAllConstraints();
        for subView in self.subviews {
            subView.removeAllConstraintsIncludesSubviews();
        }
    }
    
    func addSubview(_ subView: UIView, edge: UIEdgeInsets) {
        let frame = self.bounds.inset(by: edge);
        subView.frame = frame;
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        addSubview(subView);
    }
    
    func insertSubview(_ subView: UIView, edge: UIEdgeInsets, belowSubview: UIView) {
        let frame = self.bounds.inset(by: edge);
        subView.frame = frame;
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        insertSubview(subView, belowSubview: belowSubview);
    }
    
    func insertSubview(_ subView: UIView, edge: UIEdgeInsets, aboveSubview: UIView) {
        let frame = self.bounds.inset(by: edge);
        subView.frame = frame;
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight];
        insertSubview(subView, aboveSubview: aboveSubview);
    }
    
    func capture(afterScreenUpdates: Bool = true) -> UIImage? {
        return capture(scale: 0.0, afterScreenUpdates: afterScreenUpdates);
    }
    
    func capture(scale: CGFloat, afterScreenUpdates: Bool) -> UIImage? {
        let rect = CGRect(origin: .zero, size: frame.size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale);
        
        drawHierarchy(in: rect, afterScreenUpdates: afterScreenUpdates);
        
        let img = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return img;
    }
}

//MARK: - Animation
extension UIView {
    
    static func animate(_ animated: Bool, withDuration duration: TimeInterval, delay: TimeInterval, options: UIView.AnimationOptions = [], animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil) {
        
        if animated {
            self.animate(withDuration: duration, delay: delay, options: options, animations: animations, completion: completion);
        }else{
            animations();
            completion?(true);
        }
    }
    
    
    static func animate(_ animated: Bool, withDuration duration: TimeInterval, animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil) {
        
        if animated {
            self.animate(withDuration: duration, animations: animations, completion: completion);
        }else{
            animations();
            completion?(true);
        }
    }
    
    
    static func animate(_ animated: Bool, withDuration duration: TimeInterval, animations: @escaping () -> Swift.Void) {
        
        if animated {
            self.animate(withDuration: duration, animations: animations);
        }else{
            animations();
        }
    }
    
    static func animate(_ animated: Bool, withDuration duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIView.AnimationOptions = [], animations: @escaping () -> Swift.Void, completion: ((Bool) -> Swift.Void)? = nil) {
        
        if animated {
            self.animate(withDuration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: options, animations: animations, completion: completion);
        }else{
            animations();
            completion?(true);
        }
    }
}

extension UIView {
    func pushTransition(_ duration:CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .push
        animation.subtype = .fromTop
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
    
    func popTransition(_ duration:CFTimeInterval) {
        let animation:CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.type = .push
        animation.subtype = .fromBottom
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.push.rawValue)
    }
}
