//
//  ESStakeCoinDetailsClaimCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsClaimCellDelegate {
    func claimButtonPressed()
}

class ESStakeCoinDetailsClaimCell: UITableViewCell {
    
    var delegate: ESStakeCoinDetailsClaimCellDelegate?
    
    @IBOutlet weak var availableRewardsValueLabel: UILabel!
    
    @IBAction func claimButtonPressed() {
        
    }
    
}
