//
//  Extension+UIViewController.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/27/22.
//

import Foundation
import JGProgressHUD

extension UIViewController {
    func showLoader(with text: String = "") {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first {
                let hud = JGProgressHUD()
                hud.tag = 999
                hud.textLabel.text = text
                hud.show(in: keyWindow)
            }
        }
    }
    
    func hideLoader() {
        DispatchQueue.main.async {
            if let keyWindow = UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .compactMap({$0 as? UIWindowScene})
                .first?.windows
                .filter({$0.isKeyWindow}).first , let foundView = keyWindow.viewWithTag(999) as? JGProgressHUD {
                foundView.dismiss()
            }
        }
    }
    
    func showAlert(with message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { _ in
            if let completion = completion {
                completion()
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
