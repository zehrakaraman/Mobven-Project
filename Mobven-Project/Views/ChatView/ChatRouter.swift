//
//  ChatRouter.swift
//  Mobven-Project
//
//  Created by Zehra on 30.03.2023.
//

import UIKit
import Photos
import PhotosUI

protocol ChatRoutingLogic: AnyObject {
    func routeToPHPicker()
}

protocol ChatDataPassing: AnyObject {
    var dataStore: ChatDataStore? { get }
}

final class ChatRouter: ChatRoutingLogic, ChatDataPassing {
    
    weak var viewController: ChatViewController?
    var dataStore: ChatDataStore?
    
    func routeToPHPicker() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: nil))
        
        alert.addAction(UIAlertAction(title: "Photo & Video Library", style: .default, handler: { _ in
            var config = PHPickerConfiguration()
            config.selectionLimit = 10
            let pickerController = PHPickerViewController(configuration: config)
            pickerController.delegate = self.viewController
            self.viewController?.present(pickerController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        viewController?.present(alert, animated: true, completion: nil)
    }
}
