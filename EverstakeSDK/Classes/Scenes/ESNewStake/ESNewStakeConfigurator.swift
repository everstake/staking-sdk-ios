//
//  ESNewStakeConfigurator.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 04.11.2020.
//

import Foundation

class ESNewStakeConfigurator {
    
    public static func viewControllerWith(_ model: ESSharedModel.Combined) -> UIViewController {
        let viewController = ESStakeCoinDetailsViewController(nibName: "ESNewStakeViewController",
                                                              bundle: ESUtilities.shared.bundle)
        let interactor = ESNewStakeInteractor()
        let presenter = ESNewStakePresenter()
        let router = ESNewStakeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    
}


