//
//  AccountProfileViewController.swift
//  Mobven-Project
//
//  Created by Zehra on 31.03.2023.
//

import UIKit

protocol AccountProfileDisplayLogic: AnyObject {
    func displayProfile(viewModel: Account?)
}

class AccountProfileViewController: UIViewController {
    static let identifier = "AccountProfileViewController"
    
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    private var dataSource: DataSource!
    
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var interactor: AccountProfileBusinessLogic?
    var router: (AccountProfileRoutingLogic & AccountProfileDataPassing)?
    var viewModel: AccountProfile.Case.ViewModel?
    
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
        
        configure()
        
        interactor?.loadProfile()
        
        let listLayout = listLayout()
        collectionView.collectionViewLayout = listLayout
        
        let cellRegistartion = UICollectionView.CellRegistration(handler: cellRegistrationHandler)
        
        dataSource = DataSource(collectionView: collectionView) { (collectionView: UICollectionView, indexPath: IndexPath, identifier: Row) in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistartion, for: indexPath, item: identifier)
        }
        
        collectionView.dataSource = dataSource
        
        prepareForViewing()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if editing {
            prepareForEditing()
        } else {
            prepareForViewing()
        }
    }
    
    private func listLayout() -> UICollectionViewCompositionalLayout {
        var listConfiguration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        listConfiguration.headerMode = .firstItemInSection
        listConfiguration.showsSeparators = false
        listConfiguration.backgroundColor = .clear
        return UICollectionViewCompositionalLayout.list(using: listConfiguration)
    }
    
    private func prepareForEditing() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .cancel,
            target: self,
            action: #selector(didCancelEdit))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.topConstraint.constant = 120
            self.heightConstraint.constant = 600
            self.view.layoutIfNeeded()
        })
        
        updateSnapshotForEditing()
    }
    
    private func updateSnapshotForEditing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.name, .gender, .birthOfDate])
        snapshot.appendItems([.header(Section.name.title), .editText(router?.dataStore?.account?.fullName)], toSection: .name)
        snapshot.appendItems([.header(Section.gender.title), .editGender((router?.dataStore?.profileData?.gender)!)], toSection: .gender)
        snapshot.appendItems([.header(Section.birthOfDate.title), .editDate((router?.dataStore?.profileData?.dateOfBirth)!)], toSection: .birthOfDate)
        dataSource.apply(snapshot)
    }
    
    private func prepareForViewing() {
        navigationItem.leftBarButtonItem = nil
        
        UIView.animate(withDuration: 0.2, animations: {
            self.topConstraint.constant = 320
            self.heightConstraint.constant = 247
            self.view.layoutIfNeeded()
        })
        
        updateSnapshotForViewing()
    }
    
    private func updateSnapshotForViewing() {
        var snapshot = Snapshot()
        snapshot.appendSections([.view])
        snapshot.appendItems([.header(""), .viewName, .viewGender, .viewDate])
        dataSource.apply(snapshot)
    }
    
    func cellRegistrationHandler(cell: UICollectionViewListCell, indexPath: IndexPath, row: Row) {
        let section = section(for: indexPath)
        switch (section, row) {
        case (_, .header(let title)):
            cell.contentConfiguration = headerConfiguration(for: cell, with: title)
        case (.view, _):
            cell.contentConfiguration = defaultConfiguration(for: cell, at: row)
        case (.name, .editText(let name)):
            cell.contentConfiguration = nameConfiguration(for: cell, with: name)
        case (.gender, .editGender(let gender)):
            cell.contentConfiguration = genderConfiguration(for: cell, with: gender)
        case (.birthOfDate, .editDate(let date)):
            cell.contentConfiguration = dateConfiguration(for: cell, with: date)
        default:
            fatalError("Unexpected combination of section and row.")
        }
    }
    
    private func section(for indexPath: IndexPath) -> Section {
        let sectionNumber = isEditing ? indexPath.section + 1 : indexPath.section
        guard let section = Section(rawValue: sectionNumber) else {
            fatalError("Unable to find matching section")
        }
        return section
    }
    
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = AccountProfileInteractor()
        let presenter = AccountProfilePresenter()
        let router = AccountProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    func configure() {
        navigationItem.rightBarButtonItem = editButtonItem
        accountImage.backgroundColor = UIColor(named: "Purple - Soft")
        collectionView.backgroundColor = UIColor(named: "White")
        collectionView.layer.cornerRadius = 50.0
        
        guard var isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        darkModeSwitch.setOn(isDarkMode, animated: true)
    }
    
    @objc func didCancelEdit() {
        setEditing(false, animated: true)
    }
    
    @IBAction func switchDarkMode(_ sender: UISwitch) {
        guard var isDarkMode = UserDefaults.standard.object(forKey: "isDarkMode") as? Bool else { return }
        
        if darkModeSwitch.isOn {
            isDarkMode = true
        } else {
            isDarkMode = false
        }
        
        if let window = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene}).compactMap({ $0 }).first?.windows.first {
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
}

extension AccountProfileViewController: AccountProfileDisplayLogic {
    func displayProfile(viewModel: Account?) {
       
    }
}
