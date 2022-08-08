//
//  Extension+UINavigationController.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/22/22.
//

import Foundation
import UIKit

extension UINavigationBar {
    
    //setting up naviagation bar across the APP
    static func setupNavigationBar() {
        let headerFont: UIFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.4039215686, green: 0.3960784314, blue: 0.862745098, alpha: 1)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                            NSAttributedString.Key.font: headerFont]
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().tintColor = .white
        if #available(iOS 15, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = #colorLiteral(red: 0.4039215686, green: 0.3960784314, blue: 0.862745098, alpha: 1)
            navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white,
                                                           .font: headerFont]
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
}
