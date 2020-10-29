//
//  EverstakeListViewController.swift
//
//  Created by Alexander Koziaruk on 20.10.2020.
//  Copyright (c) 2020 NoisyMiner. All rights reserved.
//

import UIKit

protocol ESEverstakeListDisplayLogic: class {
    func updateWith(viewModel: ESEverstakeList.ViewModel)
    func unableToLoadData()
}

class ESEverstakeListViewController: UIViewController, ESEverstakeListDisplayLogic {
    var interactor: ESEverstakeListBusinessLogic?
    var router: (NSObjectProtocol & ESEverstakeListRoutingLogic & ESEverstakeListDataPassing)?

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
  
// MARK: Properties
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    let displayManager = ESEverstakeListDisplayDataManager()
    
// MARK: Methods
    
    func loadDataList() {
        interactor?.loadDataList()
    }
    
//MARK: EverstakeListDisplayLogic
    
    func updateWith(viewModel: ESEverstakeList.ViewModel) {
        displayManager.viewModel = viewModel
        activityIndicator.stopAnimating()
    }
    
    func unableToLoadData() {
        activityIndicator.stopAnimating()
        //TODO: show proper view
    }
    
}
