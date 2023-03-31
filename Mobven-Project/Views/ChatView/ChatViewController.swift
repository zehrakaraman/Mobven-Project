//
//  ChatViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 30.03.2023.
//

import UIKit
import Photos
import PhotosUI

protocol ChatDisplayLogic: AnyObject {
    
}

final class ChatViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIStackView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var lastSeen: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyViewText: UIStackView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var interactor: ChatBusinessLogic?
    var router: (ChatRoutingLogic & ChatDataPassing)?
    
    var images: [UIImage]? {
        didSet {
            if let images = images, !images.isEmpty {
                collectionView.isHidden = false
                emptyViewText.isHidden = true
            } else {
                collectionView.isHidden = true
                emptyViewText.isHidden = false
            }
        }
    }
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userName.text = router?.dataStore?.user?.fullName
        lastSeen.text = router?.dataStore?.user?.updatedAt
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(.init(nibName: "ChatCollectionViewCell", bundle: .main),
                                forCellWithReuseIdentifier: ChatCollectionViewCell.identifier)
        
        collectionView.cornerRadius = 20.0
        collectionView.isHidden = true
        emptyViewText.isHidden = false
        configureTextField([messageTextField])
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = ChatInteractor()
        let presenter = ChatPresenter()
        let router = ChatRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func compositionalLayoutConfiguration() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupLayout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func updateView(images: [UIImage]?) {
        self.images = images
        
        collectionView.collectionViewLayout = compositionalLayoutConfiguration()
        collectionView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    @IBAction func videoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            
        }))
        
        alert.addAction(UIAlertAction(title: "Photo & Video Library", style: .default, handler: { _ in
            self.openLibrary()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func emojiButtonTapped(_ sender: Any) {
    }
    
    func openLibrary() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 10
        let pickerController = PHPickerViewController(configuration: config)
        pickerController.delegate = self
        present(pickerController, animated: true)
    }
    
}

extension ChatViewController: ChatDisplayLogic {
    
}

extension ChatViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        var images: [UIImage] = []
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { object, error in
                guard let image = object as? UIImage else { return }
                DispatchQueue.main.async {
                    images.append(image)
                }
            }
        }
        updateView(images: images)
    }
}

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 0 }
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.identifier, for: indexPath) as? ChatCollectionViewCell,
              let image = images?[indexPath.item]
            else { return UICollectionViewCell() }
        cell.imageView.image = image
        return cell
    }
}

