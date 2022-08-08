//
//  SendMoneyView.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import UIKit

class SendMoneyView: UIView {
    
    @IBOutlet weak var phoneStackView: UIStackView!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var moneyReceiveLabel: UILabel!
    @IBOutlet weak var moneyReceiveTextField: UITextField!
    @IBOutlet weak var sendMoneyTextField: UITextField!
    @IBOutlet weak var receipentPhoneNumberTextField: UITextField!
    @IBOutlet weak var receipentCountryTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    var countryTextFieldTappedCallback: (() -> Void)?
    var sendMoneyTextFieldCallback: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        countryCodeLabel.isHidden = true
        receipentCountryTextField.addTarget(self, action: #selector(countryTextFieldTapped), for: .editingDidBegin)
        sendMoneyTextField.addTarget(self, action: #selector(sendMoneyTextFieldEditingChanged), for: .editingChanged)
    }
    
    func setCountry(with country: String) {
        receipentCountryTextField.text = country
    }
    
    @objc private func countryTextFieldTapped(sender: UITextField) {
        if let countryTextFieldTappedCallback = countryTextFieldTappedCallback {
            countryTextFieldTappedCallback()
        }
    }
    
    @objc private func sendMoneyTextFieldEditingChanged(sender: UITextField) {
        if let sendMoneyTextFieldCallback = sendMoneyTextFieldCallback {
            sendMoneyTextFieldCallback(sender.text ?? "")
        }
    }
}
