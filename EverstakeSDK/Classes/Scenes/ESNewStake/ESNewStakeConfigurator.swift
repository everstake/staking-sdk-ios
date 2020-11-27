//
//  ESNewStakeConfigurator.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 04.11.2020.
//

import Foundation

class ESNewStakeConfigurator {
    
    public static func viewControllerWith(model: ESSharedModel.Combined,
                                          validator: ESSharedModel.Validator? = nil,
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


