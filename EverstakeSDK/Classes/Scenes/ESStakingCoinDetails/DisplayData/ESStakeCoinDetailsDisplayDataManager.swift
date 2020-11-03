//
//  ESStakeCoinDetailsDisplayDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import Foundation
import Kingfisher

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
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseIdentifier = CellType(rawValue: indexPath.row)!.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier)!
        setup(cell)
        
        return cell
    }
    
    private func setup(_ cell: UITableViewCell) {
        if let cell = cell as? ESStakeCoinDetailsMainCell {
            cell.titleLabel.text = viewModel.title
            cell.logoImageView.kf.setImage(with: viewModel.iconURL)
            cell.aprLabel.text = viewModel.displayApr
            cell.serviceFeeLabel.text = viewModel.displayServiceFee
            cell.delegate = self
        } else if let cell = cell as? ESStakeCoinDetailsAboutCell  {
            cell.aboutCoinTextView.text = viewModel.about
        } else if let cell = cell as? ESStakeCoinDetailsCalculatorCell {
            cell.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch CellType(rawValue: indexPath.row) {
        case .main:
            return Constants.Height.mainCell
        case .about:
            return tableView.bounds.height - Constants.Height.mainCell
        case .calculator:
            return Constants.Height.calculatorCell
        default:
            return 0
        }
    }
    
//MARK: Setup
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
//        tableView.delaysContentTouches = false

        tableView.register(UINib(nibName: "ESStakeCoinDetailsMainCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.mainCell)
        
        tableView.register(UINib(nibName: "ESStakeCoinDetailsAboutCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.aboutCell)
        
        tableView.register(UINib(nibName: "ESStakeCoinDetailsCalculatorCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.calculatorCell)
        
        
    }
    
    private struct Constants {
        
        struct ReuseIdentifier {
            static let mainCell = "mainCell"
            static let aboutCell = "aboutCell"
            static let calculatorCell = "calculatorCell"
        }
        
        struct Height {
            static let mainCell = 164 as CGFloat
            static let calculatorCell = 64 as CGFloat
        }

    }
    
    private enum CellType: Int {
        case main, calculator, about
        
        var reuseIdentifier: String {
            switch self {
            case .main:
                return Constants.ReuseIdentifier.mainCell
            case .about:
                return Constants.ReuseIdentifier.aboutCell
            case .calculator:
                return Constants.ReuseIdentifier.calculatorCell
            }
        }
    }
}

extension ESStakeCoinDetailsDisplayDataManager: ESStakeCoinDetailsCalculatorCellDelegate,
                                                ESStakeCoinDetailsMainCellDelegate {
    func stakeButtonPressed() {
        //TODO: Implement
    }
    
    func openCalculatorPressed() {
        //TODO: Implement
    }
    
}

