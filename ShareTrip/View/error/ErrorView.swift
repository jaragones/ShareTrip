//
//  ErrorView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//
//  Description. This view is used to show results or error in ContentView.

import SwiftUI

struct ErrorView: View {
    
    var message: String?
    
    var body: some View {
        VStack {
            Image("error")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding(.bottom, 50)
            Text(message ?? "No results found")
        }

    }
}
