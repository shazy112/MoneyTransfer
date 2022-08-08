//
//  Extension+String.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/23/22.
//

import Foundation

extension String {
    func isValidPhoneNumber(regex: String) -> Bool {
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return phonePredicate.evaluate(with: self)
    }
    
    var containsValidCharacter: Bool {
        let characterSet = CharacterSet(charactersIn: "01")
        let range = (self as NSString).rangeOfCharacter(from: characterSet)
        return range.location != NSNotFound
    }
}
