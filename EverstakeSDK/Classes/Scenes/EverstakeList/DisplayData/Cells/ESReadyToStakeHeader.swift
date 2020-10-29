//
//  ESReadyToStakeHeader.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 23.10.2020.
//

import UIKit

class ESReadyToStakeHeader: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var separatorViewHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        separatorViewHeightConstraint.constant = 0.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
