//
//  MapBubbleView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 10/5/24.
//
//  Description. Custom infoWindow for markers.

import SwiftUI

struct MapBubbleView: View {
    var address, time, username: String
    var price: Double
    var type: BubbleType

    init(type: BubbleType, address: String, time: String, price: Double, username: String) {
        self.address = address
        self.time = time
        self.username = username
        self.price = price
        self.type = type
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(getTitleFor(type: self.type))
                .font(.subheadline)
                .bold()
            HStack{
                Image("ic_location")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                Text("\(self.address)")
                    .font(.system(size: 11))
            }
            HStack{
                Image("ic_time")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                Text("\(Date().fromStringWithFormat(str: self.time)!.formatted())")
                    .font(.system(size: 11))
            }
            HStack{
                Image("ic_person")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 10, height: 10)
                Text("\(self.username)")
                    .font(.system(size: 11))
            }
            if type == .stop {
                HStack {
                    Image("ic_money")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 10)
                    Text(stringifyPrice(price: price)) // Use internalPrice
                        .font(.system(size: 11))
                }
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }

    func stringifyPrice(price: Double) -> String {
        return String(format: "$%.2f", price)
    }

    func getTitleFor(type: BubbleType) -> String {
        switch type {
        case .stop:
            return "Requested stop"
        case .start:
            return "Starting point"
        case .end:
            return "Ending point"
        }
    }
}
