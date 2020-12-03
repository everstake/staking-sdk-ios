//
//  EverstakeSDK.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import Foundation
import UIKit

public class EverstakeSDK {
    
    public static let shared = EverstakeSDK()
    
    public var onStake: ((ESStake)->())?
    public var onUnstake: ((ESStake)->())?
    
    public func createViewControllerWith(coins: [ESUserCoin]) -> UIViewController {
        let viewController = ESEverstakeListConfigurator.setup(userCoins: coins)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
}

public struct ESStake {
    let symbol: String!
    
    //TODO: Implement
//    let address: String!
//    let validators: [ESValidator]
//
//    struct ESValidator {
//        var title: String!
//        var id: String!
//    }
}

public struct ESUserCoin {
    
    let symbol: String!
    let address: String!
    let balance: String!
    
    public init(symbol: String,
                address: String,
                balance: String) {
        self.symbol = symbol.lowercased()
        self.address = address
        self.balance = balance
    }
    
}
