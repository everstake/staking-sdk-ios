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
    func preparedShared(_ model: ESServerModel.Combined, action: ESEverstakeList.Action)
}

class ESEverstakeListViewController: UIViewController, ESEverstakeListDisplayLogic,
                                     ESEverstakeListDisplayDataManagerDelegate {
        
    var interactor: ESEverstakeListBusinessLogic?
    var router: (NSObjectProtocol & ESEverstakeListRoutingLogic)?
  
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
    
//MARK: ESEverstakeListDisplayDataManagerDelegate
    
    func didSelected(_ coin: ESEverstakeList.Coin) {
       interactor?.getCoinStakeWith(coin.id, with: .openCoinDetail)
    }
    
    func preparedShared(_ model: ESServerModel.Combined, action: ESEverstakeList.Action) {
        switch action {
        case .openCoinDetail:
            router?.routeToStakeCoinDetails(model)
        }
    }
    
}
