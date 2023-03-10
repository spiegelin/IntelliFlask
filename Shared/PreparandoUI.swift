//
//  PreparandoUI.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 10/03/23.
//

import SwiftUI

struct PreparandoUI: View {
    var body: some View {
        VStack {
            Text("Preparando...")
            ProgressView(value: 0.3)
        }
    }
}


struct PreparandoUI_Previews: PreviewProvider {
    static var previews: some View {
        PreparandoUI()
    }
}
