//
//  ContentView.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var currentTab: String = "Expenses"
    
    var body: some View {
        TabView(selection: $currentTab) {
            ExpensesView(currentTab: $currentTab)
                .tag("Expenses")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                    Text("Expenses")
                }
            
            CategoryView()
                .tag("Categories")
                .tabItem {
                    Image(systemName: "list.clipboard.fill")
                    Text("Categories")
                }
        }
    }
}

#Preview {
    ContentView()
}
