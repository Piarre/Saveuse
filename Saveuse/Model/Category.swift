//
//  Category.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import Foundation
import SwiftData

@Model
class Category {
    var categoryName: String
    @Relationship(deleteRule: .cascade, inverse: \Expense.category)
    var expenses: [Expense]?
    
    init(categoryName: String) {
        self.categoryName = categoryName
    }
}
