//
//  EverstakeListInteractor.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol EverstakeListBusinessLogic {
    func loadDataList()
}

protocol EverstakeListDataStore {
    //var name: String { get set }
}

class EverstakeListInteractor: EverstakeListBusinessLogic, EverstakeListDataStore {
    var presenter: EverstakeListPresentationLogic?
    var worker: EverstakeListWorker?
    
    func loadDataList() {
        worker = EverstakeListWorker()
        worker?.loadStakingList(successWith: { (coins) in
            self.presenter?.present(coins)
        }, failedWith: { (error) in
            //TODO: handle error
        })
        
    }
}
