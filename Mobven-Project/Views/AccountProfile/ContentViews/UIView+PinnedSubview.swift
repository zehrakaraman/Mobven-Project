//
//  UIView+PinnedSubview.swift
//  Mobven-Project
//
//  Created by Zehra on 5.04.2023.
//

import UIKit

extension UIView {
    func addPinnedSubview(_ subview: UIView, height: CGFloat? = nil, insets: UIEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        if subview is UIButton {
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
                subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom),
                subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
                subview.widthAnchor.constraint(equalToConstant: 88)
            ])
        } else {
            NSLayoutConstraint.activate([
                subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top),
                subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left),
                subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -1.0 * insets.right),
                subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -1.0 * insets.bottom)
            ])
        }
        
        if let height = height {
            subview.heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
