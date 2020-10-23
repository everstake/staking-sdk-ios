//
//  EverstakeListViewController.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol EverstakeListDisplayLogic: class {
    func updateWith(viewModel: EverstakeList.ViewModel)
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
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        displayManager.tableView = tableView
        loadDataList()
    }
  
  // MARK: Do something
  
  //@IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    let displayManager = EverstakeListDisplayDataManager()
    
    func loadDataList() {
        interactor?.loadDataList()
    }
  
    func updateWith(viewModel: EverstakeList.ViewModel) {
        displayManager.viewModel = viewModel
    }
    
}
