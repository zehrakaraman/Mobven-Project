//
//  GenderContentView.swift
//  Mobven-Project
//
//  Created by Zehra on 6.04.2023.
//

import UIKit

class GenderContentView: UIView, UIContentView {
    struct Configuration: UIContentConfiguration {
        func updated(for state: UIConfigurationState) -> GenderContentView.Configuration {
            return self
        }
        
        var text: String? = ""
        var onChange: (String) -> Void = { _ in }
        
        func makeContentView() -> UIView & UIContentView {
            return GenderContentView(self)
        }
    }
    
    let textField = UITextField()
    let gender = ["Gender", "Male", "Female"]
    var configuration: UIContentConfiguration {
        didSet {
            configure(configuration: configuration)
        }
    }
    
    override var intrinsicContentSize: CGSize {
        CGSize(width: 44, height: 44)
    }
    
    init(_ configuration: UIContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        addPinnedSubview(textField, insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
        textField.delegate = self
        textField.backgroundColor = UIColor(named: "Purple - Soft")
        textField.textColor = UIColor(named: "Blue - Dark")
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.cornerRadius = 12.0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(configuration: UIContentConfiguration) {
        guard let configuration = configuration as? Configuration else { return }
        textField.text = configuration.text
    }
    
    func didChange(_ textField: UITextField) {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = UIColor(named: "Purple - Light")
        textField.inputView = pickerView
    }
}

extension GenderContentView: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        NSAttributedString(
            string: gender[row],
            attributes: [
                NSAttributedString.Key.font : UIFont(name: "Montserrat-Regular", size: 12)!,
                NSAttributedString.Key.foregroundColor : UIColor(named: "Blue - Dark")!
            ])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = gender[row]
        textField.resignFirstResponder()
        guard let configuration = configuration as? GenderContentView.Configuration else { return }
        configuration.onChange(textField.text ?? "")
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        didChange(textField)
    }
}

extension UICollectionViewListCell {
    func genderViewConfiguration() -> GenderContentView.Configuration {
        GenderContentView.Configuration()
    }
}
