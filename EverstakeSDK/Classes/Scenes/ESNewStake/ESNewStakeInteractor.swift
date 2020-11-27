//
//  ESNewStakeInteractor.swift
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

protocol ESNewStakeBusinessLogic {
    func loadData()
}

protocol ESNewStakeDataStore {
    var model: ESSharedModel.Combined { get set }
    var selectedValidators: [ESSharedModel.Validator] { get set }
}

class ESNewStakeInteractor: ESNewStakeBusinessLogic, ESNewStakeDataStore {
        
    var presenter: ESNewStakePresentationLogic?
    var worker: ESNewStakeWorker?
    
    var model: ESSharedModel.Combined
    var selectedValidators = [ESSharedModel.Validator]()
    var prefilledAmount: Double?
    
    init(model: ESSharedModel.Combined,
         validator: ESSharedModel.Validator? = nil,
         amount: Double? = nil) {
        
        self.model = model
        self.prefilledAmount = amount
        
        // Set default validators
        if let validator = validator {
            self.selectedValidators.append(validator)
        } else if let validators = model.stake?.validators {
            self.selectedValidators = validators
        } else if let validator = model.coin.validators?.first {
            self.selectedValidators.append(validator)
        }
    }
  
    func loadData() {
        presenter?.present(model,
                           selectedValidators: selectedValidators,
                           prefilledAmount: prefilledAmount)
    }
}
