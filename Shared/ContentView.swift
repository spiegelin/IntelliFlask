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
        case favoritos
        case bluetooth
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
                    Label("Bebidas", systemImage: "wand.and.stars")
                }
                .tag(Tab.lista)
            
            FavoritosUI()
                .tabItem {
                    Label("Favoritos", systemImage: "heart")
                }
                .tag(Tab.favoritos)
            
            /*
            HTTPRequest()
                .tabItem {
                    Label("Connect", systemImage: "bolt.horizontal.circle.fill")
                }
                .tag(Tab.bluetooth)
            */
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
