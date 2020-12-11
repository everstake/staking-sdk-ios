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

class ESEverstakeListViewController: UIViewController, ESEverstakeListDisplayLogic,
                                     ESEverstakeListDisplayDataManagerDelegate {
        
    var interactor: ESEverstakeListBusinessLogic?
    var router: (NSObjectProtocol & ESEverstakeListRoutingLogic)?
    
//MARK: Actions
    
    @IBAction func closeButtonPressed() {
        router?.close()
    }
    
    @IBAction func infoButtonPressed() {
        router?.showInfo()
    }
    
// MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        
        displayManager.tableView = tableView
        displayManager.delegate = self
        loadDataList()
    }
  
// MARK: Properties
  
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emptyStateView: UIView!
    
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
        tableView.isHidden = true
        emptyStateView.isHidden = false
    }
    
//MARK: ESEverstakeListDisplayDataManagerDelegate
    
    func didSelected(_ coin: ESEverstakeList.Coin) {
        router?.routeToStakeCoinDetailsWith(id: coin.id)
    }
    
}
