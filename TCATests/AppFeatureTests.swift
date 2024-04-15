//
//  AppFeatureTests.swift
//  TCATests
//
//  Created by Yoon Daesung on 4/15/24.
//

import ComposableArchitecture
import XCTest
@testable import TCA

@MainActor
final class AppFeatureTests: XCTestCase {
    func testIncrementInFirstTab() async {
        let store = TestStore(initialState: AppFeature.State()) {
            AppFeature()
        }
        
        await store.send(\.tab1.incrementButtonTapped) {
            $0.tab1.count = 1
        }
    }
}
