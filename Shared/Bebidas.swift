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
    var ingredientes: [String]
    var fotos_ingredientes: [String]
    
    var nombreImagen: String
    var imagen: Image {
        Image(nombreImagen)
    }
        
    var imagen_ingredientes: Image {
            Image(fotos_ingredientes[0])
    }
}

var bebidas = [
    Bebida(nombre: "La Confiable Cuba", desc: "Algo, siu, nssnc", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: true, ingredientes: ["Ron", "Agua Mineral", "Refresco de Cola"], fotos_ingredientes: ["Bacardí", "Topo Chico", "Coca Cola"], nombreImagen: "Cuba"),
    Bebida(nombre: "Paloma", desc: "Palomilla si señor", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: false, ingredientes: ["Tequila", "Agua Mineral", "Refresco de Toronja"], fotos_ingredientes: ["Maestro Dobel", "Topo Chico", "Squirt"], nombreImagen: "Paloma"),
    Bebida(nombre: "Perla Negra", desc: "Negrilla algo ultra bien", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: false, ingredientes: ["Jäger", "Red Bull"], fotos_ingredientes: ["Jäger", "Red Bull"], nombreImagen: "Perla"),
    Bebida(nombre: "Corona Sunrise", desc: "Una pa la playish", instrucciones: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", isFavorite: false, ingredientes: ["Jaraba de Granadina", "Jugo de Naranja", "Cerveza Corona"], fotos_ingredientes: ["Granadina", "Jugo", "Corona"], nombreImagen: "CoronaSun")
]
