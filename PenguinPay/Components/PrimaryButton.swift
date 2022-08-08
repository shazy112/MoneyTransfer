//
//  PrimaryButton.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import Foundation
import UIKit

class PrimaryButton: UIButton {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        prepareButton()
    }
    
    private func prepareButton() {
        backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.3960784314, blue: 0.862745098, alpha: 1)
        titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        layer.cornerRadius = 8
        setTitleColor(.white, for: .normal)
    }
}
