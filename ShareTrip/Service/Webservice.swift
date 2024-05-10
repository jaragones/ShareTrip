//
//  Webservice.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//

import Foundation

// Customized error to handle errors
enum ResponseError: Error {
    case wrongURLError
    case wrongDataError
    case parseDataError(String)
}

class Webservice {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getTripsAsync(url: URL) async throws -> Trips {
        // Retrieving data from the URL
        let (data, response) = try await self.session.data(from: url)
        
        // Check response for a successful HTTP status code
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ResponseError.wrongURLError
        }
        
        // Decoding data into the Trips model
        do {
            let trips = try JSONDecoder().decode([Trip].self, from: data)
            return trips
        } catch {
            // Adding description to our error
            throw ResponseError.parseDataError(error.localizedDescription)
        }
    }
        
    func getStop(stopId: Int, completion: @escaping (Result<StopExtended, Error>) -> Void) {
        guard let url = URL(string: "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/stops.json") else {
            completion(.failure(ResponseError.wrongURLError))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(ResponseError.wrongURLError))
                return
            }
            
            do {
                let stop = try JSONDecoder().decode(StopExtended.self, from: data!)
                completion(.success(stop))
            } catch {
                completion(.failure(ResponseError.parseDataError(error.localizedDescription)))
            }
        }.resume()
    }

}
