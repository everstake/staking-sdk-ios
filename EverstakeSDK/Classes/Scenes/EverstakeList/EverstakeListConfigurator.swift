//
//  EverstakeListConfigurator.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import Foundation

class EverstakeListConfigurator {
    
    static func setup() -> UIViewController {
        
        let bundle = Bundle(for: EverstakeListViewController.self)
        let viewController = EverstakeListViewController(nibName: "EverstakeListViewController",
                                                         bundle: bundle)
        
        let interactor = EverstakeListInteractor()
        let presenter = EverstakeListPresenter()
        let router = EverstakeListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
        
        return viewController
        
    }

}

