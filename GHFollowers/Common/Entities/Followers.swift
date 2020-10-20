//
//  Followers.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 27/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation

typealias Followers = [Follower]

struct Follower: Codable {
    let user: String
    let avatarUrl: String
    let htmlUrl: String

    private enum CodingKeys: String, CodingKey {
        case user = "login"
        case avatarUrl = "avatar_url"
        case htmlUrl = "html_url"
    }
}


extension Follower: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(user)
    }

    static func == (lhs: Follower, rhs: Follower) -> Bool {
      lhs.user == rhs.user
    }
}
