//
//  ESStakeCoinDetailsDisplayDataManager.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 29.10.2020.
//

import Foundation
import Kingfisher

protocol ESStakeCoinDetailsDisplayDataManagerDelegate: AnyObject {
    func unstakeButtonPressed()
    func stakeButtonPressed()
    func openCalculatorButtonPressed()
    func claimButtonPressed()
}

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
    
    weak var delegate: ESStakeCoinDetailsDisplayDataManagerDelegate?
        
//MARK: UITableViewDelegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.visibleCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = viewModel.visibleCells[indexPath.row]
        let reuseIdentifier = cellType.reuseIdentifier
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
        } else if let cell = cell as? ESStakeCoinDetailsStakedCell {
            cell.stakedValueLabel.text = viewModel.displayStakedAmount
            cell.validatorValueLabel.text = viewModel.validator
            cell.yearlyIncomeValueLabel.text = viewModel.displayApr
            cell.delegate = self
        } else if let cell = cell as? ESStakeCoinDetailsClaimCell {
            cell.availableRewardsValueLabel.text = viewModel.displayAmountToClaim
            cell.delegate = self
        }
    }
 
//MARK: Setup
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        tableView.register(UINib(nibName: "ESStakeCoinDetailsMainCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.mainCell)
        
        tableView.register(UINib(nibName: "ESStakeCoinDetailsAboutCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.aboutCell)
        
        tableView.register(UINib(nibName: "ESStakeCoinDetailsCalculatorCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.calculatorCell)
        
        tableView.register(UINib(nibName: "ESStakeCoinDetailsStakedCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.steakedCell)

        tableView.register(UINib(nibName: "ESStakeCoinDetailsClaimCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.claimCell)
    }
    
    private struct Constants {
        
        struct ReuseIdentifier {
            static let mainCell = "mainCell"
            static let calculatorCell = "calculatorCell"
            static let steakedCell = "steakedCell"
            static let claimCell = "claimCell"
            static let aboutCell = "aboutCell"
        }
        
        struct Height {
            static let mainCell = 164 as CGFloat
            static let calculatorCell = 64 as CGFloat
            static let stakedCell = 130 as CGFloat
            static let claimCell = 100 as CGFloat
        }

    }
    
    enum CellType: Int {
        case main, calculator, staked, claim, about
        
        var reuseIdentifier: String {
            switch self {
            case .main:
                return Constants.ReuseIdentifier.mainCell
            case .calculator:
                return Constants.ReuseIdentifier.calculatorCell
            case .staked:
                return Constants.ReuseIdentifier.steakedCell
            case .claim:
                return Constants.ReuseIdentifier.claimCell
            case .about:
                return Constants.ReuseIdentifier.aboutCell
            }
        }
    }
}

extension ESStakeCoinDetailsDisplayDataManager: ESStakeCoinDetailsCalculatorCellDelegate,
                                                ESStakeCoinDetailsMainCellDelegate,
                                                ESStakeCoinDetailsStakedCellDelegate,
                                                ESStakeCoinDetailsClaimCellDelegate {
    func unstakeButtonPressed() {
        delegate?.unstakeButtonPressed()
    }
    
    func stakeButtonPressed() {
        delegate?.stakeButtonPressed()
    }
    
    func openCalculatorButtonPressed() {
        delegate?.openCalculatorButtonPressed()
    }
    
    func claimButtonPressed() {
        delegate?.claimButtonPressed()
    }
}

