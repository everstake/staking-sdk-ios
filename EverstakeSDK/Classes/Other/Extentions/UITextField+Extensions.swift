//
//  UITextField+Extentions.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 26.11.2020.
//

import Foundation
import UIKit

extension UITextField {
    
    func addDoneButtonWith(width: CGFloat, target: Any, selector: Selector) {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: width, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                        target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done,
                                   target: target, action: selector)

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        inputAccessoryView = doneToolbar
    }
    
}
