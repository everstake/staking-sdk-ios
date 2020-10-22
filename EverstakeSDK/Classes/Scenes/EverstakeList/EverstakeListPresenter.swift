//
//  EverstakeListPresenter.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol EverstakeListPresentationLogic {
    func present(_ coins: [EverstakeList.Coin])
}

class EverstakeListPresenter: EverstakeListPresentationLogic {
    weak var viewController: EverstakeListDisplayLogic?
  
// MARK: Do something
  
    func present(_ coins: [EverstakeList.Coin]) {
        let viewModel = EverstakeList.ViewModel(coins: coins)
        viewController?.display(viewModel: viewModel)
    }
}
