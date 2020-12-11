//
//  Slider+Extentions.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 17.11.2020.
//

import Foundation
import SliderController

extension SliderController {
    
    func setupSlider() {
        self.unselectedTrackColor = UIColor(hex: "#CCCCCC")!
        self.selectedTrackColor = .black
        self.unselectedAnchorColor = UIColor(hex: "#CCCCCC")!
        self.selectedAnchorColor = .black
        self.anchors = [0, 0.25, 0.5, 0.75, 1]
        self.anchorRadius = 6
        self.trackHeight = 6
        self.view.clipsToBounds = false
    }
    
    func embedSliderIn(targetView: UIView, targetViewController: UIViewController) {
        targetViewController.addChildViewController(self.controller)
        targetView.addSubview(self.controller.view)
        self.controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.controller.view.topAnchor.constraint(equalTo: targetView.topAnchor).isActive = true
        self.controller.view.leftAnchor.constraint(equalTo: targetView.leftAnchor).isActive = true
        self.controller.view.rightAnchor.constraint(equalTo: targetView.rightAnchor).isActive = true
        self.controller.view.bottomAnchor.constraint(equalTo: targetView.bottomAnchor).isActive = true
        self.controller.didMove(toParentViewController: self)
    }
    
}
