//
//  FollowerListInteractor.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 28/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation

protocol FollowersInteractorProtocol {
    func getFollowers(for user: String)
}

class FollowerListInteractor: FollowersInteractorProtocol {
    private let serviceManager: ServiceProtocol

    var presenter: FollowersPresenterProtocol?

    init(serviceManager: ServiceProtocol = ServiceManager()) {
        self.serviceManager = serviceManager
    }

    func getFollowers(for user: String) {
        serviceManager.request(type: .getFollowersFor(user: user)) { (result: Result<Followers,Error>) in
            DispatchQueue.main.async { [weak self] in
                switch result {
                case .success(let followers):
                    self?.presenter?.present(followers)
                case .failure(let e):
                    print(e)
                    self?.presenter?.presentError()
                }
            }
        }
    }

}
