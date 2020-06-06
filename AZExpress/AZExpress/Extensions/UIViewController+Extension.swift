
import UIKit

extension UIViewController {
    
    func presentableViewController() -> UIViewController {
        var presentedViewController = self
        
        while let nextPresentedViewController = presentedViewController.presentedViewController {
            presentedViewController = nextPresentedViewController
        }
        
        return presentedViewController
    }
    
    func presentableViewControllerPresent(_ viewController: UIViewController, animated: Bool, completion: SimpleCallback?) {
        func tryToPresent() -> Bool{
            let presentedViewController = presentableViewController();
            if !presentedViewController.isBeingDismissed {
                presentedViewController.present(viewController, animated: true, completion: completion);
                return true;
            }
            return false;
        }
        
        if !tryToPresent() {
            var isPresented = false;
            DispatchQueue.global(qos: .utility).async {
                repeat{
                    usleep(useconds_t(1000000 * 0.1))
                    DispatchQueue.main.sync {
                        isPresented = tryToPresent();
                    }
                    
                }while(!isPresented)
            }
        }
    }
    
    func findPresentedViewController(_ viewControllerClass: AnyClass) -> UIViewController? {
        var presentedViewController = self;
        while let evalViewController = presentedViewController.presentedViewController {
            if evalViewController.isKind(of: viewControllerClass) {
                return presentedViewController;
            }
            
            presentedViewController = evalViewController;
        }
        return nil
    }

    func transition(from fromViewController: UIViewController?,
                    to toViewController: UIViewController?,
                    on view: UIView?,
                    edge: UIEdgeInsets,
                    duration: Double,
                    completion: SimpleCallback?) {
        let containerView = view ?? self.view!;
        
        fromViewController?.willMove(toParent: nil)
        toViewController?.willMove(toParent: self);
        
        if let toViewController = toViewController {
            addChild(toViewController)
            if let fromViewController = fromViewController {
                containerView.insertSubview(toViewController.view, edge: edge, belowSubview: fromViewController.view)
            }else{
                containerView.addSubview(toViewController.view, edge: edge)
            }
            
            toViewController.view.alpha = 0.0
        }
        
        func change() {
            toViewController?.view.alpha = 1.0
            //fromViewController?.view.alpha = 0.0
        }
        
        func finish() {
            fromViewController?.view.removeFromSuperview()
            fromViewController?.removeFromParent()
            
            fromViewController?.didMove(toParent: nil);
            toViewController?.didMove(toParent: self)
            
            completion?()
        }

        if duration == 0 {
            change();
            finish();
        }else{
            if let fromVC = fromViewController,
                let toVC = toViewController {
                transition(from: fromVC,
                           to: toVC,
                           duration: duration,
                           options: UIView.AnimationOptions(rawValue: 0), animations: {
                    change();
                }, completion: { (_) in
                    finish();
                })
            }else {
                UIView.animate(withDuration: duration,
                               delay: 0.0,
                               options: [],
                               animations: {
                                change()
                },
                               completion: { _ in
                                finish();
                })
            }
        }
    }
    
    
    func removeFromParentViewControllerEntirely() {
//        transition(from: self,
//                   to: nil,
//                   on: nil,
//                   edge: .zero,
//                   duration: ViewControllerTransitionDuration,
//                   completion: nil);
    }
}

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }

        return instantiateFromNib()
    }
}
