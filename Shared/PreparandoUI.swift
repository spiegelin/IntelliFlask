//
//  PreparandoUI.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 10/03/23.
//

import SwiftUI

struct PreparandoUI: View {
    // Cambiar el progreso a que sea el que tiene del vaso
    var progress = 0.3
    var bebida: Bebida
    
    var body: some View {
        VStack {
            Text("No se la piense, el alcohol es del alma...").padding()
            ProgressView(value: progress)
            Spacer()
            ImagenIngredientes(image: bebida.imagen_ingredientes)
                .offset(y: -40)
                .padding(.bottom, -130)
            
            Spacer()
            
        }
        .padding(.top)
    }
}


struct PreparandoUI_Previews: PreviewProvider {
    static var previews: some View {
        PreparandoUI(bebida: bebidas[0])
    }
}
