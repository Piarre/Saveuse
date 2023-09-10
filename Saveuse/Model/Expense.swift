//
//  Expense.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import Foundation
import SwiftData

@Model
class Expense {
    var title: String
    var subTitle: String
    var amount: Double
    var date: Date
    var category: Category?
    
    init(title: String, subTitle: String, amount: Double, date: Date, category: Category? = nil) {
        self.title = title
        self.subTitle = subTitle
        self.amount = amount
        self.date = date
        self.category = category
    }
    
    @Transient
    var currenctString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        
        return formatter.string(for: amount) ?? ""
    }
}
