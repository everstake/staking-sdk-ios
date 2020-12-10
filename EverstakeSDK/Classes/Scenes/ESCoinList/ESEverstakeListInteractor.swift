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
    var coins: [ESServerModel.Coin]? { get set }
    var stakes: [ESServerModel.Stake]? { get set }
    var userCoins: [ESUserCoin]! { get }
}

class ESEverstakeListInteractor: ESEverstakeListBusinessLogic, ESEverstakeListDataStore {
    
    let userCoins: [ESUserCoin]!
    
    var coins: [ESServerModel.Coin]?
    var stakes: [ESServerModel.Stake]?
    
    var presenter: ESEverstakeListPresentationLogic?
    var worker = ESEverstakeListWorker()
    
    init(userCoins: [ESUserCoin]) {
        self.userCoins = userCoins
    }
    
    func loadDataList() {
        worker.loadCoinList(successWith: { data in
            if let data = data {
                self.coins = ESUtilities.decode([ESServerModel.Coin].self, from: data)
                self.completedDataLoad()
                self.loadStakeList()
            } else if self.coins == nil {
                self.presenter?.unableToLoadData()
            }
        })
    }
    
    func loadStakeList() {
        guard let stakeRequestCoins = stakeRequestCoins else {
            return
        }
        
        let request = ESEverstakeList.StakeRequest(coins: stakeRequestCoins)
        worker.loadStakeList(request: request, successWith: { data in
            if let data = data {
                self.stakes = ESUtilities.decode([ESServerModel.Stake].self, from: data)
                self.completedDataLoad()
            }
        })
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
        } ?? [String: ESServerModel.Stake]()
        
        presenter?.updateWith(coins: coinsMap, stakes: stakesMap)
                
        //Save data in shared data manager
        ESDataManager.shared.set(coins: coins, stakes: stakes, userCoins: userCoins)
    }
    
    private var stakeRequestCoins: [ESEverstakeList.StakeRequest.Coin]? {
        guard let mapSymbolCoin = mapSymbolCoin else {
            return nil
        }
        let result: [ESEverstakeList.StakeRequest.Coin] = userCoins.reduce(into: []) { result, userCoin in
            if let serverCoin = mapSymbolCoin[userCoin.symbol.lowercased()] {
                result.append(ESEverstakeList.StakeRequest.Coin(coinId: serverCoin.id,
                                                                address: userCoin.address))
            }
        }
        return result
    }
    
    private var mapSymbolCoin: [String: ESServerModel.Coin]? {
        return coins?.reduce(into: [:]) { result, model in
            if let symbol = model.symbol {
                result?[symbol.lowercased()] = model
            }
        }
    }

}
