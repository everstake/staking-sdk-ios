//
//  ESStakeCoinDetailsInteractor.swift
//  Pods
//
//  Created by Alexander Koziaruk on 29.10.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ESStakeCoinDetailsBusinessLogic {
    func getDisplayData()
}

protocol ESStakeCoinDetailsDataStore {
    var model: ESServerModel.Combined! { get set }
}

class ESStakeCoinDetailsInteractor: ESStakeCoinDetailsBusinessLogic, ESStakeCoinDetailsDataStore {

    var presenter: ESStakeCoinDetailsPresentationLogic?
    var worker: ESStakeCoinDetailsWorker?
    
    var model: ESServerModel.Combined!
    
    init(_ model: ESServerModel.Combined) {
        self.model = model
    }
    
// MARK: ESStakeCoinDetailsBusinessLogic
  
    func getDisplayData() {
        presenter?.present(model)
    }
    
}
