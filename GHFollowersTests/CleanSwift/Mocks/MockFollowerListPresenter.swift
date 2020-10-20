//
//  MockFollowerListPresenter.swift
//  GHFollowersTests
//
//  Created by Stefanny Toro Ramirez on 25/09/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation
@testable import GHFollowers

class MockFollowerListPresenter: FollowersPresenterProtocol {
    var calledMethod: Method = .presentError

    enum Method {
        case presentSuccessfull
        case presentEmptyState
        case presentError
    }

    func present(_ followers: Followers) {
        calledMethod = .presentSuccessfull
    }

    func presentEmptyState() {
        calledMethod = .presentEmptyState
    }

    func presentError() {
        calledMethod = .presentError
    }
}
