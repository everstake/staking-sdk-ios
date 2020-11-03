//
//  ESStakeCoinDetailsAboutCell.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 31.10.2020.
//

import UIKit

class ESStakeCoinDetailsAboutCell: UITableViewCell {
    
    @IBOutlet weak var aboutCoinTextView: UITextView!
    @IBOutlet weak var separatorHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        separatorHeightConstraint.constant = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
