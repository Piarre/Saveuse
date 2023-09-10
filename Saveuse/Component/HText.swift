//
//  SwiftUIView.swift
//  Saveuse
//
//  Created by Pierre Idé on 10/09/2023.
//

import SwiftUI

struct HText: View {
    var property: String = ""
    var value: String = ""
    
    var body: some View {
        HStack {
            Text(property)
                .foregroundStyle(.tint)
            Spacer()
            Text(value)
        }
    }
}
