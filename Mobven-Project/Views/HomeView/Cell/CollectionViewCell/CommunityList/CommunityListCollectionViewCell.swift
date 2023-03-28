//
//  CommunityListCollectionViewCell.swift
//  Mobven-Project
//
//  Created by Zehra on 23.03.2023.
//

import UIKit

class CommunityListCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var communityImage: UIImageView!
    @IBOutlet weak var communityName: UILabel!
    @IBOutlet weak var lastMessage: UILabel!
    @IBOutlet weak var usersImages: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor(named: "White")
        layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
    }

    func configure(model: Home.Case.ViewModel.GroupsModel) {
        configureNullProfile()
        communityName.text = model.name
        
        // MARK: Last message configuration
        
        let attributedText = NSMutableAttributedString(string: model.lastMessage?.from ?? "", attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "Blue - Dark")])
        
        if let message = model.lastMessage?.message {
            attributedText.append(NSAttributedString(string: " \(message)" , attributes: [NSAttributedString.Key.foregroundColor : UIColor(named: "Blue - Light") as Any]))
        }
        
        lastMessage.attributedText = attributedText

        // MARK: Users photo configuration
        
        // MARK: Fetching data of image
//        if let image = model.groupPhoto {
//            DispatchQueue.main.async {
//                self.communityImage.displayImage(with: image)
//            }
//        } else {
//            configureNullProfile()
//        }
    }
    
    private func configureNullProfile() {
        let view = UIImageView(image: UIImage(named: "userIcon"))
        communityImage.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.centerXAnchor.constraint(equalTo: communityImage.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: communityImage.centerYAnchor)
        ])
        
        communityImage.layer.cornerRadius = 8.0
        communityImage.layer.backgroundColor = UIColor(named: "Purple - Light")?.cgColor
    }
}
