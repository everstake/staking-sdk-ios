//
//  EverstakeListConfigurator.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import Foundation

class ESEverstakeListConfigurator {
    
    static func setup(userCoins: [ESCoin]) -> UIViewController {
        
        let viewController = ESEverstakeListViewController(nibName: "ESEverstakeListViewController",
                                                           bundle: ESUtilities.shared.bundle)
        let navigationViewController = UINavigationController(rootViewController: viewController)
        navigationViewController.isNavigationBarHidden = true
        
        let interactor = ESEverstakeListInteractor(userCoins: userCoins)
        let presenter = ESEverstakeListPresenter()
        let router = ESEverstakeListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return navigationViewController
        
    }

}

