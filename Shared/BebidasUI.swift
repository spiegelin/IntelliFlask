//
//  BebidasUI.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 08/03/23.
//

import SwiftUI

struct BebidasUI: View {
    var body: some View {
        NavigationView {
            List(bebidas) { bebida in
                NavigationLink {
                    DetallesBebidas(bebida: bebida)
                } label: {
                    HStack(spacing: 20) {
                        Image(bebida.nombreImagen)
                            .resizable()
                            .clipShape(Circle())
                            .frame(width: 50, height: 50)
                        VStack(alignment: .leading, spacing: 5) {
                            Text(bebida.nombre)
                                .font(.headline)
                            Text(bebida.desc)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        if bebida.isFavorite {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                        }
                    }
                    
                }
            }
            .navigationTitle("Bebidas")
        }
    }
}

struct BebidasUI_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone 13 Pro", "iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            BebidasUI()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}
