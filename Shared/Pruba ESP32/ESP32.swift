//
//  ESP32.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 15/03/23.
//

import Foundation
    
class ESP32 {
    var responseText: String
    
    init(responseText: String = "Waiting for response...") {
        self.responseText = responseText
    }
    
    func sendRequest() {
        
        guard let url = URL(string: "http://192.168.4.1") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "Hi".data(using: .utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                self.responseText = "Error: \(error.localizedDescription)"
                return
            }
            
            guard let data = data else {
                self.responseText = "Error: no data returned"
                return
            }
            
            if let _responseText = String(data: data, encoding: .utf8) {
                self.responseText = _responseText
            } else {
                self.responseText = "Error: could not decode response data"
            }

        }.resume()
    }
    
    func getResponse() -> String {
        return self.responseText
    }
    
}

