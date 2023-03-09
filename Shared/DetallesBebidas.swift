//
//  DetallesBebidas.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 08/03/23.
//

import SwiftUI

struct DetallesBebidas: View {
    var bebida: Bebida
    
    var body: some View {
        ScrollView {
            ImagenBebidaPrincipal(image: bebida.imagen)
                .offset(y: -40)
                .padding(.bottom, -130)

            VStack(alignment: .center) {
                Text(bebida.nombre)
                    .font(.title)
                    .offset(y: 20)
                
                HStack {
                    VStack {
                        Image(systemName: "square.and.arrow.down")
                            .foregroundColor(.yellow)
                        Spacer()
                        Text("Guardar")
                    }
                    
                    // Espacio Vacío
                    Text("                 ")
                    
                    VStack {
                        Image(systemName: "star")
                            .foregroundColor(.yellow)
                        Spacer()
                        Text("Favoritos")
                    }
                    
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                .offset(y: 70)

                Divider()
                Text(bebida.instrucciones).offset(y:70)
            }
            .padding()

            Spacer()
            
            Button("Preparar") {
                /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
            }
            .offset(y: 100)
                
        }
        .navigationTitle(bebida.nombre)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetallesBebidas_Previews: PreviewProvider {
    static var previews: some View {
        DetallesBebidas(bebida: bebidas[0])
    }
}
