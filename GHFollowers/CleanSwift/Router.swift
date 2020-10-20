//
//  Router.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 11/08/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation

protocol RoutingSearchViewProtocol {
    func routeToFollowersWithName(_ name: String)
    func showAlert()
}


class SearchRoute: RoutingSearchViewProtocol {
    weak var viewController: SearchViewController?

    func routeToFollowersWithName(_ name: String) {
        let followerListVC = FollowerListViewController()
        followerListVC.userName = name
        viewController?.show(followerListVC, sender: nil)
    }

    func showAlert() {
        //TODO: Use string.Localizable
        let alertVC = CustomAlertViewController()
        alertVC.set(title: "Something Went Wrong",
                    desc: "Please enter a username. We need to know who to took for.")

        alertVC.modalPresentationStyle = .overFullScreen
        viewController?.present(alertVC, animated: false)
    }


}

