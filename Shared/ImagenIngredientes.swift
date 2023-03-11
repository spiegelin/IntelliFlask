//
//  ImagenIngredientes.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 10/03/23.
//

import SwiftUI

struct ImagenIngredientes: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Rectangle())
            .overlay {
                Rectangle().stroke(.white, lineWidth: 4)
            }
    }
}

struct ImagenIngredientes_Previews: PreviewProvider {
    static var previews: some View {
        ImagenIngredientes(image: Image("Bacardí"))
    }
}
