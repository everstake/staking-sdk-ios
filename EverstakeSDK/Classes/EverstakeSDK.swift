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
    
    public var onAction: ESActionHandler?
    
    public func createViewControllerWith(coins: [ESUserCoin]) -> UIViewController {
        let viewController = ESEverstakeListConfigurator.setup(userCoins: coins)
        viewController.modalPresentationStyle = .fullScreen
        return viewController
    }
    
}

public typealias ESActionHandler = ((_ action: ESAction,
                                     _ symbol: String,
                                     _ amount: String?,
                                     _ validators: [ESValidatorInfo])->())

public enum ESAction {
    case stake, unstake, claim
}

public struct ESValidatorInfo {
    let name: String!
    let address: String!
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
