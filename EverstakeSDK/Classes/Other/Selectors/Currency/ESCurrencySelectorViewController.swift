//
//  ESCurrencySelectorViewController.swift
//  EverstakeSDK
//
//  Created by Alex Koziaruk on 26.11.2020.
//

import UIKit

class ESCurrencySelectorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    var models: [ESServerModel.Combined]!
    var selectedId: String!
    
    var completedWith: ((ESServerModel.Combined?) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        models = ESDataManager.shared.models

        tableView.register(UINib(nibName: "ESCurrencySelectorTableViewCell",
                                 bundle: ESUtilities.shared.bundle),
                           forCellReuseIdentifier: Constants.ReuseIdentifier.mainCell)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 1))
        tableView.reloadData()
    }

//MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.ReuseIdentifier.mainCell)
            as! ESCurrencySelectorTableViewCell
        
        let coin = models[indexPath.row].coin
        
        cell.logoImageView.kf.setImage(with: coin.iconUrl)
        cell.titleLabel.text = coin.name
        cell.subtitleLabel.text = (coin.apr ?? "0") + "%"
        cell.checkImageView.isHidden = coin.id != selectedId
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedId = models[indexPath.row].coin.id ?? ""
        tableView.reloadData()
    }
        
    private struct Constants {
        struct ReuseIdentifier {
            static let mainCell = "mainCell"
        }
    }
    
//MARK: Action
    
    @IBAction func backButtonPressed() {
        let selectedModel = models.filter{ $0.coin.id == selectedId }.first
        completedWith?(selectedModel)
        navigationController?.popViewController(animated: true)
    }
    
//MARK: - Public
        
    public static func createViewController() -> ESCurrencySelectorViewController {
        return ESCurrencySelectorViewController(nibName: "ESCurrencySelectorViewController",
                                                 bundle: ESUtilities.shared.bundle)
    }

}
