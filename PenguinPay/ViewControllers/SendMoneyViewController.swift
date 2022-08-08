//
//  SendMoneyViewController.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import UIKit

class SendMoneyViewController: UIViewController {
    
    //MARK: Outlets
    @IBOutlet weak private var contentView: UIView!
    
    //MARK: VARS
    private var sendMoneyView: SendMoneyView = UIView.loadFromXib()
    private var countriesViewModel: CountriesViewModel = CountriesViewModel()
    private var currenciesViewModel: SendMoneyViewModel = SendMoneyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Send Money"
        Task {
            await countriesViewModel.fetchCountries()
            await currenciesViewModel.getCurrencies()
        }
        setupSendMoneyView()
        setTextfieldDelegates()
        countriesTextFieldTapped()
        sendMoneyTextChanged()
        performActionForCurrencyViewModel()
        performActionForCountryViewModel()
    }
    
    private func setTextfieldDelegates() {
        let textFields = [sendMoneyView.sendMoneyTextField,
                          sendMoneyView.firstNameTextField,
                          sendMoneyView.lastNameTextField,
                          sendMoneyView.receipentPhoneNumberTextField]
        textFields.forEach { $0?.delegate = self }
    }
    
    //Adding sendmoney view to VC
    private func setupSendMoneyView() {
        contentView.addSubview(sendMoneyView)
        sendMoneyView.translatesAutoresizingMaskIntoConstraints = false
        let verticalConstraint = sendMoneyView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16)
        let bottomConstraint = sendMoneyView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        let leadingConstraint = sendMoneyView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0)
        let trailingConstraint = sendMoneyView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0)
        NSLayoutConstraint.activate([verticalConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
    }
    
    private func countriesTextFieldTapped() {
        sendMoneyView.countryTextFieldTappedCallback = {[weak self] in
            self?.currenciesViewModel.countriesTextFieldTapped()
        }
    }
    
    private func getSelectedCountry(selectedCountry: CountryInformation) {
        currenciesViewModel.countrySelectedForConversion = selectedCountry
        sendMoneyView.receipentCountryTextField.text = selectedCountry.country
        sendMoneyView.countryCodeLabel.text = selectedCountry.phonePrefix
        sendMoneyView.receipentCountryTextField.resignFirstResponder()
    }
    
    private func sendMoneyTextChanged() {
        sendMoneyView.sendMoneyTextFieldCallback = {[weak self] amount in
            self?.currenciesViewModel.amountEntered(text: amount)
        }
    }
    
    private func showCountriesViewController() {
        DispatchQueue.main.async { [weak self] in
            if let vc = self?.storyboard?.instantiateViewController(withIdentifier: "CountriesViewController") as? CountriesViewController {
                vc.viewModel = self?.countriesViewModel
                vc.countrySelectedCallback = {[weak self] country in
                    self?.getSelectedCountry(selectedCountry: country)
                }
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    private func showError(message: String) {
        hideLoader()
        DispatchQueue.main.async {[weak self] in
            self?.showAlert(with: message)
        }
    }
    
    private func moneySentSuccessfully(message: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {[weak self] in
            self?.hideLoader()
            self?.showAlert(with: message, completion: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            })
            
        }
    }
    
    private func currencyFetchingFailed(error: String) {
        DispatchQueue.main.async {[weak self] in
            self?.hideLoader()
            self?.showAlert(with: error)
        }
    }
    
    private func performActionForCurrencyViewModel() {
        currenciesViewModel.vmCallbacks = { [weak self] (state)in
            switch state {
            case .fetching:
                self?.showLoader(with: "Please wait...")
            case .currenciesFetched:
                self?.hideLoader()
            case let .unableToFetchCurrencies(error):
                self?.showError(message: error)
            case .showCountriesList:
                self?.showCountriesViewController()
            case .enablePhoneNumberInput:
                self?.sendMoneyView.countryCodeLabel.isHidden = false
                self?.sendMoneyView.receipentPhoneNumberTextField.isEnabled = true
            case let .convertedAmount(amountInActualCurrency, amountInBinary, selectedCountry):
                self?.sendMoneyView.moneyReceiveLabel.isHidden = false
                self?.sendMoneyView.moneyReceiveTextField.text = amountInBinary
                self?.sendMoneyView.moneyReceiveLabel.text = "Receipent will receive \(selectedCountry):\(amountInActualCurrency) in actual currency!"
            case let .moneyTransferResult(result):
                switch result {
                case let .success(_, response):
                    self?.moneySentSuccessfully(message: response)
                case .failure(let error):
                    self?.currencyFetchingFailed(error: error)
                }
            }
        }
    }
    
    private func performActionForCountryViewModel() {
        countriesViewModel.vmCallbacks = {[weak self] (state) in
            switch state {
            case .countriesFetched:
                self?.hideLoader()
                if let countries = self?.countriesViewModel.countries.first {
                    self?.getSelectedCountry(selectedCountry: countries)
                }
            case let .unableToFetchCountries(error):
                self?.hideLoader()
                self?.showAlert(with: error)
            default:
                break
            }
        }
    }
    @IBAction func sendMoneyTapped(_ sender: Any) {
        if currenciesViewModel.validateAndSendRequest(firstName: sendMoneyView.firstNameTextField.text ?? "",
                                                      lastName: sendMoneyView.lastNameTextField.text ?? "",
                                                      country: sendMoneyView.receipentCountryTextField.text ?? "",
                                                      phoneNumber: sendMoneyView.receipentPhoneNumberTextField.text ?? "",
                                                      countryCode: sendMoneyView.countryCodeLabel.text ?? "", transferAmount: sendMoneyView.sendMoneyTextField.text ?? "", receivedAmout: sendMoneyView.moneyReceiveTextField.text ?? "") {
            showLoader(with: "Plesae wait while we send your money!")
        }
    }
}

extension SendMoneyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = textField == sendMoneyView.sendMoneyTextField ? 6 : 12
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
        if textField == sendMoneyView.sendMoneyTextField {
            return newString.length <= maxLength && currenciesViewModel.containsBinary(string: string) || string.isEmpty
        }
        else {
            return newString.length <= maxLength
        }
    }
}
