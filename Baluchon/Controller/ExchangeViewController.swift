//
//  ExchangeViewController.swift
//  Baluchon
//
//  Created by Elodie-Anne Parquer on 28/10/2019.
//  Copyright © 2019 Elodie-Anne Parquer. All rights reserved.
//

import UIKit

final class ExchangeViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var currencieStackView: [UIStackView]!
    @IBOutlet private var amountsTextField: [UITextField]!
    @IBOutlet weak private var lastUpdateLabel: UILabel!
    @IBOutlet weak private var convertButton: UIButton!
    @IBOutlet weak private var updateActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Properties
    
    private var rates: ExchangeData?
    private let exchangeService = ExchangeService()
    private var isReversed: Bool = false
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDesign()
        updateRate()
    }
    
    // MARK: - Action
    
    @IBAction private func convertButtonTapped(_ sender: UIButton) {
        if isReversed {
            if let usdAmount = amountsTextField[1].text, !usdAmount.isEmpty {
                toggleActivityIndicator(shown: true)
                updateRate()
                return
            }
        } else {
            if let eurAmount = amountsTextField[0].text, !eurAmount.isEmpty {
                toggleActivityIndicator(shown: true)
                updateRate()
                return
            }
        }
        presentAlert(titre: "Error", message: "Please enter one number at least")
    }
    
    // MARK: - Methods
    
    private func setupDesign() {
        for textField in amountsTextField {
            textField.layer.cornerRadius = 5.0
            textField.layer.shadowColor = UIColor.gray.cgColor
            textField.layer.shadowOpacity = 0.5
            textField.layer.shadowOffset = CGSize(width: 1, height: 1)
        }
    }
    
    /// method that manages the data of the network call
    private func updateRate() {
        exchangeService.getRate { result in
            switch result {
            case .success(let exchangeRate):
                DispatchQueue.main.sync {
                    self.toggleActivityIndicator(shown: false)
                    self.rates = exchangeRate
                    guard let usdRate = exchangeRate.rates["USD"] else { return }
                    self.amountEdition(exchangeRate: usdRate)
                    guard let stringDate = self.rates?.date else { return }
                    self.lastUpdateLabel.text = "Mis à jour le " + stringDate
                }
            case .failure(let error):
                self.presentAlert(titre: "Error", message: "Service unavailable")
                print(error)
            }
        }
    }
    
    /// method that allows textfield update and manage exchangeRate's conversion
    private func amountEdition(exchangeRate: Float) {
        if !isReversed {
            guard let amount = amountsTextField[0].text else { return }
            guard let floatAmount = Float(amount) else { return }
            let result = floatAmount / exchangeRate
            amountsTextField[1].text = String(result)
        } else {
            guard let amount = amountsTextField[1].text else { return }
            guard let floatAmount = Float(amount) else { return }
            let result = floatAmount * exchangeRate
            amountsTextField[0].text = String(result)
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        updateActivityIndicator.isHidden = !shown
        convertButton.isHidden = shown
    }
}

// MARK: - Keyboard

extension ExchangeViewController: UITextFieldDelegate {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        for amountTextField in amountsTextField {
            amountTextField.resignFirstResponder()
        }
    }
    
    /// Ternary operator : defined which textfiled is used
    func textFieldDidChangeSelection(_ textField: UITextField) {
        isReversed = textField == amountsTextField[0] ? false : true
    }
}
