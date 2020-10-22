//
//  EverstakeListViewController.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol EverstakeListDisplayLogic: class {
    func display(viewModel: EverstakeList.ViewModel)
}

class EverstakeListViewController: UIViewController, EverstakeListDisplayLogic {
    var interactor: EverstakeListBusinessLogic?
    var router: (NSObjectProtocol & EverstakeListRoutingLogic & EverstakeListDataPassing)?

// MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
// MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataList()
    }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
  
    func loadDataList() {
        interactor?.loadDataList()
    }
  
    func display(viewModel: EverstakeList.ViewModel) {
        //TODO: show coins in list
    }
    
}
