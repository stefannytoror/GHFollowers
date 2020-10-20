//
//  FollowerListPresenter.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 3/08/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation

protocol FollowersPresenterProtocol {
    func present(_ followers: Followers)
    func presentError()
}


class FollowerListPresenter: FollowersPresenterProtocol {
    weak var viewController: FollowersViewProtocol?

    func present(_ followers: Followers) {
        if !followers.isEmpty {
        viewController?.display(followers: followers)
        } else {
            viewController?.displayEmptyView()
        }
    }

    func presentError()  {

    }
}
