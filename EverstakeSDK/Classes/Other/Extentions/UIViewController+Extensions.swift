//
//  UIViewController+Extentions.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 25.11.2020.
//

import Foundation

extension UIViewController {
    
    func presentAlertWith(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
    
}
