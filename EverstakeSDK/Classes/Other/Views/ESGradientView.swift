//
//  ESGradientView.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 18.11.2020.
//

import UIKit

class ESGradientView: UIView {

    let gradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint (x: 1, y: 0.5)
        
        layer.insertSublayer(gradient, at: 0)
    }

    func setGradientColors(one: UIColor, two: UIColor) {
        gradient.colors = [one.cgColor, two.cgColor]
        gradient.isHidden = false
    }
    
    func showGradient(_ show: Bool) {
        gradient.isHidden = !show
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
    }

}
