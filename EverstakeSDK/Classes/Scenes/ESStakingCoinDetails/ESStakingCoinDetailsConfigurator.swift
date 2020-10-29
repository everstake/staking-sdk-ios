//
//  ESStakingCoinDetailsConfigurator.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import Foundation
import UIKit

class ESStakingCoinDetailsConfigurator {
       
    public static func viewControllerWith(_ coin: ESEverstakeList.CoinModel) -> UIViewController {
        let viewController = ESStakeCoinDetailsViewController(nibName: "ESStakeCoinDetailsViewController",
                                                              bundle: ESUtilities.shared.bundle)
        let interactor = ESStakeCoinDetailsInteractor(coin)
        let presenter = ESStakeCoinDetailsPresenter()
        let router = ESStakeCoinDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }
    
}

