//
//  EverstakeListDisplayDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import Foundation
import UIKit
import Kingfisher

class EverstakeListDisplayDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    var viewModel = EverstakeList.ViewModel() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        // TODO: Make dynamic
        
        return 2
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // TODO: Make dynamic
        
        switch section {
        case 0:
            return viewModel.steakedList.count
        default:
            return viewModel.readyToStakeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.coinCell) as! ESCoinTableViewCell
        
        //TODO: User view model here
        
        // TODO: Refactor
        let coin = indexPath.section == 0 ? viewModel.steakedList[indexPath.item] :
                                            viewModel.readyToStakeList[indexPath.item]
        
        
        cell.logoImageView.kf.setImage(with: coin.iconUrl)
        cell.titleLabel.text = coin.title
        cell.subTitleLabel.text = "\(coin.apr ?? 0)%"
        cell.coinContentView.alpha = coin.comingSoon ? 0 : 0.7
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: Constants.readyToStakeHeader) as! ESReadyToStakeHeader
        
        // TODO: Make dynamic

        header.titleLabel.text = section == 0 ? "STEAKED" : "READY TO STAKE"
        
        return header.contentView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "ESCoinTableViewCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.coinCell)
        tableView.register(UINib(nibName: "ESReadyToStakeHeader",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.readyToStakeHeader)
    }
    
    private struct Constants {
        static let coinCell = "coinCell"
        static let readyToStakeHeader = "readyToStakeHeader"
    }
}
