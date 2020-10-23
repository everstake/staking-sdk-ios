//
//  EverstakeSDK.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import Foundation
import UIKit

public class EverstakeSDK {
    
    public static func createViewController() -> UIViewController {
        let viewController = EverstakeListConfigurator.setup()
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
}
