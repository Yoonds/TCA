//
//  TCAApp.swift
//  TCA
//
//  Created by YoonDaesung on 4/8/24.
//

import SwiftUI
import ComposableArchitecture

@main
struct TCAApp: App {
    
    // Store는 앱이 구동하는 동안 한번만 생성되어야 한다.
    static let store = Store(initialState: CounterFeature.State()) {
        CounterFeature()
            ._printChanges() // reducer에서 호출된 내용을 로그로 출력
    }
    
    var body: some Scene {
        WindowGroup {
            CounterView(store: TCAApp.store)
        }
    }
}
