//
//  SearchViewController.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 22/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import UIKit

private struct Constant {
    static let padding: CGFloat = 24
    static let topMarging: CGFloat = 50
}

class SearchViewController: UIViewController {
    var router: RoutingSearchViewProtocol?


    // Views
    var mainView = MainView()
    var getFollowersButton = UIButton(type: .system)

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        view.backgroundColor = .systemBackground
        setUpFollowersButton()
        self.view.addSubview(mainView)
        self.view.addSubview(getFollowersButton)
        setContraints()
        self.dismissKeyBoardIfExists()
    }

    private func setUp() {
        let router = SearchRoute()
        router.viewController = self
        self.router = router
    }


    func setContraints() {
        //Main
        mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constant.padding).isActive = true
        mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constant.padding).isActive = true
        mainView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: Constant.topMarging).isActive = true
        mainView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.4).isActive = true

        // Button
        getFollowersButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        getFollowersButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Constant.padding).isActive = true
        getFollowersButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -Constant.padding).isActive = true
        getFollowersButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -Constant.padding).isActive = true
        getFollowersButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    func setUpFollowersButton() {
        getFollowersButton.translatesAutoresizingMaskIntoConstraints = false
        getFollowersButton.backgroundColor = .systemGreen
        getFollowersButton.tintColor = .white
        getFollowersButton.setTitle("Get Followers", for: .normal)
        getFollowersButton.layer.cornerRadius = 5
        getFollowersButton.addTarget(self, action: #selector(getFollowers), for: .touchUpInside)
    }
}

extension SearchViewController {

    //vc.modalTransitionStyle = .coverVertical
    //view.addSubview(vc.view)
    //addChild(vc)
    //vc.didMove(toParent: self)

    @objc private func getFollowers() {
        guard !mainView.isUserNameEmpty else {
            router?.showAlert()
            return
        }
        router?.routeToFollowersWithName(mainView.userName.text ?? "")
    }
}
