//
//  ContentView.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 03/04/25.
//

import SwiftUI

struct ContentView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.verdeIrriga
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        }
    var body: some View {
        ZStack(){
            VStack{
                TabView{
                    HomeView()
                        .tabItem {
                            Label("Inicio", systemImage: "house.fill")
                        }
                        .fontWeight(.bold)
                    GruposView()
                        .tabItem {
                            Label("Grupos", systemImage: "tray.full.fill")
                        }
                        .fontWeight(.bold)
                    CatalogoView()
                        .tabItem {
                            Label("Catálogo", systemImage: "list.bullet")
                        }
                    AlertasView()
                        .tabItem {
                            Label("Alertas", systemImage: "drop.fill")
                        }
                        .fontWeight(.bold)
                }
                .font(.title.bold())
                .accentColor(.azulIrriga)
            }
        }
    }
}

#Preview {
    ContentView()
}
