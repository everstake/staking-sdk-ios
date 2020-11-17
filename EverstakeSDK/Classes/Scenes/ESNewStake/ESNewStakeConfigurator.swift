//
//  ESNewStakeConfigurator.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 04.11.2020.
//

import Foundation

class ESNewStakeConfigurator {
    
    public static func viewControllerWith(_ model: ESSharedModel.Combined) -> UIViewController {
        let viewController = ESNewStakeViewController(nibName: "ESNewStakeViewController",
                                                      bundle: ESUtilities.shared.bundle)
        let interactor = ESNewStakeInteractor(model: model)
        let presenter = ESNewStakePresenter()
        let router = ESNewStakeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }

    
}


