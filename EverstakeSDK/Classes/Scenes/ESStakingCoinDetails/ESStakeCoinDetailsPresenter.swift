//
//  ESStakeCoinDetailsPresenter.swift
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

protocol ESStakeCoinDetailsPresentationLogic {
    func present(_ coin: ESEverstakeList.CoinModel)
}

class ESStakeCoinDetailsPresenter: ESStakeCoinDetailsPresentationLogic {
    
    weak var viewController: ESStakeCoinDetailsDisplayLogic?
  
// MARK: ESStakeCoinDetailsPresentationLogic
  
    func present(_ coin: ESEverstakeList.CoinModel) {
        
        var viewModel = ESStakeCoinDetails.ViewModel()
        viewModel.title = coin.title
        
        viewController?.updateWith(viewModel)
    }

}