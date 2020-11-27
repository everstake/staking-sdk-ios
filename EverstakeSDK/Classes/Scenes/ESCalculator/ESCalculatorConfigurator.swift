//
//  ESCalculatorConfigurator.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 26.11.2020.
//

import Foundation

class ESCalculatorConfigurator {
    
    public static func viewControllerWith(_ model: ESSharedModel.Combined) -> UIViewController {
        let viewController = ESCalculatorViewController(nibName: "ESCalculatorViewController",
                                                        bundle: ESUtilities.shared.bundle)
        let interactor = ESCalculatorInteractor()
        interactor.model = model
        
        let presenter = ESCalculatorPresenter()
        let router = ESCalculatorRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
    }

    
}
