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
    
    private func generateCompositonalLayout(imageCount: Int) -> UICollectionViewLayout {
        switch imageCount {
        case 1: return compositionalLayoutConfiguration1()
        case 2: return compositionalLayoutConfiguration2()
        case 3: return compositionalLayoutConfiguration3()
        default: return compositionalLayoutConfiguration4()
        }
    }
    
    private func compositionalLayoutConfiguration1() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupLayout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func compositionalLayoutConfiguration2() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupLayout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func compositionalLayoutConfiguration3() -> UICollectionViewLayout {
        let sizeForDouble = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let doubleItems = NSCollectionLayoutItem(layoutSize: sizeForDouble)
        doubleItems.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupSizeForDouble = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSizeForDouble, subitems: [doubleItems, doubleItems])
        let sizeForSingle = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
        let singleItem = NSCollectionLayoutItem(layoutSize: sizeForSingle)
        singleItem.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 0)
        let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [group, singleItem])
        let section = NSCollectionLayoutSection(group: mainGroup)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func compositionalLayoutConfiguration4() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        let groupLayout = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(0.5))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item, item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func updateView(images: [UIImage]) {
        self.images = images
        
        collectionView.collectionViewLayout = generateCompositonalLayout(imageCount: images.count)
        collectionView.reloadData()
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
    }
    
    @IBAction func videoButtonTapped(_ sender: Any) {
    }
    
    @IBAction func callButtonTapped(_ sender: Any) {
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        router?.routeToPHPicker()
    }
    
    @IBAction func emojiButtonTapped(_ sender: Any) {
    }
}

extension ChatViewController: ChatDisplayLogic {
    
}

extension ChatViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        dismiss(animated: true)
        
        let imageItems = results
                .map { $0.itemProvider }
                .filter { $0.canLoadObject(ofClass: UIImage.self) }
            
        let dispatchGroup = DispatchGroup()
        var images = [UIImage]()
        
        for imageItem in imageItems {
            dispatchGroup.enter() 
            
            imageItem.loadObject(ofClass: UIImage.self) { image, _ in
                if let image = image as? UIImage {
                    images.append(image)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.updateView(images: images)
        }
    }
}

extension ChatViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let images = images else { return 0 }
        return images.count >= 4 ? 4 : images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.identifier, for: indexPath) as? ChatCollectionViewCell
            else { return UICollectionViewCell() }
        guard let images else { return cell }
        
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}

