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
        userImage.configureEmptyPhoto(cornerRadius: userImage.frame.height / 2)

//        if let image = model.groupPhoto {
//            DispatchQueue.main.async {
//                self.communityImage.displayImage(with: image)
//            }
//        } else {
//            
//        }

    }
    
    
}


