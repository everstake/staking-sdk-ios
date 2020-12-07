//
//  ViewController.swift
//  EverstakeSDK
//
//  Created by akoziaruk on 10/21/2020.
//  Copyright (c) 2020 akoziaruk. All rights reserved.
//

import UIKit
import EverstakeSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let coins = [ESUserCoin(symbol: "xtz", address: "tz1LLNkQK4UQV6QcFShiXJ2vT2ELw449MzAA", balance: "0.8"),
                     ESUserCoin(symbol: "ATOM", address: "cosmos1gdmscydnyl0pj6lcjzmeuhr6g5g68u97z3jm8l", balance: "40.44099")]
        
        let vc = EverstakeSDK.shared.createViewControllerWith(coins: coins)
        self.present(vc, animated: true)
        
        EverstakeSDK.shared.onAction = { (action: ESAction,
                                          symbol: String,
                                          amount: String,
                                          validators: [ESValidatorInfo]) in
            
            self.showAlertWith(message: "\(action.description) \(amount) \(symbol))")

        }
        
    }
    
    func showAlertWith(message: String) {
        let alert = UIAlertController(title: "EverstakeSDK-Example", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        topMostController()?.present(alert, animated: true)
    }
    
    func topMostController() -> UIViewController? {
        guard let window = UIApplication.shared.keyWindow, let rootViewController = window.rootViewController else {
            return nil
        }

        var topController = rootViewController

        while let newTopController = topController.presentedViewController {
            topController = newTopController
        }

        return topController
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension ESAction {
    var description: String {
        switch self {
            case .stake: return "STAKE"
            case .unstake: return "UNSTAKE"
            case .claim: return "CLAIM"
        }
    }
}
