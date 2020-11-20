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
        
        let coins = [ESCoin(symbol: "xtz", address: "tz1LLNkQK4UQV6QcFShiXJ2vT2ELw449MzAA", balance: "0.8"),
                     ESCoin(symbol: "ATOM", address: "cosmos1gdmscydnyl0pj6lcjzmeuhr6g5g68u97z3jm8l", balance: "40.44099")]
        
        let vc = EverstakeSDK.createViewControllerWith(coins: coins)
        self.present(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

