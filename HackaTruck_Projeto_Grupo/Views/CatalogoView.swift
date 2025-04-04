//
//  CatalogoView.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 03/04/25.
//

import SwiftUI

struct CatalogoView: View {
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        ZStack(){
            Color.verdeIrriga
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                LazyVGrid(columns: columns) {
                    Section(){
                        ForEach(viewModel.plantasOrdenadas()) { planta in
                            VStack {
                                Spacer()
                                AsyncImage(url: URL(string: planta.imagemURL ?? "<no_image")){ image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                        .padding(.leading, 20)
                                }placeholder: {
                                    Color.gray
                                        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                                        .frame(width: 100,height: 100)
                                        .padding(.leading, 20)
                                }
                                Text(planta.nomePopular ?? "<no_name>")
                                    .padding(-10)
                                    .fontWeight(.bold)
                            }
                            .frame(width: 100, height: 100)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 30)
                        }
                    } header: {
                        Text("Catálogo de Plantas")
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
        .onAppear(){
            viewModel.fetch()
        }
    }
}

#Preview {
    CatalogoView()
}
