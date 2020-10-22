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
        
        let vc = EverstakeSDK.createViewController()
        self.present(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

