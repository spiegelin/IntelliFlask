//
//  HTTPRequest.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 12/03/23.
//

import SwiftUI

struct HTTPRequest: View {
    @State private var responseText = "Waiting for response..."
    
    var body: some View {
        VStack {
            // _timer -> timer
            let timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { timer in
                sendRequest()
            }
            let prefix = "T:"
            if let startIndex = responseText.range(of: prefix)?.upperBound,
               let endIndex = responseText[startIndex...].firstIndex(where: { !("0"..."9").contains($0) }) {
                let temp = String(responseText[startIndex..<endIndex])
                Text(temp + "°").padding()
            }
            
            
            /*
            Spacer()
            Text(responseText)
                .padding()
            
            Button(action: {
                sendRequest()
            }, label: {
                Text("Send Request")
                    .padding()
            })
             */
            
        }
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
                responseText = "Error: \(error.localizedDescription)"
                return
            }
            
            guard let data = data else {
                responseText = "Error: no data returned"
                return
            }
            
            //print("/////////----------")
            //print(String(data: data, encoding: .utf8) ?? "")
            //print("/////////----------")
            
            if let responseText = String(data: data, encoding: .utf8) {
                self.responseText = responseText
            } else {
                self.responseText = "Error: could not decode response data"
            }
        }.resume()
    }
}



struct _HTTPRequest: PreviewProvider {
    static var previews: some View {
        HTTPRequest()
    }
}

