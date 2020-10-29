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
    
    private enum SectionType {
        case staked
        case readyToStake
    }
    
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
    
//MARK: Private
    
    private func sectionTypeFor(_ section: Int) -> SectionType {
        // Show only ready to stake list
        if viewModel.steakedList.isEmpty {
            return .readyToStake
        }
        // Show staked & ready to stake list
        if section == 0 {
            return .staked
        } else {
            return .readyToStake
        }
    }
    
    private func itemsFor(_ section: Int) -> [EverstakeList.CoinModel] {
        switch sectionTypeFor(section) {
        case .staked:
            return viewModel.steakedList
        case .readyToStake:
            return viewModel.readyToStakeList
        }
    }
    
    private func titleFor(_ section: Int) -> String {
        switch sectionTypeFor(section) {
        case .staked:
            return "STEAKED"
        case .readyToStake:
            return "READY TO STAKE"
        }
    }
        
//MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.steakedList.isEmpty ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsFor(section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.coinCell) as! ESCoinTableViewCell
            
        let coin = itemsFor(indexPath.section)[indexPath.row]
        cell.logoImageView.kf.setImage(with: coin.iconUrl)
        cell.titleLabel.text = coin.title
        cell.subTitleLabel.text = coin.displayApr
        cell.steakedLabel.text = coin.displayAmount
        cell.coinContentView.alpha = coin.comingSoon ? 0 : 0.7
        
        return cell
    }
    
//MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 38
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: Constants.readyToStakeHeader) as! ESReadyToStakeHeader
        header.titleLabel.text = titleFor(section)
        header.separatorView.isHidden = (section == 0)
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
