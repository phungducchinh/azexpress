
import UIKit

class BaseVC: UIViewController {
    deinit {
        print("DEINIT>> [\(self.classForCoder)]")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("Showing>> [\(self.classForCoder)]")
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait;
    }
    
    func onKeyboardBeginChangeFrame(_ frame: (begin: CGRect, end: CGRect), bottomHeight: (begin: CGFloat, end: CGFloat), animation: (duration: TimeInterval, curve: UIView.AnimationCurve)) {};
    func onKeyboardEndChangeFrame(_ frame: (begin: CGRect, end: CGRect), bottomHeight: (begin: CGFloat, end: CGFloat)) {}
}

//MARK: - Keyboard
extension BaseVC {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    func registerKeyboardChangeFrameNotification() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(onKeyboardWillChangeFrame(_:)),
                         name: UIResponder.keyboardWillChangeFrameNotification,
                         object: nil);
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(onKeyboardDidChangeFrame(_:)),
                         name: UIResponder.keyboardDidChangeFrameNotification,
                         object: nil);
    }
    
    func unRegisterKeyboardFrameStatusNotification() {
        NotificationCenter
            .default
            .removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil);
        
        NotificationCenter
            .default
            .removeObserver(self, name: UIResponder.keyboardDidChangeFrameNotification, object: nil);
    }
    
    func setDismissKeyboardOnTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(onDismissKeyboardTapping(_:)));
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap);
    }
    
    @objc private func onKeyboardWillChangeFrame(_ notification: Notification) {
        guard let info = notification.userInfo,
            let beginFrame = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect?,
            let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect? else {
                return;
        }
        
        func bottomHeight(for frame: CGRect) -> CGFloat {
            if frame.origin.y == 0 && frame.size.height == 0 {
                return 0;
            }
            
            return UIScreen.main.bounds.size.height - frame.origin.y;
        }
        
        let beginBottomHeight = bottomHeight(for: beginFrame);
        let endBottomHeight = bottomHeight(for: endFrame);
        
        let duration = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval? ?? 0;
        let curve: UIView.AnimationCurve;
        if let curveInt = (info[UIResponder.keyboardAnimationCurveUserInfoKey] as! NSNumber?)?.intValue  {
            curve = UIView.AnimationCurve(rawValue: curveInt) ?? .linear;
        }else {
            curve = .linear;
        }
        
        onKeyboardBeginChangeFrame((beginFrame, endFrame),
                                   bottomHeight: (beginBottomHeight, endBottomHeight),
                                   animation: (duration, curve));
    }
    
    @objc private func onKeyboardDidChangeFrame(_ notification: Notification) {
        guard let info = notification.userInfo,
            let beginFrame = info[UIResponder.keyboardFrameBeginUserInfoKey] as! CGRect?,
            let endFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect? else {
                return;
        }
        
        func bottomHeight(for frame: CGRect) -> CGFloat {
            if frame.origin.y == 0 && frame.size.height == 0 {
                return 0;
            }
            
            return UIScreen.main.bounds.size.height - frame.origin.y;
        }
        
        let beginBottomHeight = bottomHeight(for: beginFrame);
        let endBottomHeight = bottomHeight(for: endFrame);
        
        onKeyboardEndChangeFrame((beginFrame, endFrame),
                                 bottomHeight: (beginBottomHeight, endBottomHeight));
    }
    
    @objc private func onDismissKeyboardTapping(_ sender: Any) {
        view.endEditing(false);
    }
    
    func presentViewController(_ vc: UIViewController, animated: Bool) {
        let nav = UINavigationController(rootViewController: vc)
        //Set Navigation
        nav.navigationBar.backgroundColor = .appColor
        nav.navigationBar.tintColor = .white
        nav.navigationBar.isTranslucent = false
        nav.navigationBar.barTintColor = .appColor
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let backBtn = UIButton()
        backBtn.title = ""
        backBtn.image = UIImage.init(named: "ic_arrow_left")
        backBtn.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        nav.navigationBar.topItem?.leftBarButtonItem = UIBarButtonItem.init(customView: backBtn)
//        self.view.backgroundColor = UIColor(named: "Background")
        nav.modalPresentationStyle = .fullScreen
        
        if vc is CaptureVC{
            nav.navigationBar.backgroundColor = .clear
            nav.navigationBar.barTintColor = .clear
        }
        
        self.present(nav, animated: animated, completion: nil)
    }
    
    @objc func dismissVC(sender: Any?) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
