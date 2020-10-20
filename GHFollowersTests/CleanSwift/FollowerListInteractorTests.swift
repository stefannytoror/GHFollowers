//
//  FollowerListInteractorTests.swift
//  GHFollowersTests
//
//  Created by Stefanny Toro Ramirez on 25/09/20.
//  Copyright © 2020 Stefanny Toro Ramirez. All rights reserved.
//

import XCTest
@testable import GHFollowers

class FollowerListInteractorTests: XCTestCase {
    
    var interactor: FollowerListInteractor!
    var mockPresenter = MockFollowerListPresenter()
    var serviceManager = MockServiceManager()

    override func setUpWithError() throws {
        interactor = FollowerListInteractor(serviceManager: serviceManager)
        interactor.presenter = mockPresenter
    }

    override func tearDownWithError() throws {
        serviceManager.reset()
    }

    func testGetFollowersSucessfull_emptyValue() throws {
        // Given
        serviceManager.isSuccessfull = true

        // When
        interactor.getFollowers(for: "")

        // Then
        let methods = serviceManager.CalledMethods
        let presenterMethod = mockPresenter.calledMethod

        XCTAssertTrue(!methods.isEmpty)
        XCTAssertEqual(methods, [.request,.successRequest])
        XCTAssertEqual(presenterMethod, .presentEmptyState)
    }

    func testGetFollowersSucessfull_completeValue() throws {
        // Given
        serviceManager.isSuccessfull = true
        let follower = Follower(user: "user01", avatarUrl: "avatar", htmlUrl: "user01.co")
        serviceManager.result = [follower]

        // When
        interactor.getFollowers(for: "user")

        // Then
        let methods = serviceManager.CalledMethods
        let presenterMethod = mockPresenter.calledMethod

        XCTAssertTrue(!methods.isEmpty)
        XCTAssertEqual(methods, [.request,.successRequest])
        XCTAssertEqual(presenterMethod, .presentSuccessfull)
    }

    func testGetFollowersFailure() throws {
        // Given
        serviceManager.isSuccessfull = false

        // When
        interactor.getFollowers(for: "user")

        // Then
        let methods = serviceManager.CalledMethods
        let presenterMethod = mockPresenter.calledMethod

        XCTAssertTrue(!methods.isEmpty)
        XCTAssertEqual(methods, [.request,.failureRequest])
        XCTAssertEqual(presenterMethod, .presentError)
    }

}
