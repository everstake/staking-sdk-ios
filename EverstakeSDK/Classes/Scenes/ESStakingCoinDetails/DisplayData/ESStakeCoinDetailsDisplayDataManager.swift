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
            cell.validatorValueLabel.text = "TODO" //TODO viewModel.validator
            cell.yearlyIncomeValueLabel.text = viewModel.displayApr
            cell.delegate = self
            //TODO: if last & claim not shown hide separator (or if next is about)
            
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

        CellType.allCases.forEach({
            tableView.register(UINib(nibName: $0.nibName, bundle: ESUtilities.shared.bundle),
                               forCellReuseIdentifier: $0.reuseIdentifier)
        })
    }
    
    enum CellType: Int, CaseIterable {
        case main, calculator, steakedHeader, staked, claim, about
        
        var reuseIdentifier: String {
            switch self {
            case .main:
                return "mainCell"
            case .calculator:
                return "calculatorCell"
            case .steakedHeader:
                return "steakedHeaderCell"
            case .staked:
                return "steakedCell"
            case .claim:
                return "claimCell"
            case .about:
                return "aboutCell"
            }
        }
        
        var nibName: String {
            switch self {
            case .main:
                return "ESStakeCoinDetailsMainCell"
            case .calculator:
                return "ESStakeCoinDetailsCalculatorCell"
            case .steakedHeader:
                return "ESStakeCoinDetailsStakedHeaderCell"
            case .staked:
                return "ESStakeCoinDetailsStakedCell"
            case .claim:
                return "ESStakeCoinDetailsClaimCell"
            case .about:
                return "ESStakeCoinDetailsAboutCell"
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

