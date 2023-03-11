//
//  PrepararButton.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 09/03/23.
//

import Foundation
import SwiftUI
import UIKit

struct PrepararButton: View {
    var bebida: Bebida
    @State private var showNextView = false
    
    var body: some View {
        Button(action: {
                self.showNextView = true
            }, label: {
                Text("Preparar")
                    .foregroundColor(.white)
                    .frame(width: 100, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            .sheet(isPresented: $showNextView, content: {
                PreparandoUI(bebida: bebida)
            })
    }
}


struct PrepararButton_Previews: PreviewProvider {
    static var previews: some View {
        PrepararButton(bebida: bebidas[0])
    }
}
