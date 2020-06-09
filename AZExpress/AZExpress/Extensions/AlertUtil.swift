//
//  AlertUtil.swift
//  AZExpress
//
//  Created by Phung Duc Chinh on 6/9/20.
//  Copyright © 2020 Duc Chinh. All rights reserved.
//

import Foundation
import UIKit

typealias TextCallback = (_ content: String?) -> Void


class Alert {
    static let shared = Alert()
    
    init() {
        
    }
}

//MARK: - Show
extension Alert {
    func showInfo(title: String?, message: String? = nil, okTitle: String? = "OK", on viewController: UIViewController, callback: SimpleCallback?) {
        let alert = infoAlert(title: title, message: message, okTitle: okTitle, okAction: callback);
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showInputTextAlert(title: String?, message: String, okTitle: String?, cancelString: String?, on viewController: UIViewController, callback: TextCallback?){
        let alert = inputAlert(title: title, message: message, okTitle: okTitle, cancelString: cancelString, callback: callback)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func showConfirm(title: String?, message: String?, okTitle: String?, calcelTitle: String, on viewController: UIViewController, callbackOk: SimpleCallback?, callbackCancel: SimpleCallback?) {
        let alert = confirmAlert(title: title, message: message, okTitle: okTitle, cancelTitle: calcelTitle, okAction: callbackOk, cancelAction: callbackCancel)
        viewController.present(alert, animated: true, completion: nil)
    }

    
}

//MARK: - Factory
extension Alert {
    fileprivate func confirmAlert(title: String?, message: String?, okTitle: String?, cancelTitle: String? ,okAction: SimpleCallback?, cancelAction: SimpleCallback?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (_) in
            okAction?()
        }));
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (_) in
            cancelAction?()
        }));
        
        return alert;
    }
    
    fileprivate func infoAlert(title: String?, message: String?, okTitle: String?, okAction: SimpleCallback?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (_) in
            okAction?();
        }));
        
        return alert;
    }
    
    fileprivate func inputAlert(title: String?, message: String?, okTitle: String?, cancelString: String?, callback: TextCallback?) -> UIAlertController {
         let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
         var aTextField = UITextField()
        
        alert.addAction(UIAlertAction(title: cancelString ?? "Cancel", style: .cancel, handler: { (_) in
            callback?(nil);
        }));
        
        alert.addTextField { (textField) in
            aTextField = textField;
            aTextField.placeholder = "";
        }
        
        alert.addAction(UIAlertAction(title: okTitle ?? "OK", style: UIAlertAction.Style.default, handler:{
            [weak self] (UIAlertAction) in
            
            guard let _ = self else {return}
            callback?(aTextField.text);
            
        }))
        
        return alert;
    }
    
    fileprivate func customeAlert(title: String?, message: String?, okTitle: String?, okAction: SimpleCallback?, cancelTitle: String?, cancelAction: SimpleCallback?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (_) in
            okAction?();
        }));
        
        alert.addAction(UIAlertAction(title: cancelTitle, style: .default, handler: { (_) in
            cancelAction?();
        }));
        
        return alert;
    }
}
