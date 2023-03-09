//
//  ImagenBebidaPrincipal.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 08/03/23.
//

import SwiftUI

struct ImagenBebidaPrincipal: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay {
                Circle().stroke(.white, lineWidth: 4)
            }
            .shadow(radius: 7)
    }
}

struct ImagenBebidaPrincipal_Previews: PreviewProvider {
    static var previews: some View {
        ImagenBebidaPrincipal(image: Image("Cuba"))
    }
}
