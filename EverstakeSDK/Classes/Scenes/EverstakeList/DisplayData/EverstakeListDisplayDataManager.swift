//
//  EverstakeListDisplayDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 22.10.2020.
//

import Foundation
import UIKit

class EverstakeListDisplayDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UINib(nibName: "ESCoinTableViewCell",
                                     bundle: ESUtilities.shared.bundle),
                               forCellReuseIdentifier: "coinCell")
        }
    }
    
    var coins = [EverstakeList.Coin]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "coinCell") as! ESCoinTableViewCell
        
        let coin = coins[indexPath.item]
//        cell.logoImageView.image = coin.iconUrl
        cell.titleLabel.text = coin.name
        cell.subTitleLabel.text = "\(coin.apr ?? 0)%"
        
        return cell
    }
    
    
}
