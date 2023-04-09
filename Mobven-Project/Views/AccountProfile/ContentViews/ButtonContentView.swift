//
//  ButtonContentView.swift
//  Mobven-Project
//
//  Created by Zehra on 8.04.2023.
//

import UIKit

class ButtonContentView: UIView, UIContentView {
    
    struct Configuration: UIContentConfiguration {
        func updated(for state: UIConfigurationState) -> ButtonContentView.Configuration {
            return self
        }
        
        func makeContentView() -> UIView & UIContentView {
            return ButtonContentView(self)
        }
    }
    
    let button = UIButton()
    
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(button, height: 12, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        button.addTarget(self, action: #selector(didClick), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        button.backgroundColor = .clear
        button.setTitle("Linkedln", for: .normal)
        button.setTitleColor(UIColor(named: "Blue - Dark"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
    }
    
    @objc private func didClick() {
//        delegate?.routeToWebView()
    }
}

extension UICollectionViewListCell {
    func buttonConfiguration() -> ButtonContentView.Configuration {
        ButtonContentView.Configuration()
    }
}

