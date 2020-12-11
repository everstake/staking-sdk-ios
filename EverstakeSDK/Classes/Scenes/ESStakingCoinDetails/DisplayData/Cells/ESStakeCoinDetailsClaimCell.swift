//
//  ESStakeCoinDetailsClaimCell.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsClaimCellDelegate: AnyObject {
    func claimButtonPressed()
}

class ESStakeCoinDetailsClaimCell: UITableViewCell {
    
    weak var delegate: ESStakeCoinDetailsClaimCellDelegate?
    
    @IBOutlet weak var availableRewardsValueLabel: UILabel!
    
    @IBAction func claimButtonPressed() {
        delegate?.claimButtonPressed()
    }
    
}
