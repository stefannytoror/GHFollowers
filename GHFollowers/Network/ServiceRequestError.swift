//
//  ServiceRequestError.swift
//  GHFollowers
//
//  Created by Stefanny Toro Ramirez on 27/07/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import Foundation

enum ServiceRequestError: Error {
    case failBuildingURL
    case failDecodingResponse(error: Error)
    case noValidResponse(error: Error?)
    case noResponse(error: Error?)
    case unknown
}
