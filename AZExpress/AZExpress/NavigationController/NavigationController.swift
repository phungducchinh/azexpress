

import UIKit

protocol NavigationControllerDelegate: class {
    func navigationController(_ navigationController: NavigationController, willShow viewController: UIViewController, animated: Bool);
    func navigationController(_ navigationController: NavigationController, didShow viewController: UIViewController, animated: Bool);
}

class NavigationController: UINavigationController {
    weak var navigationControllerDelegate: NavigationControllerDelegate?;
    
    private var indexForNextPushing: UInt? = nil;
    
    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass);
        self.delegate = self;
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController);
        self.delegate = self;
    }
    
    init() {
        super.init(nibName: nil, bundle: nil);
        self.delegate = self;
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder);
        self.delegate = self;
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return viewControllers.last?.supportedInterfaceOrientations ?? .portrait;
    }
    
    func willShowViewController(_ viewController: UIViewController) {
    }
}

extension NavigationController: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        willShowViewController(viewController);
        
        if let delegate = navigationControllerDelegate,
            let navigationController = navigationController as? NavigationController {
            delegate.navigationController(navigationController, willShow: viewController, animated: animated);
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if let delegate = navigationControllerDelegate,
            let navigationController = navigationController as? NavigationController {
            delegate.navigationController(navigationController, didShow: viewController, animated: animated);
        }
    }
    
    func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return nil;
    }
}

//MARK: - NavigationControlling implementation
extension NavigationController: NavigationControlling {
    
    func setIndexForNextPushing(_ index: UInt?) {
        indexForNextPushing = index;
    }
    
    func viewControllersCount() -> UInt {
        return UInt(viewControllers.count);
    }
    
    func replaceAll(_ viewControllers: [UIViewController], animated: Bool) {
        setViewControllers(viewControllers, animated: animated);
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        guard let index = indexForNextPushing else {
            pushViewController(viewController, animated: animated);
            return;
        }
        
        indexForNextPushing  = nil;
        
        push(viewController, toIndex: index, animated: animated);
    }
    
    func push(_ viewController: UIViewController, toIndex: UInt, animated: Bool) {
        var newViewControllers = Array(viewControllers.prefix(upTo: Int(toIndex)));
        newViewControllers.append(viewController);
        
        setViewControllers(newViewControllers, animated: animated);
    }
    
    func push(_ viewController: UIViewController, replacePrevious numberPreviousViewControllers: UInt, animated: Bool) {
        var viewControllersArray = self.viewControllers;
        
        if numberPreviousViewControllers > 0 &&
            numberPreviousViewControllers <= viewControllersArray.count {
            viewControllersArray.removeLast(Int(numberPreviousViewControllers));
        }
        
        viewControllersArray.append(viewController);
        self.setViewControllers(viewControllersArray, animated: animated)
    }
    
    func isPopable() -> Bool {
        return viewControllers.count > 1;
    }
    
    func pop(to index: UInt, animated: Bool) {
        let count = viewControllers.count;
        guard index < count else {
            assertionFailure("index[\(index)] is out of bounds[\(count)].");
            return;
        }
        
        let targetViewController = viewControllers[Int(index)];
        popToViewController(targetViewController, animated: animated);
    }
    
    func pop(animated: Bool) {
        popViewController(animated: animated);
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool) {
        present(viewControllerToPresent, animated: flag, completion: nil);
    }
    
    func getViewController() -> UIViewController {
        return self;
    }
}
