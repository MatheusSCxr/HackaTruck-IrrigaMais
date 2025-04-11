//
//  PlantView.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 03/04/25.
//

import SwiftUI

struct PlantaView: View {
    @Binding var planta: Planta
    
    var body: some View {
        ZStack(){
            Color.verdeEscuruIrriga
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView(){
                VStack(){
                    AsyncImage(url: URL(string: planta.imagemURL ?? "<no_image")){ image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .frame(width: 200, height: 200)
                            .padding(.leading, 20)
                    }placeholder: {
                        Color.gray
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .frame(width: 100,height: 100)
                            .padding(.leading, 20)
                    }
                    Text(planta.nomePopular ?? "<no_name>")
                        .font(.largeTitle.bold())
                    Text("( " + (planta.nomeCientifico ?? "<no_name>") + " )")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    Text(planta.descricao ?? "<no_description>")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 40)
                        .padding(.vertical, 30)
                    
                    HStack(){
                        Text("Nível de Cuidado: ")
                            .font(.title3)
                        Text(planta.nivelCuidado ?? "<no_level>")
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    
                    HStack(){
                        Text("Tóxica para pets: ")
                            .font(.title3)
                        Text("\(planta.toxicaParaPets != nil ? (planta.toxicaParaPets! ? "Sim" : "Não") : "Desconhecido")")
                            .font(.title3)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    
                    HStack(){
                        Text("Temp. mínima: ")
                        Text("\(planta.temperaturaIdealMin ?? -1)")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text("Temp. máxima: ")
                        Text("\(planta.temperaturaIdealMax ?? -1)")
                            .font(.title2)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    
                    Text("Faixa de umidade ideal:  ")
                        .font(.title3)
                        .padding(.vertical, 5)
                        .padding(.horizontal, 20)
                    Text("\(planta.umidadeIdealMin ?? -1)% - " + "\(planta.umidadeIdealMax ?? -1)%")
                        .font(.title3)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        
                    HStack(){
                        Text("Frequência de rega (dias): ")
                            .font(.title3)
                        Text("\(planta.umidadeIdealMin ?? -1)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                    HStack(){
                        Text("Ambiente: ")
                            .font(.title3)
                        Text("\(planta.ambienteIdeal ?? "<no_ambiente>"),  \(planta.luminosidade ?? "<no_ambiente>")")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                    HStack(){
                        Text("Dicas: ")
                            .font(.title3)
                        Text(planta.dicas?.joined(separator: ", ") ?? "<no_dicas>")
                            .font(.title3.bold())
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .padding(.vertical)
        }
    }
}

