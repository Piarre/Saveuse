//
//  AddExpense.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import SwiftUI
import SwiftData

struct AddExpenseView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var title: String = ""
    @State private var subTitle: String = ""
    @State private var date: Date = .init()
    @State private var amount: CGFloat = 0
    @State private var category: Category?
    
    @Query(animation: .snappy) private var allCategories: [Category]
    
    var body: some View {
        NavigationStack {
            List {
                Section("Title") {
                    TextField("MX Master 3S", text: $title)
                }
                
                Section("Description") {
                    TextField("New mouse !!!", text: $subTitle)
                }
                
                Section("Amount spent") {
                    HStack(spacing: 4) {
                        TextField("0.0", value: $amount, formatter: formatter)
                            .keyboardType(.numberPad)
                        Text("€")
                    }
                }
                
                if !allCategories.isEmpty {
                    HStack {
                        Text("Category")
                        
                        Spacer()
                        
                        Menu {
                            ForEach(allCategories) { category in
                                Button(category.categoryName) {
                                    self.category = category
                                }
                            }
                            
                            Button("None") {
                                category = nil
                            }
                        } label: {
                            if let categoryName = category?.categoryName {
                                Text(categoryName)
                            } else {
                                Text("None")
                            }
                        }
                    }
                }
                
                Section("Date") {
                    DatePicker("", selection: $date, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .labelsHidden()
                }
            }
            .navigationTitle("Add new expense")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Add") { addExpense() }
                        .disabled(isAddButtonDisabled)
                }
            }
        }
    }
    
    var isAddButtonDisabled: Bool {
        return title.isEmpty || subTitle.isEmpty || amount == .zero
    }
    
    func addExpense() {
        let expense = Expense(title: title, subTitle: subTitle, amount: amount, date: date, category: category)
        context.insert(expense)
        dismiss()
    }
    
    var formatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

#Preview {
    AddExpenseView()
}
