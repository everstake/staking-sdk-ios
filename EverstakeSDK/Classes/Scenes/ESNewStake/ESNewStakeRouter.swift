//
//  ESNewStakeRouter.swift
//  Pods
//
//  Created by Alexander Koziaruk on 04.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ESNewStakeRoutingLogic {
    func selectValidator()
}

protocol ESNewStakeDataPassing {
    var dataStore: ESNewStakeDataStore? { get }
}

class ESNewStakeRouter: NSObject, ESNewStakeRoutingLogic, ESNewStakeDataPassing {
    
    weak var viewController: ESNewStakeViewController?
    var dataStore: ESNewStakeDataStore?

    // MARK: Routing
    
    func selectValidator() {
        
        guard let validators = dataStore?.model.coin.validators,
              let selectedValidators = dataStore?.selectedValidators,
              let type = dataStore?.model.coin.stakeType else {
            return
        }
        
        let selectorController = ESValidatorSelectorViewController.createViewController()
        selectorController.validators = validators
        selectorController.selectedIds = Set<String>(selectedValidators.map({ ($0.id ?? "") }))
        selectorController.multipleSelection = (type == .oneToMany)
        selectorController.completedWith = { [weak self] selectedIds in
            self?.dataStore?.selectedValidators = validators.filter({ selectedIds.contains($0.id ?? "") })
        }
        
        viewController?.navigationController?.pushViewController(selectorController, animated: true)
    }
}