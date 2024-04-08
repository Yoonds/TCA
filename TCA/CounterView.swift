//
//  ContentView.swift
//  TCA
//
//  Created by YoonDaesung on 4/8/24.
//

import ComposableArchitecture
import SwiftUI

struct CounterView: View {
    
    // store - 감시할 Reducer 인스턴스 생성
    // @Reducer로 선언한 CounterFeature를 주입하여 감시
    // @ObservableStated로 State를 선언하였기 때문에 자동으로 감시
    let store: StoreOf<CounterFeature>
 
    var body: some View {
        VStack {
            Text("\(store.count)")
                .font(.largeTitle)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            HStack {
                Button("-") {
                    store.send(.decrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
                
                Button("+") {
                    store.send(.incrementButtonTapped)
                }
                .font(.largeTitle)
                .padding()
                .background(Color.gray)
                .cornerRadius(10)
            }
            // 네트워크 요청 예정 버튼
            Button("Fact") {
              store.send(.factButtonTapped)
            }
            .font(.largeTitle)
            .padding()
            .background(Color.black.opacity(0.1))
            .cornerRadius(10)
            
            if store.isLoading {
                ProgressView()
            } else if let fact = store.fact {
                Text(fact)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
    }
}

#Preview {
    CounterView(
        store: Store(initialState: CounterFeature.State()) {
            CounterFeature()
        }
    )
}
