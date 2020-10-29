//
//  ESStakeCoinDetailsDisplayDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import Foundation

class ESStakeCoinDetailsDisplayDataManager: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    weak var titleLabel: UILabel!
    weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    var viewModel: ESStakeCoinDetails.ViewModel! {
        didSet {
            tableView.reloadData()
            titleLabel.text = viewModel.title
        }
    }
    
//MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.mainCoinDetails)!
        return cell
    }
    
    
//MARK: Setup
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

        tableView.register(UINib(nibName: "ESStakeCoinDetailsMainCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.mainCoinDetails)
    }
    
    private struct Constants {
        static let mainCoinDetails = "mainCoinDetails"
    }
    
}
