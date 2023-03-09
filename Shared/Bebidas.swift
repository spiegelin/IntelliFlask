//
//  ListaBebidas.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 08/03/23.
//

import Foundation
import SwiftUI

struct Bebida: Identifiable {
    var id = UUID()
    var nombre: String
    var desc: String
    var instrucciones: String
    var isFavorite: Bool
    
    var nombreImagen: String
    var imagen: Image {
        Image(nombreImagen)
    }
}

var bebidas = [
    Bebida(nombre: "La Confiable Cuba", desc: "Algo, siu, nssnc", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: true, nombreImagen: "Cuba"),
    Bebida(nombre: "Paloma", desc: "Palomilla si señor", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: false, nombreImagen: "Paloma"),
    Bebida(nombre: "Perla Negra", desc: "Negrilla algo ultra bien", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: false, nombreImagen: "Perla"),
    Bebida(nombre: "Corona Sunrise", desc: "Una pa la playish", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: false, nombreImagen: "CoronaSun")
]
