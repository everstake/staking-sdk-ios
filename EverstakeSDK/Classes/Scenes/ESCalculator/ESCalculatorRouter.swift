//
//  ESCalculatorRouter.swift
//  Pods
//
//  Created by Alexander Koziaruk on 26.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ESCalculatorRoutingLogic {
    func selectValidator()
    func selectCurrency()
    func proceedToStakingWith(amount: Double)
}

protocol ESCalculatorDataPassing {
    var dataStore: ESCalculatorDataStore? { get }
}

class ESCalculatorRouter: NSObject, ESCalculatorRoutingLogic, ESCalculatorDataPassing {
    weak var viewController: ESCalculatorViewController?
    var dataStore: ESCalculatorDataStore?

    // MARK: Routing
    
    func proceedToStakingWith(amount: Double) {
        guard let model = dataStore?.model else { return }
        
        if model.stake != nil && model.coin.stakeType == .oneToMany {
            viewController?.presentAlertWith(title: "Stake", message: "Please unstake your funds first.")
        } else {
            let newStakeViewController = ESNewStakeConfigurator.viewControllerWith(model: model,
                                                                                   validator: dataStore?.selectedValidator,
                                                                                   amount: amount)
            viewController?.navigationController?.pushViewController(newStakeViewController,
                                                                     animated: true)
        }
    }
    
    func selectValidator() {
        guard let validators = dataStore?.model.coin.validators,
              let selectedValidator = dataStore?.selectedValidator else {
            return
        }
        
        let selectorController = ESValidatorSelectorViewController.createViewController()
        selectorController.validators = validators
        selectorController.selectedIds = Set<String>(arrayLiteral: selectedValidator.id ?? "")
        selectorController.multipleSelection = false
        selectorController.completedWith = { [weak self] selectedIds in
            self?.dataStore?.selectedValidator = validators.filter({ selectedIds.contains($0.id ?? "") }).first
        }
        
        viewController?.navigationController?.pushViewController(selectorController, animated: true)
    }

    func selectCurrency() {
        let currencyViewController = ESCurrencySelectorViewController.createViewController()
        currencyViewController.selectedId = dataStore?.model.coin.id
        currencyViewController.completedWith = { [weak self] selectedModel in
            if let selectedModel = selectedModel {
                self?.dataStore?.model = selectedModel
            }
        }
        
        viewController?.navigationController?.pushViewController(currencyViewController, animated: true)
    }
}
