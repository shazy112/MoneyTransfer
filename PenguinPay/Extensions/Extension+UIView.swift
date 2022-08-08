//
//  Extension+UIColor.swift
//  PenguinPay
//
//  Created by Sheearz Ahmed on 6/21/22.
//

import Foundation
import UIKit

extension UIView {
   class func loadFromXib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
