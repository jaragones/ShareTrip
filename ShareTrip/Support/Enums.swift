//
//  Enums.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

// Filter options for shown trips
enum FilterOptions: Int {
    case all = 1
    case scheduled = 2
    case onGoing = 3
}

// Customized error to handle errors from webservice
enum ResponseError: Error {
    case wrongURLError
    case wrongDataError
    case parseDataError(String)
}
