//
//  Inicio.swift
//  IntelliFlask
//
//  Created by Diego Espejo on 09/03/23.
//

import SwiftUI

struct Inicio: View {
    var body: some View {
        ZStack {
            GotaAgua()
            
            Text("IntelliFlask")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                .multilineTextAlignment(.center)
                .offset(y: -270)
            
            HTTPRequest()
            //TemperatureView()
                .fontWeight(.heavy)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
                .padding([.top, .leading])
                .font(.system(size: 70))
                .offset(y: 10)
            
            //FillView().offset(y:250)
            HTTPWaterLevel().offset(y:250)
        }
        
    }
}

struct Inicio_Previews: PreviewProvider {
    static var previews: some View {
        Inicio()
    }
}
