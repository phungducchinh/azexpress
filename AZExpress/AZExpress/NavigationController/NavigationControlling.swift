

import UIKit

protocol NavigationControlling: NSObjectProtocol {
    func setIndexForNextPushing(_ index: UInt?);
    func viewControllersCount() -> UInt;

    func replaceAll(_ viewControllers: [UIViewController], animated: Bool);

    func push(_ viewController: UIViewController, animated: Bool);
    func push(_ viewController: UIViewController, toIndex: UInt, animated: Bool);
    func push(_ viewController: UIViewController, replacePrevious numberPreviousViewControllers: UInt, animated: Bool);
    
    func isPopable() -> Bool;
    func pop(animated: Bool);
    func pop(to index: UInt, animated: Bool);
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool);
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?);
    func presentableViewControllerPresent(_ viewController: UIViewController, animated: Bool, completion: SimpleCallback?);
    
    func getViewController() -> UIViewController;
}
