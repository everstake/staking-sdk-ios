//
//  ESStakeCoinDetailsStakedCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsStakedCellDelegate {
    func unstakeButtonPressed()
}

class ESStakeCoinDetailsStakedCell: UITableViewCell {

    var delegate: ESStakeCoinDetailsStakedCellDelegate?
    
    @IBOutlet weak var stakedValueLabel: UILabel!
    @IBOutlet weak var validatorValueLabel: UILabel!
    @IBOutlet weak var yearlyIncomeValueLabel: UILabel!
    
    @IBAction func unstakeButtonPressed() {
        delegate?.unstakeButtonPressed()
    }
    
}
