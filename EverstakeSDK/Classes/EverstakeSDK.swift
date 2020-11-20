//
//  EverstakeSDK.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import Foundation
import UIKit

public class EverstakeSDK {
    
    public static func createViewControllerWith(coins: [ESCoin]) -> UIViewController {
        let viewController = ESEverstakeListConfigurator.setup(userCoins: coins)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
}

public struct ESCoin {
    
    let symbol: String!
    let address: String!
    let balance: String!
    
    public init(symbol: String,
                address: String,
                balance: String) {
        self.symbol = symbol
        self.address = address
        self.balance = balance
    }
    
}
