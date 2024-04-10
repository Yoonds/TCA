//
//  CounterFeature.swift
//  TCA
//
//  Created by YoonDaesung on 4/8/24.
//

import ComposableArchitecture
import Foundation

// @Reducer - 외부에서의 액션을 수신 (상태 관리자)
@Reducer
struct CounterFeature {
    
    // @ObservableState - 통해 상태를 감시하도록 세팅
    @ObservableState
    struct State {
        // 상태관리 변수
        var count: Int = 0
        var fact: String? = nil
        var isLoading = false
        var isTimerRunning = false
    }
    
    // Action - 액션을 정의
    // 주의1 - Action enum명은 변경하지 않기
    // 주의2 - 액션에 대한 논리적인 함수명이 아닌 사용자가 수행하는 행동 그대로를 함수명으로 지정
    enum Action {
        
        case decrementButtonTapped
        case factButtonTapped
        case factResponse(String)
        case incrementButtonTapped
        case titmerTick
        case toggleTimerButtonTapped
        
    }
    
    enum CancelID {
        
        case timer
        
    }
    
    // Reduce
    // 사용자가 사용한 액션 및 state를 직접적으로 참조하여 업데이트
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .decrementButtonTapped:
                    state.count -= 1
                    state.fact = nil
                    return .none
                    
                // 네트워크 작업
                case .factButtonTapped:
                    state.fact = nil
                    state.isLoading = true
                    
                    // 부작용1: 비동기 함수 호출 시 동시성을 지원하지 않는다.
                    // 부작용2: 오류 처리를 하지 않는다.
                    // 따라서 직접 네트워크 처리를 하지않고 작업을 핸들 하여 전달한다.
                    return .run { [count = state.count] send in
                        let (data, _) = try await URLSession.shared
                            .data(from: URL(string: "http://numbersapi.com/\(count)")!)
                        let fact = String(decoding: data, as: UTF8.self)
                        await send(.factResponse(fact))
                    }
                    
                // 네트워크 작업 내에서 직접적으로 값 주입이 힘든 이유로 만들어준 case
                case .factResponse(let fact):
                    state.fact = fact
                    state.isLoading = false
                    return .none
                    
                case .incrementButtonTapped:
                    state.count += 1
                    state.fact = nil
                    return .none
                    
                case .titmerTick:
                    state.count += 1
                    state.fact = nil
                    return .none
                    
                case .toggleTimerButtonTapped:
                    state.isTimerRunning.toggle()
                    if state.isTimerRunning {
                        return .run { send in
                            while true {
                                // 무한루프 1초 휴식 후 timerTick 동작
                                try await Task.sleep(for: .seconds(1))
                                await send(.titmerTick)
                            }
                        }
                        .cancellable(id: CancelID.timer) // cancle이 가능하도록 세팅
                    } else {
                        return .cancel(id: CancelID.timer) // cancle 동작
                    }
            }
        }
    }
    
}
