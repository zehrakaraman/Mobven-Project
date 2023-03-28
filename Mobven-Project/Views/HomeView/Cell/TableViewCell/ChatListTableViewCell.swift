//
//  ChatListTableViewCell.swift
//  Mobven-Project
//
//  Created by Zehra on 15.03.2023.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {
    static let nibName = "ChatListTableViewCell"
    static let identifier = "ChatListTableViewCell"

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configure(user: Home.Case.ViewModel.User) {
        userTitle.text = user.fullName
        userDescription.text = user.title
        configureNullProfile()

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
        userImage.addSubview(view)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.widthAnchor.constraint(equalToConstant: 20),
            view.heightAnchor.constraint(equalToConstant: 20),
            view.centerXAnchor.constraint(equalTo: userImage.centerXAnchor),
            view.centerYAnchor.constraint(equalTo: userImage.centerYAnchor)
        ])
        
        userImage.layer.cornerRadius = userImage.frame.height / 2
        userImage.layer.backgroundColor = UIColor(named: "Purple - Light")?.cgColor
    }
}


