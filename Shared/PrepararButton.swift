//
//  PrepararButton.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 09/03/23.
//

import Foundation
import SwiftUI

struct PrepararButton: View {
    var body: some View {
        Button("Preparar") {
            // Mandar cuántos leds se van a prender
            // L:4
            // Cuándo llegue al nivel de los 4 leds, recibiré información de que se llenó y se prenderá otra opción para llenar de otro producto
            
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
    }
}

struct PrepararButton_Previews: PreviewProvider {
    static var previews: some View {
        PrepararButton()
    }
}
