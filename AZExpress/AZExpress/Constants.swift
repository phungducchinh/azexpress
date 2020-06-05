import UIKit

func ScreenSize() -> CGSize {
    return UIScreen.main.bounds.size;
}

func isEmpty(val: String?) -> Bool {
    return !(val?.isEmpty == false);
}

func isPhone() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone;
}

func isPhone5() -> Bool {
    return Double(UIScreen.main.bounds.size.height - 568) < Double.ulpOfOne;
}

func isPhoneX() -> Bool {
    return UIScreen.main.bounds.size.height == 812;
}

func isPad() -> Bool {
    return UI_USER_INTERFACE_IDIOM() == .pad;
}

func ClassName(_ obj: Any) -> String{
    return String(describing: type(of: obj));
}

func AppIdPrefixed(_ string: String) -> String {
    return (Bundle.main.bundleIdentifier ?? "") + "." + string;
}

//MARK: CALLBACKs
typealias SimpleCallback = () -> Void
typealias SuccessCallback = (_ success: Bool) -> Void
typealias ErrorCallback = (_ error: Error?) -> Void

extension UIColor{
    static let appColor =  UIColor(red: 244/255, green: 115/255, blue: 32/255, alpha: 1)
    static let greenColor =  UIColor(red: 0/255, green: 173/255, blue: 94/255, alpha: 1)
    static let grayText =  UIColor(red: 194/255, green: 200/255, blue: 208/255, alpha: 1)
    static let borderBtn =  UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
}

enum JobType{
    case new
    case finish
}
