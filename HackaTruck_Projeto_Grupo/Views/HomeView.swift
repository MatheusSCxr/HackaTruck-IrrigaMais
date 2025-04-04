//
//  HomeView.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 03/04/25.
//

import SwiftUI

struct HomeView: View {
    let columns = [
        GridItem(.flexible())
    ]
    
    let items = Array(1...5)
    
    var body: some View {
        ZStack(){
            Color.verdeIrriga
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                LazyVGrid(columns: columns) {
                    Section(){
                        ForEach(items, id: \.self) { item in
                            VStack {
                                Spacer()
                                Image(systemName:"leaf.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 200,height: 120)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.verdeIrriga)
                                    .cornerRadius(10)
                                Text("Planta")
                                    .font(.title3.bold())
                                    .padding(-10)
                            }
                            
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                        }
                    } header: {
                        Text("Minhas Plantas")
                            .font(.largeTitle.bold())
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 30)
                    }
                }
                .padding(.top)
            }
            .background(Color.white)
            .padding(.vertical)
        }
    }
}

#Preview {
    HomeView()
}
