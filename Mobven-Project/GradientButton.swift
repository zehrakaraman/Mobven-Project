//
//  GradientButton.swift
//  Mobven-Project
//
//  Created by Zehra on 6.03.2023.
//

import UIKit

class GradientButton: UIButton {
    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer.gradientLayer(in: self.bounds)
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.cornerRadius = 17.0
        self.layer.masksToBounds = true
    }
}

