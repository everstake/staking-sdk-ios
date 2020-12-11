//
//  ESButton.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 18.11.2020.
//

import UIKit

class ESButton: UIButton {

    override open var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(hex: "#CCCCCC") : UIColor.clear
        }
    }

}
