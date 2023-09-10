//
//  CategoryView.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import SwiftUI
import SwiftData

struct CategoryView: View {
    @Query(animation: .snappy) private var allCategories: [Category]
    @Environment(\.modelContext) private var context
    
    @State private var deleteRequest: Bool = false
    @State private var requestedCategory: Category?
    
    @State private var addCategory: Bool = false
    
    @State private var categoryName: String = "";
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Error"
    @State private var isSettingsShown: Bool = false;
    
    var body: some View {
        NavigationView {
            List {
                ForEach(allCategories.sorted(by: { ($0.expenses?.count ?? 0) > ($1.expenses?.count ?? 0) })) { category in
                    DisclosureGroup {
                        if let expenses = category.expenses, !expenses.isEmpty {
                            ForEach(expenses) { expense in
                                ExpenseCardView(expense: expense, displayTag: false)
                            }
                        } else {
                            ContentUnavailableView {
                                Label("No Expenses", systemImage: "tray.fill")
                            }
                        }
                    } label: {
                        Text(category.categoryName)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    deleteRequest.toggle()
                                    requestedCategory = category
                                } label: {
                                    Image(systemName: "trash")
                                }
                                .tint(.red)
                            }
                    }
                    
                }
            }
            .navigationTitle("Categories")
            .overlay {
                if allCategories.isEmpty {
                    ContentUnavailableView {
                        Label("No Expenses", systemImage: "tray.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isSettingsShown.toggle()
                    } label: {
                        Image(systemName: "gear.circle.fill")
                            .font(.title3)
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        addCategory.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title3)
                    }
                }
            }
            .sheet(isPresented: $isSettingsShown) {
                
            } content: {
                NavigationStack {
                    Form {
                        Section("About") {
                            HText(property: "Developer", value: "Pierre (Piarre) IDÉ")
                            HText(property: "Version", value: "\(version)")
                        }
                    }
                    .navigationTitle("Settings")
                    .navigationBarTitleDisplayMode(.inline)
                }
                .presentationDetents([.height(220)])
                .presentationCornerRadius(20)
            }
            .sheet(isPresented: $addCategory) {
                categoryName = ""
            } content: {
                NavigationStack {
                    List {
                        Section("Title") {
                            TextField("General", text: $categoryName)
                        }
                    }
                    .navigationTitle("Category Name")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarLeading) {
                            Button("Cancel") {
                                addCategory = false
                            }
                            .tint(.red)
                        }
                        
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Add") {
                                let category = Category(categoryName: categoryName)
                                context.insert(category)
                                
                                categoryName = ""
                                addCategory = false
                            }
                            .disabled(categoryName.isEmpty)
                        }
                    }
                }
                .presentationDetents([.height(180)])
                .presentationCornerRadius(20)
                .interactiveDismissDisabled()
            }
            .alert("Are you sure you want to delete this category, all the assioceted expenses will be deleted to", isPresented: $deleteRequest) {
                Button(role: .destructive) {
                    if let requestedCategory {
                        context.delete(requestedCategory)
                        self.requestedCategory = nil
                    }
                } label: {
                    Text("Delete")
                }
                
                Button(role: .cancel) {
                    requestedCategory = nil
                } label: {
                    Text("Cancel")
                }
            }
        }
    }
}

#Preview {
    CategoryView()
}
