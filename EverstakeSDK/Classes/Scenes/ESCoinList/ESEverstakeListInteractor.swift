//
//  EverstakeListInteractor.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListBusinessLogic {
    func loadDataList()
}

protocol ESEverstakeListDataStore {
    var coins: [ESEverstakeList.Response.Coin]? { get set }
    var stakes: [ESEverstakeList.Response.Stake]? { get set }
}

class ESEverstakeListInteractor: ESEverstakeListBusinessLogic, ESEverstakeListDataStore {
    
    var coins: [ESEverstakeList.Response.Coin]?
    var stakes: [ESEverstakeList.Response.Stake]?
    
    var presenter: ESEverstakeListPresentationLogic?
    var worker = ESEverstakeListWorker()
    
    func loadDataList() {
        worker.loadCoinList(successWith: { data in
            self.coins = ESUtilities.decode([ESEverstakeList.Response.Coin].self, from: data)
            self.completedDataLoad()
        })
        
        worker.loadStakeList(successWith: { data in
            self.stakes = ESUtilities.decode([ESEverstakeList.Response.Stake].self, from: data)
            self.completedDataLoad()
        })
    }
    
    private func completedDataLoad() {
        
        guard let coins = coins else {
            return
        }
        
        let coinsMap = coins.reduce(into: [:]) { result, model in
            result[model.id!] = model
        }
        
        let stakesMap = stakes?.reduce(into: [:]) { result, model in
            result[model.coinId!] = model
        } ?? [String: ESEverstakeList.Response.Stake]()
        
        presenter?.updateWith(coins: coinsMap, stakes: stakesMap)
    }
    
}
