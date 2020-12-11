//
//  ESNewUnstakeConfigurator.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 11.12.2020.
//

import Foundation

class ESNewUnstakeConfigurator {
    
    public static func viewControllerWith(model: ESStakeCoinDetails.ViewModel.ValidatorStake) -> UIViewController {
        
        let viewController = ESNewUnstakeViewController(nibName: "ESNewUnstakeViewController",
                                                      bundle: ESUtilities.shared.bundle)
        let interactor = ESNewUnstakeInteractor(model: model)
        let presenter = ESNewUnstakePresenter()
        let router = ESNewUnstakeRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }

    
}

