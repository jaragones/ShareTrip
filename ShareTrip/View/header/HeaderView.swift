//
//  HeaderView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. Header used in main view

import SwiftUI

struct HeaderView: View {

    @State private var showingContactForm = false

    var body: some View {
        VStack(spacing:0) {
            HStack {
                Spacer()
                Image("logo_SEATCode")
                    .padding(.leading, 15)
                Spacer()
                Image("ic_bug")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                    .padding(.trailing, 15)
                    .onTapGesture {
                        showingContactForm = true
                    }
                    .sheet(isPresented: $showingContactForm) {
                        ContactFormView(isPresented: $showingContactForm).accessibilityIdentifier("ContactFormView")
                    }.accessibilityIdentifier("Report an Issue")
            }
            Rectangle()
                .fill(Color.primaryAppColor)
                .frame(height: 5)
        }
    }
}

