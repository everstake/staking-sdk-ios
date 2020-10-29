//
//  EverstakeListRouter.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListRoutingLogic {
    func routeToStakeCoinDetails(_ coin: ESEverstakeList.CoinModel)
}

class ESEverstakeListRouter: NSObject, ESEverstakeListRoutingLogic {
    weak var viewController: ESEverstakeListViewController?
    var dataStore: ESEverstakeListDataStore?

    // MARK: Routing

    func routeToStakeCoinDetails(_ coin: ESEverstakeList.CoinModel) {
        let detailsViewController = ESStakingCoinDetailsConfigurator.viewControllerWith(coin)
        viewController?.navigationController?.pushViewController(detailsViewController,
                                                                 animated: true)
    }
    
}
