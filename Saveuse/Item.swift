//
//  Item.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
