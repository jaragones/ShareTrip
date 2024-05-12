//
//  FiltersView.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. Container for filter buttons

import SwiftUI

struct FiltersView: View {
    
    @Binding var selectedFilter: FilterOptions
    
    var body: some View {
        HStack {
            filterButton(title: "All trips", value: .all)
            filterButton(title: "Scheduled", value: .scheduled)
            filterButton(title: "On going", value: .onGoing)
        }
    }
    
    private func filterButton(title: String, value: FilterOptions) -> some View {
        FilterButton(title: title, isSelected: selectedFilter == value) {
            setFilter(value)
        }
    }

    private func setFilter(_ value: FilterOptions) {
        $selectedFilter.wrappedValue = value
    }
}
