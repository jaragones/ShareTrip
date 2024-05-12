//
//  LoadingOverlay.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. Simple loading view, to show user that app is doing something

import SwiftUI

struct LoadingOverlay: View {
    var body: some View {
        ZStack {
            // Background rectangle with white color and alpha
            Rectangle()
                .fill(Color.white.opacity(0.8))
                .edgesIgnoringSafeArea(.all)

            VStack {
                Image("logo_SEATCode_round")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                    .padding(.top, 80)
                Spacer()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .foregroundColor(.black)
                    .padding(.bottom, 10)

                Text("Loading")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 8)
                    .padding(.bottom, 20)
            }
        }
        
    }
}
