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
