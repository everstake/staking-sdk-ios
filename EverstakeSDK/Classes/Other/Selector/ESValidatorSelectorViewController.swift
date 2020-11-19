//
//  ESValidatorSelectorViewController.swift
//  EverstakeSDK
//
//  Created by Alexander Koziaruk on 19.11.2020.
//

import UIKit

class ESValidatorSelectorViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backButton: UIButton!
    
    var validators = [ESSharedModel.Coin.Validator]()
    var selectedIds = Set<String>()
    var completedWith: ((Set<String>) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ESValidatorSelectorTableViewCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.mainCell)
        tableView.reloadData()
    }

    @IBAction func backButtonPressed() {
        completedWith?(selectedIds)
        navigationController?.popViewController(animated: true)
    }
    
//MARK: - Public
    
    public static func createViewController() -> ESValidatorSelectorViewController {
        return ESValidatorSelectorViewController(nibName: "ESValidatorSelectorViewController",
                                                 bundle: ESUtilities.shared.bundle)
    }
    
//MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return validators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifier.mainCell)
            as! ESValidatorSelectorTableViewCell
        
        let validator = validators[indexPath.item]
        
        cell.titleLabel.text = validator.name
        cell.feeLabel.text = "Fee: \(validator.fee ?? "0")%"
        cell.reliableContainerView.isHidden = !(validator.isReliable ?? false)
        cell.gradientView.isHidden = !(validator.isReliable ?? false)
        cell.checkImageView.isHidden = !selectedIds.contains(validator.id ?? "")
        
        return cell
    }
    
//MARK: - UITableViewDelegates
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let id = validators[indexPath.item].id  else {
            return
        }
        
        if (selectedIds.contains(id)) {
            selectedIds.remove(id)
        } else {
            selectedIds.insert(id)
        }
        
        backButton.isEnabled = !selectedIds.isEmpty
        
        tableView.reloadData()
    }
    
    private struct Constants {
        struct ReuseIdentifier {
            static let mainCell = "mainCell"
        }
    }

}
