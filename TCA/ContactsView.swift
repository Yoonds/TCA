//
//  ContactsView.swift
//  TCA
//
//  Created by Yoon Daesung on 4/15/24.
//

import SwiftUI
import ComposableArchitecture

struct ContactsView: View {
    // ContactFeature 관찰
  let store: StoreOf<ContactsFeature>
  
  var body: some View {

    NavigationStack {
      List {
        ForEach(store.contacts) { contact in
          Text(contact.name)
        }
      }
      .navigationTitle("Contacts")
      .toolbar {
        ToolbarItem {
          Button {
            store.send(.addButtonTapped)
          } label: {
            Image(systemName: "plus")
          }
        }
      }
    }
  }
    
}

// 예시 표기
#Preview {
  ContactsView(
    store: Store(
      initialState: ContactsFeature.State(
        contacts: [
          Contact(id: UUID(), name: "Blob"),
          Contact(id: UUID(), name: "Blob Jr"),
          Contact(id: UUID(), name: "Blob Sr"),
        ]
      )
    ) {
      ContactsFeature()
    }
  )
}
