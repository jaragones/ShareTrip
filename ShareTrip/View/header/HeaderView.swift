//
//  HeaderView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack(spacing:0) {
            HStack {
                Spacer()
                Image("logo_SEATCode")
                Spacer()
            }
            Rectangle()
                .fill(Color.primaryAppColor)
                .frame(height: 5)
        }
    }
}

