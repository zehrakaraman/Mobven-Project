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

extension UIViewController: UITextFieldDelegate {
    func configureTextField(_ textFields: [UITextField]) {
        textFields.forEach {
            $0.delegate = self
            $0.cornerRadius = 17.0
            $0.borderStyle = .none
        }
    }
}

extension CAGradientLayer {
    static func gradientLayer(in frame: CGRect) -> Self {
        let layer = Self()
        layer.colors = colors()
        layer.frame = frame
        return layer
    }
    
    private static func colors() -> [CGColor] {
        let beginColor = UIColor(named: "Gradient")
        let endColor = UIColor(named: "Purple")
        
        return [beginColor!.cgColor, endColor!.cgColor]
    }
}

