//
//  PlantView.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 03/04/25.
//

import SwiftUI

struct PlantaView: View {
    @State var planta: Planta = Planta(
            id: 0,
            nomePopular: "Espada-de-São-Jorge",
            nomeCientifico: "Sansevieria trifasciata",
            imagemURL: "https://terramagna.com.br/wp-content/uploads/2022/09/Planta-jovem-luz-solar.jpg",
            descricao: "Planta resistente e fácil de cuidar, ideal para iniciantes.",
            nivelCuidado: "Facil",
            umidadeIdealMin: 30,
            umidadeIdealMax: 50,
            frequenciaRega: "1 vez por semana",
            ambienteIdeal: "Interior",
            luminosidade: "Luz Indireta",
            tamanho: "Média",
            temperaturaIdealMin: 15,
            temperaturaIdealMax: 30,
            dicas: ["Evite encharcar o solo"],
            toxicaParaPets: true
        )
    
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
                        .font(.title.bold())
                    Text(planta.nomeCientifico ?? "<no_name>")
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
                        Text("Temperatura mínima: ")
                        Text("\(planta.temperaturaIdealMin ?? -1)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text("Temperatura máxima: ")
                        Text("\(planta.temperaturaIdealMax ?? -1)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    
                    HStack(){
                        Text("Umidade mínima: ")
                        Text("\(planta.umidadeIdealMin ?? -1)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        Spacer()
                        Text("Umidade máxima: ")
                        Text("\(planta.umidadeIdealMax ?? -1)")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 20)
                    
                    HStack(){
                        Text("Frequência recomendada de rega")
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
                            .font(.title3.bold())
                        Text(planta.dicas?.joined(separator: ", ") ?? "<no_dicas>")
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

#Preview {
    PlantaView()
}

