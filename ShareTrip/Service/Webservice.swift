//
//  Webservice.swift
//  ShareTrip
//
//  Created by Jordi Aragones Vilella on 9/5/24.
//
//  Description. External calls are done using Webservice class

import Foundation

class Webservice {
    let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // used to retrieve list of trips
    func getTripsAsync(url: URL) async throws -> Trips {
        // Retrieving data from the URL
        let (data, response) = try await self.session.data(from: url)
        
        // Check response for a successful HTTP status code
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ResponseError.wrongURLError
        }
        
        do {
            // Decoding data into the Trips model
            let trips = try JSONDecoder().decode([Trip].self, from: data)
            return trips
        } catch {
            // Adding description to our error
            throw ResponseError.parseDataError(error.localizedDescription)
        }
    }
        
    // used to retrieve specific stop, stopID is not used
    func getStop(stopId: Int, completion: @escaping (Result<StopExtended, Error>) -> Void) {
        guard let url = URL(string: Urls.stops) else {
            completion(.failure(ResponseError.wrongURLError))
            return
        }
        
        self.session.dataTask(with: url) { data, response, error in
            if error != nil {
                completion(.failure(ResponseError.wrongURLError))
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
