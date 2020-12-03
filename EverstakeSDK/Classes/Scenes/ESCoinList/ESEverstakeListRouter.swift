//
//  EverstakeListRouter.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListRoutingLogic {
    func routeToStakeCoinDetailsWith(id: String)
}

class ESEverstakeListRouter: NSObject, ESEverstakeListRoutingLogic {
    weak var viewController: ESEverstakeListViewController?
    var dataStore: ESEverstakeListDataStore?

    // MARK: Routing

    func routeToStakeCoinDetailsWith(id: String) {
        
        guard let model = ESDataManager.shared.getModelWith(id: id) else {
            return
        }
        
        let detailsViewController = ESStakingCoinDetailsConfigurator.viewControllerWith(model)
        viewController?.navigationController?.pushViewController(detailsViewController,
                                                                 animated: true)
    }
    
}
