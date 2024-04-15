//
//  ContactFeature.swift
//  TCA
//
//  Created by Yoon Daesung on 4/15/24.
//

import Foundation
import ComposableArchitecture
import SwiftUI

struct Contact: Equatable, Identifiable {
    let id: UUID
    var name: String
}

@Reducer
struct ContactsFeature {
    
    @ObservableState
    struct State: Equatable {
        var contacts: IdentifiedArrayOf<Contact> = []
    }
    
    enum Action {
        case addButtonTapped
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .addButtonTapped:
                    // TODO: Handle action
                    return .none
            }
        }
    }
    
}

// 새 연락처 입력 기능
@Reducer
struct AddContactFeature {
    
    @ObservableState
    struct State: Equatable {
        var contact: Contact
    }
    
    enum Action {
        case cancelButtonTapped
        case saveButtonTapped
        case setName(String)
    }
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                case .cancelButtonTapped:
                    return .none
                    
                case .saveButtonTapped:
                    return .none
                    
                case let .setName(name):
                    state.contact.name = name
                    return .none
            }
        }
    }
}

struct AddContactView: View {
    @Bindable var store: StoreOf<AddContactFeature>
    
    var body: some View {
        Form {
            TextField("Name", text: $store.contact.name.sending(\.setName))
        }
    }
}
