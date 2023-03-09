//
//  FavoritosUI.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 09/03/23.
//
import SwiftUI


struct FavoritosUI: View {
    // Cuando este en true, solo se mostraran los favoritos
    @State private var showFavoritesOnly = true
    
    var filtered: [Bebida] {
            bebidas.filter { bebida in
                (!showFavoritesOnly || bebida.isFavorite)
            }
    }
    
    var body: some View {
        NavigationView {
            List(filtered) { bebida in
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
            .navigationTitle("Favoritos")
        }
    }
}

struct FavoritosUI_Previews: PreviewProvider {
    static var previews: some View {
            FavoritosUI()
        }
    }
