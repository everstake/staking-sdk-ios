//
//  ESStakeCoinDetailsStakedCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 01.11.2020.
//

import UIKit

protocol ESStakeCoinDetailsStakedCellDelegate: AnyObject {
    func unstakeButtonPressed(cell: ESStakeCoinDetailsStakedCell)
}

class ESStakeCoinDetailsStakedCell: UITableViewCell {

    weak var delegate: ESStakeCoinDetailsStakedCellDelegate?
    
    @IBOutlet weak var stakedValueLabel: UILabel!
    @IBOutlet weak var validatorValueLabel: UILabel!
    
    @IBAction func unstakeButtonPressed() {
        delegate?.unstakeButtonPressed(cell: self)
    }
    
}
