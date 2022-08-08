//
//  CountriesViewController.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import UIKit

class CountriesViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    var viewModel: CountriesViewModel?
    var countrySelectedCallback: ((CountryInformation) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        getCountries()
    }
    
    deinit {
        viewModel = nil
    }
    
    @IBAction func close(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    private func countrySelected(country: CountryInformation) {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true, completion: {[weak self] in
                if let countrySelectedCallback = self?.countrySelectedCallback {
                    countrySelectedCallback(country)
                }
            })
        }
    }
    
    private func getCountries() {
        viewModel?.vmCallbacks = {[weak self] (state) in
            switch state {
            case let .countrySelected(country):
                self?.countrySelected(country: country)
            default:
                break
            }
        }
    }
}

extension CountriesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "countriesTableViewCell") as? CountryTableViewCell else {
            return UITableViewCell()
        }
        cell.setData(data: viewModel?.countries[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectedCountry = viewModel?.countries[indexPath.row]
    }
    
}
