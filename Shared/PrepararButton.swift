//
//  PrepararButton.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 09/03/23.
//

import Foundation
import SwiftUI

struct PrepararButton: View {
    var body: some View {
        Button("Preparar") {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/ /*@END_MENU_TOKEN@*/
        }
        .foregroundColor(.white)
        .padding()
        .background(Color.blue)
        .cornerRadius(10)
        }
}

struct PrepararButton_Previews: PreviewProvider {
    static var previews: some View {
        PrepararButton()
    }
}
