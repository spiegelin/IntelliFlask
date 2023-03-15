//
//  TemperatureView.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 15/03/23.
//

import SwiftUI

struct TemperatureView: View {
    var esp32 = ESP32()
    @State private var responseText = "--"
    
    var body: some View {
        VStack {
            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                esp32.sendRequest()
            }
            let prefix = "T:"
            if let startIndex = esp32.getResponse().range(of: prefix)?.upperBound,
               let endIndex = esp32.getResponse()[startIndex...].firstIndex(where: { !("0"..."9").contains($0) }) {
                let temp = String(esp32.getResponse()[startIndex..<endIndex])
                Text(temp).padding()
            }
        }
    }
}



struct _TemperatureView: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}


