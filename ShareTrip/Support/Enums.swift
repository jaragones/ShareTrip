//
//  Enums.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description.
//  File that contains enums used in the app.e

// Filter options for shown trips
enum FilterOptions: Int {
    case all = 1
    case scheduled = 2
    case onGoing = 3
}

// Customized error to handle errors from webservice
enum ResponseError: Error, Equatable {
    case wrongURLError
    case wrongDataError
    case parseDataError(String)
    
    static func ==(lhs: ResponseError, rhs: ResponseError) -> Bool {
            switch (lhs, rhs) {
            case (.wrongURLError, .wrongURLError),
                 (.wrongDataError, .wrongDataError):
                return true
            case let (.parseDataError(lhsDescription), .parseDataError(rhsDescription)):
                return lhsDescription == rhsDescription
            default:
                return false
            }
        }
}

// used on MapBubbleView for their types.
enum BubbleType {
    case start
    case end
    case stop
}
