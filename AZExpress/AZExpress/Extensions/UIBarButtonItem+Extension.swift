//
//  UIBarButtonItem+Extension.swift
//  AZExpress
//
//  Created by TaNhi on 6/5/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem {
    convenience init(title: String, target: Any?, action: Selector?) {
        let button = UIBarButtonItem.customizedNavigationButton(with: title);
        if let target = target,
            let action = action {
            button.addTarget(target, action: action, for: .touchUpInside);
        }
        
        self.init(customView: button);
    }
    
    convenience init(backTitle title: String, target: Any?, action: Selector?) {
        let button = UIBarButtonItem.customizedNavigationButton(with: title, icon: UIImage(named: "nav-back")!);
        if let target = target,
            let action = action {
            button.addTarget(target, action: action, for: .touchUpInside);
        }
        
        self.init(customView: button);
    }
    
    convenience init(back target: Any?, action: Selector?) {
        self.init(backTitle: "Back", target: target, action: action);
    }
    
    convenience init(icon: UIImage?, tintColor: UIColor? = nil ,target: Any?, action: Selector?) {
        let button = UIBarButtonItem.customizedNavigationButton(with: icon);
        if let target = target,
            let action = action {
            button.addTarget(target, action: action, for: .touchUpInside);
        }
        button.tintColor = tintColor
        self.init(customView: button);
    }
    
//    convenience init(eventsBack target: Any?, action: Selector?) {
//        let button = UIBarButtonItem.customizedNavigationButton(with: "Events", icon: UIImage(named: "nav-back")!);
//        if let target = target,
//            let action = action {
//            button.addTarget(target, action: action, for: .touchUpInside);
//        }
//
//        self.init(customView: button);
//    }
//
    func fireActionOnMainThread() {
        guard let target = self.target,
            let action = self.action else {
                return;
        }
        
        target.performSelector(onMainThread: action, with: self, waitUntilDone: true);
    }
    
    static private func customizedNavigationButton(with title: String, icon: UIImage? = nil) -> UIButton {
        let button = UIButton(type: .custom);
        button.backgroundColor = .clear;
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.title = title;
        
        if let icon = icon {
            button.image = icon.withRenderingMode(.alwaysTemplate);
        }
        
        return button;
    }
    
    static private func customizedNavigationButton(with icon: UIImage?) -> UIButton {
        let button = UIButton(type: .custom);
        button.backgroundColor = .clear;
        button.image = icon?.withRenderingMode(.alwaysTemplate);
        
        return button;
    }
}
