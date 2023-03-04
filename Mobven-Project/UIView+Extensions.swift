//
//  UIView+Extensions.swift
//  Mobven-Project
//
//  Created by Zehra on 4.03.2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
