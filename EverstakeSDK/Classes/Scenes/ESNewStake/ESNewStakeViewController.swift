//
//  ESNewStakeViewController.swift
//  Pods
//
//  Created by Alexander Koziaruk on 04.11.2020.
//  Copyright (c) 2020 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import SliderController

protocol ESNewStakeDisplayLogic: class {
    func display(viewModel: ESNewStake.ViewModel)
}

class ESNewStakeViewController: UIViewController, ESNewStakeDisplayLogic, SliderControllerDelegate {
  
    var interactor: ESNewStakeBusinessLogic?
    var router: (NSObjectProtocol & ESNewStakeRoutingLogic & ESNewStakeDataPassing)?

    
//MARK: Outlets
  
    @IBOutlet weak var yearlyIncomValueLabel: UILabel!
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var validatorTitleLabel: UILabel!
    @IBOutlet weak var validatorsLabel: UILabel!
    @IBOutlet weak var reliableContainer: UIView!
    @IBOutlet weak var dailyIncomeValueLabel: UILabel!
    @IBOutlet weak var monthlyValueLabel: UILabel!
    @IBOutlet weak var yearlyValueLabel: UILabel!
    @IBOutlet weak var sliderContainerView: UIView!
    @IBOutlet weak var sliderLastAnchorView: UIView!
    @IBOutlet weak var validatorContainerView: ESGradientView!
    
    let sliderController = SliderController()
    var viewModel: ESNewStake.ViewModel? = nil
    
//MARK: Actions
    
    @IBAction func stakeButtonPressed() {
        if let viewModel = viewModel {
            if viewModel.stakeAllowed {
                let stake = ESStake(symbol: viewModel.symbol)
                EverstakeSDK.shared.onStake?(stake)
            } else {
                presentAlertWith(title: "New Stake", message: "Cannot stake for a different validator. Unstake your funds first.")
            }
        }
    }
    
    @IBAction func selectValidatorPressed() {
        router?.selectValidator()
    }
    
    @IBAction func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        addDoneButtonOnKeyboard()
        sliderController.embedSliderIn(targetView: sliderContainerView,
                                       targetViewController: self)
        validatorContainerView.setGradientColors(one: UIColor(hex: "#C4C4C4")!.withAlphaComponent(0),
                                                 two: UIColor(hex: "#7CB518")!.withAlphaComponent(0.1))
        sliderController.setupSlider()
        sliderController.delegate = self
        sliderLastAnchorView.backgroundColor = UIColor(hex: "#CCCCCC")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        interactor?.loadData()
    }
  
    func display(viewModel: ESNewStake.ViewModel) {
        self.viewModel = viewModel
        updateView()
    }
    
//MARK: - SliderControllerDelegate
    
    func sliderDidTap(atValue value: Float) {
        sliderValueDidChange(value: value)
    }
    
    func sliderValueDidChange(value: Float) {
        guard let amount = viewModel?.balance else { return }
        viewModel?.amountToStake = amount * Double(value)
        updateView()
    }
    
    func sliderDidStartSwiping() { }
    func sliderDidEndSwiping() {  }
    
//MARK: - Private
    
    private func updateView() {
        guard let viewModel = viewModel else { return }

        validatorTitleLabel.text = viewModel.validatorTitleLabel
        yearlyIncomValueLabel.text = viewModel.apr
        balanceValueLabel.text = viewModel.displayBalance
        symbolLabel.text = viewModel.symbol
        dailyIncomeValueLabel.text = viewModel.displayPerDayAmount
        monthlyValueLabel.text = viewModel.displayPerMonthAmount
        yearlyValueLabel.text = viewModel.displayPerYearAmount
        amountTextField.text = String(format: "%.2f", viewModel.amountToStake)
        validatorsLabel.text = viewModel.validators
        validatorContainerView.showGradient(viewModel.isReliable)
        reliableContainer.isHidden = !viewModel.isReliable
    }
    
    func updateWithNewAmount() {
        guard let newAmountText = amountTextField.text,
              let newAmount = Float(newAmountText),
              let viewModel = viewModel else { return }
        
        let maxAmount = Float(viewModel.balance)
        let amount = min(newAmount, maxAmount)
        let val = amount / maxAmount
        sliderController.setSlider(value: val, animated: true)
        sliderValueDidChange(value: val)
    }
    
    func addDoneButtonOnKeyboard() {
        let doneToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        doneToolbar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace,
                                        target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done,
                                   target: self, action: #selector(ESNewStakeViewController.doneButtonAction))

        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)

        doneToolbar.items = items
        doneToolbar.sizeToFit()

        amountTextField.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction() {
        amountTextField.resignFirstResponder()
        updateWithNewAmount()
    }
}
