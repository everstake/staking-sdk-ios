//
//  EverstakeListRouter.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

@objc protocol ESEverstakeListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ESEverstakeListDataPassing {
    var dataStore: ESEverstakeListDataStore? { get }
}

class ESEverstakeListRouter: NSObject, ESEverstakeListRoutingLogic, ESEverstakeListDataPassing {
    weak var viewController: ESEverstakeListViewController?
    var dataStore: ESEverstakeListDataStore?

    // MARK: Routing

    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}

    // MARK: Navigation

    //func navigateToSomewhere(source: EverstakeListViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}

    // MARK: Passing data

    //func passDataToSomewhere(source: EverstakeListDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}
