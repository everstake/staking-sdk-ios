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
            self.coins = ESUtilities.decode([ESServerModel.Coin].self, from: data)
            self.completedDataLoad()
            self.loadStakeList()
        })
    }
    
    func loadStakeList() {
        guard let stakeRequestCoins = stakeRequestCoins else {
            return
        }
        
        let request = ESEverstakeList.StakeRequest(coins: stakeRequestCoins)
        worker.loadStakeList(request: request, successWith: { data in
            self.stakes = ESUtilities.decode([ESServerModel.Stake].self, from: data)
            self.addUserBalancesToStakes()
            self.completedDataLoad()
        })
    }
    
    func getCoinStakeWith(_ id: String, with action: ESEverstakeList.Action) {
        guard let coin = coins?.filter({ $0.id == id }).first else {
            return
        }

        let stake = stakes?.filter({ $0.coinId == id }).first
        
        let sharedModel = ESServerModel.Combined(coin: coin, stake: stake)
        presenter?.preparedShared(model: sharedModel, action: action)
    }
    
//MARK: Private
    
    private func addUserBalancesToStakes() {

        //TODO: Implement
//        guard let mapSymbolCoin = mapSymbolCoin else {
//            return
//        }
//
//        let balances = userCoins.reduce(into: [:]) {
//            $0[$1.symbol] = $1.balance
//        }
//
//        stakes?.forEach {
//            $0.balance = balances[$0.coinId]
//        }
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
        } ?? [String: ESServerModel.Stake]()
        
        presenter?.updateWith(coins: coinsMap, stakes: stakesMap)
        
        //Add user coins
        
        //Save data in shared data manager
        ESDataManager.shared.set(coins: coins, stakes: stakes)
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
