//
//  SimpleAlert.swift
//  ShoppingBasket
//
//  Created by Mikhail Rostov on 28.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//
// Shows a simple alert, shorthand for UIAlertController

import UIKit

class SimpleAlert: NSObject {
    class func show(fromViewController: UIViewController, title: String, message : String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Alert Dialog Confirmation"), style: .default, handler: { (action) in
            
        }))
        fromViewController.present(alertController, animated: true, completion: nil)
    }
}
