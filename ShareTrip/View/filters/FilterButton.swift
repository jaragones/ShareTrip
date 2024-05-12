//
//  FilterButton.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. View used to avoid code duplication on filter buttons.

import SwiftUI

struct FilterButton: View {
    var title: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size:16))
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.primaryAppColor : Color.highlightAppColor)
                .foregroundColor(.black)
                .cornerRadius(60)
        }
    }
}
