//
//  EverstakeListInteractor.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListBusinessLogic {
    func loadDataList()
    func getCoinStakeWith(_ id: String, with action: ESEverstakeList.Action)
}

protocol ESEverstakeListDataStore {
    var coins: [ESSharedModel.Coin]? { get set }
    var stakes: [ESSharedModel.Stake]? { get set }
}

class ESEverstakeListInteractor: ESEverstakeListBusinessLogic, ESEverstakeListDataStore {
    
    var coins: [ESSharedModel.Coin]?
    var stakes: [ESSharedModel.Stake]?
    
    var presenter: ESEverstakeListPresentationLogic?
    var worker = ESEverstakeListWorker()
    
    func loadDataList() {
        worker.loadCoinList(successWith: { data in
            self.coins = ESUtilities.decode([ESSharedModel.Coin].self, from: data)
            self.completedDataLoad()
        })
        
        worker.loadStakeList(successWith: { data in
            self.stakes = ESUtilities.decode([ESSharedModel.Stake].self, from: data)
            self.completedDataLoad()
        })
    }
    
    func getCoinStakeWith(_ id: String, with action: ESEverstakeList.Action) {
                
        guard let coin = coins?.filter({ $0.id == id }).first,
              let stake = stakes?.filter({ $0.coinId == id }).first  else {
            return
        }

        let sharedModel = ESSharedModel.Combined(coin: coin, stake: stake)
        presenter?.preparedShared(model: sharedModel, action: action)
    }
    
//MARK: Private
    
    private func completedDataLoad() {
        
        guard let coins = coins else {
            return
        }
        
        let coinsMap = coins.reduce(into: [:]) { result, model in
            result[model.id!] = model
        }
        
        let stakesMap = stakes?.reduce(into: [:]) { result, model in
            result[model.coinId!] = model
        } ?? [String: ESSharedModel.Stake]()
        
        presenter?.updateWith(coins: coinsMap, stakes: stakesMap)
    }
    
}
