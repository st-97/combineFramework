//
//  NetworkService.swift
//  CombineFramework
//
//  Created by Mac on 21/08/2023.
//

import Foundation
import Combine

class NetworkService {
    func login(username: String, password: String) -> AnyPublisher<Bool, Error> {
         let url = URL(string: "https://dummyjson.com/auth/login")!
         var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let requestBody = ["username": "kminchelle", "password": "0lelplR"]
            let jsonData = try? JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
         return URLSession.shared.dataTaskPublisher(for: request)
             .tryMap { data, response in
                  guard let httpResponse = response as? HTTPURLResponse,
                       httpResponse.statusCode == 200 else {
                     throw NSError(domain: "NetworkService", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to login"])
                 }
                 print(httpResponse)

                 // Simulate parsing response
                 return true
             }
             .receive(on: DispatchQueue.main)
             .eraseToAnyPublisher()
    }
}
