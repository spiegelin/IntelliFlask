//
//  ContentView.swift
//  Shared
//
//  Created by Diego Espejo on 08/03/23.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .inicio
    
    enum Tab {
        case inicio
        case lista
    }
    
    var body: some View {
        TabView (selection: $selection){
            Inicio()
                .tabItem {
                    Label("Inicio", systemImage: "house")
                }
                .tag(Tab.inicio)
            
            BebidasUI()
                .tabItem {
                    Label("Bebidas", systemImage: "moon.fill")
                }
                .tag(Tab.lista)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
