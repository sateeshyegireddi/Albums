//
//  APIClient.swift
//  Resplash
//
//  Created by Sateesh Yemireddi on 3/2/21.
//

import Foundation

struct APIClient {
    static func send<T: Codable>(_ urlRequest: APIRequest,
                                 completion: @escaping (_ result:  Result<T, NetworkError>) -> ()) {
        
        //Create request with given baseURL
        let request = urlRequest.request()
        
        //Create the Session Configuration with default/ephimeral type
        let configuration = URLSessionConfiguration.default
        
        //Set its time-out interval to certain seconds
        configuration.timeoutIntervalForRequest = 30
        
        //Create the session with created configuration
        let session = URLSession(configuration: configuration)
        
        //Create dataTask with the specific request
        let task = session.dataTask(with: request) { (data, _, error) in
            
            //Return if there is any error from server
            if let error = error {
                completion(Result.failure(NetworkError.genericError(error.localizedDescription)))
                return
            }
            
            //Return if there is no data received from server
            guard let data = data else {
                completion(Result.failure(NetworkError.noData))
                return
            }
            
            //Parse data and return associate model or JSON parse failure error.
            do {
                let model = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(model))
            } catch {
                completion(Result.failure(NetworkError.jsonParse))
            }
        }
        
        //Resume the task if its not started or suspended.
        task.resume()
    }
}
