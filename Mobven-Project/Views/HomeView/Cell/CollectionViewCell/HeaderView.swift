//
//  HeaderView.swift
//  Mobven-Project
//
//  Created by Zehra on 23.03.2023.
//

import UIKit

class HeaderView: UICollectionReusableView {
    static let identifier = "HeaderView"
    static var elementKind: String { UICollectionView.elementKindSectionHeader }
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "backButton"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 13),
            button.heightAnchor.constraint(equalToConstant: 13)
        ])
        return button
    }()
    
    lazy var title: UILabel = {
        let label = UILabel()
        label.text = "Community"
        label.backgroundColor = .clear
        label.textColor = UIColor(named: "Blue - Dark")
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "moreButton"), for: .normal)
        button.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 13),
            button.heightAnchor.constraint(equalToConstant: 13)
        ])
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [backButton, title, moreButton])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareSubview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func backButtonTapped() {
       
    }
    
    @objc func moreButtonTapped() {
        
    }
    
    private func prepareSubview() {
        backgroundColor = .clear
        backButton.isHidden = true
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
