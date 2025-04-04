//
//  GruposView.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 03/04/25.
//

import SwiftUI

struct GruposView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    let items = Array(1...5)
    
    var body: some View {
        ZStack(){
            Color.verdeIrriga
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                LazyVGrid(columns: columns, spacing: 20) {
                    Section(){
                        ForEach(items, id: \.self) { item in
                            VStack {
                                Spacer()
                                Image(systemName:"archivebox.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 130,height: 130)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color.verdeIrriga)
                                    .scaledToFit()
                                    .cornerRadius(10)

                                Text("Grupo")
                                    .font(.title3.bold())
                                    .padding(-5)
                            }
                            
                            .padding(.horizontal)
                        }
                    } header: {
                        Text("Meus Grupos")
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
    GruposView()
}
