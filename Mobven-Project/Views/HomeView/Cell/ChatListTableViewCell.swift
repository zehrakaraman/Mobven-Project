//
//  ChatListTableViewCell.swift
//  Mobven-Project
//
//  Created by Zehra on 15.03.2023.
//

import UIKit

class ChatListTableViewCell: UITableViewCell {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var userDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func configure(user: Home.Case.ViewModel.GroupsModel) {
        userImage.image = nil
        userTitle.text = user.name
        userDescription.text = user.lastMessage?.message
    }
}
