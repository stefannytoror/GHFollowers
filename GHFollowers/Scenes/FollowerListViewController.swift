//
//  FollowerListViewController.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 3/08/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import UIKit

protocol FollowersViewProtocol: class {
    func display(followers: Followers)
    func displayEmptyView()
}

enum Section {
  case main
}

typealias DataSource = UICollectionViewDiffableDataSource<Section, Follower>
typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Follower>

class FollowerListViewController: UIViewController {

    private enum Constant {
        static let lineSpacing: CGFloat = 20
        static let borderInsets: CGFloat = 10
        static let numberOfItemsInRow: CGFloat = 3
        static let insets = UIEdgeInsets(top: Constant.borderInsets,
                                         left: Constant.borderInsets,
                                         bottom: 0, right: Constant.borderInsets)
    }

    var interactor: FollowerListInteractor?

    var userName: String = ""

    private var followers: Followers = []
    private var allFollowers: Followers = []

    private lazy var diffableDataSource = makeDataSource() // Lazy vars are closures too

    // MARK: - Views
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = Constant.lineSpacing
        layout.minimumLineSpacing = Constant.lineSpacing
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground
        return collectionView
    }()

    private var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.color = .systemGreen
        return activity
    }()

    // MARK: - Init
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setUp()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }

    private func setUp() {
        let vc = self
        let interactor = FollowerListInteractor()
        let presenter = FollowerListPresenter()
        vc.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = vc
    }

     // MARK: - View Life cycle
    override func viewWillAppear(_ animated: Bool) {
         navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        interactor?.getFollowers(for: userName)
        setupViews()
    }


    // MARK: - Setup Views
    private func setupViews() {
        setupNavBar()
        setUpCollectionView()
        setUpLoadingView()
        viewDidLayoutSubviews()
    }

    private func setupNavBar() {
        title = userName
        navigationController?.navigationBar.prefersLargeTitles = true
        let search = UISearchController(searchResultsController: nil)
        search.searchBar.placeholder = "Search user"
        search.searchBar.sizeToFit()
        search.searchResultsUpdater = self
        navigationItem.searchController = search
    }

    private func setUpCollectionView() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
        ])
        //register cell
        collectionView.register(FollowerViewCell.self, forCellWithReuseIdentifier: "FollowerViewCell")

        collectionView.delegate = self
        //collectionView.dataSource = self
    }

    private func setUpLoadingView() {
        self.view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
}

// MARK: - Datasource and Delegate
extension FollowerListViewController: UICollectionViewDelegateFlowLayout {
    func makeDataSource() -> DataSource {
        let dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FollowerViewCell", for: indexPath) as? FollowerViewCell
            cell?.configure(imageString: follower.avatarUrl, label: follower.user)
            return cell
        }
        return dataSource
    }

    func applySnapShot() {
        var snapShot = Snapshot()
        snapShot.appendSections([.main])
        snapShot.appendItems(followers)
        diffableDataSource.apply(snapShot, animatingDifferences: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offset = Constant.lineSpacing * (Constant.numberOfItemsInRow + 1)
        let width = floor((collectionView.frame.width - offset) / Constant.numberOfItemsInRow)
        let height = width + 35
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constant.insets
    }
}

// MARK: - Presenter
extension FollowerListViewController: FollowersViewProtocol {
    func display(followers: Followers) {
        self.followers = followers
        self.allFollowers = followers
        self.activityIndicator.stopAnimating()
        self.applySnapShot()
    }

    func displayEmptyView() {
        let view = EmptyStateView(frame: self.view.frame)
        self.activityIndicator.stopAnimating()
        self.view.addSubview(view)
    }
}

// MARK: - Search Delegate
extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let filteredFollowers = allFollowers
        if let text = searchController.searchBar.text, !text.isEmpty {
            followers = filteredFollowers.filter { $0.user.localizedCaseInsensitiveContains(text) }
        } else {
            followers = filteredFollowers
        }
        applySnapShot()
    }
}
