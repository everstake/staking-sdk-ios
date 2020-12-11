//
//  ESStakeCoinDetailsViewController.swift
//  Pods
//
//  Created by Alex Koziaruk on 29.10.2020.
//  Copyright (c) 2020 Noisy Miner. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ESStakeCoinDetailsDisplayLogic: class {
    func updateWith(_ viewModel: ESStakeCoinDetails.ViewModel)
}

class ESStakeCoinDetailsViewController: UIViewController,
                                        ESStakeCoinDetailsDisplayLogic,
                                        ESStakeCoinDetailsDisplayDataManagerDelegate {
    var interactor: ESStakeCoinDetailsBusinessLogic?
    var router: (NSObjectProtocol & ESStakeCoinDetailsRoutingLogic & ESStakeCoinDetailsDataPassing)?
   
    // MARK: Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var displayDataManager = ESStakeCoinDetailsDisplayDataManager()
    
  // MARK: Actions
  
    @IBAction func backPressed() {
        router?.back()
    }
    
    @IBAction func infoButtonPressed() {
        router?.showInfo()
    }
    
    // MARK: View lifecycle
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayDataManager.tableView = tableView
        displayDataManager.titleLabel = titleLabel
        displayDataManager.delegate = self
        
        interactor?.getDisplayData()
    }
  
    func updateWith(_ viewModel: ESStakeCoinDetails.ViewModel) {
        displayDataManager.viewModel = viewModel
    }
    
//MARK: - ESStakeCoinDetailsDisplayDataManagerDelegate
    
    func unstakeButtonPressedFor(_ validator: ESStakeCoinDetails.ViewModel.ValidatorStake) {
        router?.routeToNewUnstakeWith(validator)
    }
    
    func stakeButtonPressed() {
        router?.stakePressed()
    }
    
    func openCalculatorButtonPressed() {
        router?.openCalculator()
    }
    
    func claimButtonPressed() {
        router?.claim()
    }
    
}
