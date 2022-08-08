//
//  ViewController.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/20/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    var countryInfomation: CountryInformation = CountryInformation()
    var countryInfoData: [CountryInformation] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Penguin Pay"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}

