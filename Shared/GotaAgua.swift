//
//  GotaAgua.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 11/03/23.
//

import SwiftUI

struct WaterDropView: View {
    var body: some View {
        ZStack {
            Image(systemName: "drop.fill")
                .resizable()
                .foregroundColor(Color.blue)
                .frame(width: 200, height: 280)
        }
    }
}

struct GotaAgua: View {
    var body: some View {
        WaterDropView()
            .padding()
    }
}

struct GotaAgua_Previews: PreviewProvider {
    static var previews: some View {
        GotaAgua()
    }
}

