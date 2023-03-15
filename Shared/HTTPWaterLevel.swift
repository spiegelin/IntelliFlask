//
//  HTTPWaterLevel.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 15/03/23.
//

import SwiftUI

struct HTTPWaterLevel: View {
    @State private var responseText = "Waiting for response..."
    
    var body: some View {
        VStack {
            // Repetir el request cada 1 segundo
            let timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
                sendRequest()
            }
            
            // Parsear el texto html del request
            let prefix = "L:"
            if let startIndex = responseText.range(of: prefix)?.upperBound,
               let endIndex = responseText[startIndex...].firstIndex(where: { !("0"..."9").contains($0) }) {
                let temp = String(responseText[startIndex..<endIndex])
                
                
                // UI para mostrar la barra
                let progress: Double = Double(temp)!
                Text("\(Int(progress * 100))%")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding(.bottom, 10)
                    
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(width: UIScreen.main.bounds.width / 2, height: 20)
                        .cornerRadius(20)
                    
                    Rectangle()
                        .foregroundColor(.blue)
                        .frame(width: CGFloat(progress) * UIScreen.main.bounds.width / 2, height: 20)
                        .cornerRadius(20)
                }
                     
            }
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
            
            if let responseText = String(data: data, encoding: .utf8) {
                self.responseText = responseText
            } else {
                self.responseText = "Error: could not decode response data"
            }
        }.resume()
        
    }
}



struct _HTTPWaterLevel: PreviewProvider {
    static var previews: some View {
        HTTPWaterLevel()
    }
}

