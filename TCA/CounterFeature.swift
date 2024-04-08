//
//  CounterFeature.swift
//  TCA
//
//  Created by YoonDaesung on 4/8/24.
//

import ComposableArchitecture

// @Reducer - 외부에서의 액션을 수신 (상태 관리자)
@Reducer
struct CounterFeature {
    
    // @ObservableState - 통해 상태를 감시하도록 세팅
    @ObservableState
    struct State {
        // 상태관리 변수
        var count = 0
        
    }
    
    // Action - 액션을 정의
    // 주의1 - Action enum명은 변경하지 않기
    // 주의2 - 액션에 대한 논리적인 함수명이 아닌 사용자가 수행하는 행동 그대로를 함수명으로 지정
    enum Action {
        
        case decrementButtonTapped
        case incrementButtonTapped
        
    }
    
    // Reduce
    // 사용자가 사용한 액션 및 state를 직접적으로 참조하여 업데이트
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .decrementButtonTapped:
                    state.count -= 1
                    print("-수신")
                    return .none
                case .incrementButtonTapped:
                    state.count += 1
                    print("+수신")
                    return .none
            }
        }
    }
    
}
