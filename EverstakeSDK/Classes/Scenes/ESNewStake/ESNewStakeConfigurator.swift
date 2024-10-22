//
//  ESNewStakeConfigurator.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 04.11.2020.
//

import Foundation

class ESNewStakeConfigurator {
    
    public static func viewControllerWith(model: ESServerModel.Combined,
                                          validator: ESServerModel.Validator? = nil,
                                          amount: Double? = nil) -> UIViewController {
        
        let viewController = ESNewStakeViewController(nibName: "ESNewStakeViewController",
                                                      bundle: ESUtilities.shared.bundle)
        let interactor = ESNewStakeInteractor(model: model, validator: validator, amount: amount)
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


