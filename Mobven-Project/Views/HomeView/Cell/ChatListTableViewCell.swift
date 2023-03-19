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
        userTitle.text = user.name
        userDescription.text = user.lastMessage?.message
        userImage.image = UIImage(systemName: "person.crop.circle")
        
//        DispatchQueue.main.async {
//            self.userImage.displayImage(with: user.groupPhoto)
//        }
    }
}

extension UIImageView {
    func displayImage(with path: String?) {
        if let path = path {
            let url = URL(string: "http//\(path)")
            let request = URLRequest(url: url!)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                    }
                } else {
                    print("Null photo")
                }
            }
            .resume()
        } else {
            print("Null photo")
        }
    }
}
