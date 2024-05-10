//
//  TripCellView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import SwiftUI

struct TripCellView: View {
    
    var trip: Trip

    var body: some View {
        HStack {
            VStack {
                Text(Date.getDayForDate(from: trip.startTime))
                    .font(.title)
                Text(Date.getAbbreviationForMonth(from: trip.startTime).uppercased())
                    .font(.caption)
                Text(trip.status)
                    .frame(width: 60, height: 20)
                    .font(.system(size: 10))
                    .foregroundColor(.black)
                    .background(getBadgeStyle(for: trip.status))
                    .cornerRadius(10)
                    .padding([.top], 15)
                
                Spacer()
            }.padding([.leading], 10)

            Divider()
                .padding([.trailing], 20)
                .padding([.leading], 15)

            VStack(alignment: .leading) {
                Text(trip.description)
                    .font(.system(size:16))
                    .bold()
                    .lineLimit(1)
                Text("by \(trip.driverName)")
                    .font(.system(size:14))
                    .foregroundStyle(.gray)
                HStack {
                    Image("tripVisualizer")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 58)
                        .padding(.trailing, 5)
                    VStack(alignment: .leading) {
                        Text("\(Date.getHourForDate(from: trip.startTime)) • \(trip.origin.address)")
                            .font(.system(size:12))
                            .lineLimit(1)
                            .padding([.bottom], 3)
                        Text(getVerboseForStops(count: trip.validStops.count))
                            .font(.system(size:12))
                            .lineLimit(1)
                            .padding([.top, .bottom], 0)
                        Text("\(Date.getHourForDate(from: trip.endTime)) • \(trip.destination.address)")
                            .font(.system(size:12))
                            .lineLimit(1)
                            .padding([.top], 3)
                    }
                }
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(20)
        .contentShape(Rectangle())
    }
    
    // MARK: - Private methods
    
    private func getBadgeStyle(for status: String) -> Color {
        switch status {
            case "cancelled", "finalized":
                return .highlightAppColor
            default:
                return .primaryAppColor
        }
    }
    
    private func getVerboseForStops(count: Int) -> String {
        return count > 0 ? String(trip.stops.count) + " stops" : "non-stop"
    }
}

#Preview {
    ContentView()
}
