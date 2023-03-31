//
//  MainCollectionViewCell.swift
//  Mobven-Project
//
//  Created by Zehra on 25.03.2023.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    static let nibName = "MainCollectionViewCell"
    static let identifier = "MainCollectionViewCell"

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var emptyViewText: UILabel!
    
    var viewModel: [Home.Case.ViewModel.GroupsModel]? {
        didSet {
            if let viewModel = viewModel, !viewModel.isEmpty {
                emptyViewText.isHidden = true
            } else {
                emptyViewText.isHidden = false
            }
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(.init(nibName: "CommunityListCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "CommunityListCollectionViewCell")
        
        emptyViewText.isHidden = false
    }
}

extension MainCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommunityListCollectionViewCell", for: indexPath) as? CommunityListCollectionViewCell
        else { return UICollectionViewCell() }
        
        DispatchQueue.main.async {
            guard let model = self.viewModel?[indexPath.item] else { return }
            cell.configure(model: model)
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 210, height: 134)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
}

