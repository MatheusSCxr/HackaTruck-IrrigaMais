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
    
    @StateObject var viewModel = ViewModel()
    
    let items = Array(1...5)
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy HH:mm" // Formato dia, mês, ano, hora e minuto
        return formatter
    }
    
    var body: some View {
        
        ZStack(){
            Color.verdeIrriga
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            ScrollView{
                LazyVGrid(columns: columns) {
                    Section(){
                        ForEach(viewModel.sensores) {sensor in
                            // Calculando a cor de fundo com base na umidade
                            let umidadeAtual = sensor.leituras.last ?? 0
                            let umidadeMin = sensor.umidadeMin
                            let umidadeMax = sensor.umidadeMax
                            
                            //calcular a cor de fundo com base na umidade
                            let bgColor: Color = {
                                if umidadeAtual < umidadeMin{
                                    return .red
                                } 
                                else if umidadeAtual > umidadeMax{
                                    return .azulIrriga
                                }
                                else if abs(umidadeAtual - umidadeMin) <= 8 || abs(umidadeAtual - umidadeMax) <= 8 {
                                    return .yellow
                                } else {
                                    return .green
                                }
                            }()
                                VStack {
                                    Text(sensor.nome)
                                        .bold()
                                    
                                    if let firstData = sensor.datas.first {
                                        
                                        let epochTime = TimeInterval(firstData) / 1000
                                        let data = Date(timeIntervalSince1970: epochTime)

                                        Text("ultima leitura: " + dateFormatter.string(from: data))
                                            .font(.caption)
                                            .bold()
                                    } else {
                                        //caso sensor.datas esteja vazio
                                        Text("Data indisponível")
                                            .bold()
                                    }
                                    
                                    Text("\(umidadeAtual)" + "%")
                                    if (bgColor == .red){
                                        Image(systemName: "drop")
                                    }
                                    else if (bgColor == .yellow && umidadeAtual < umidadeMin){
                                        Image(systemName: "drop.halffull")
                                    }
                                    else{
                                        Image(systemName: "drop.fill")
                                    }
                                }
                                .frame(width: 250, height: 100)
                                .background(bgColor)
                                .cornerRadius(10)
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
        .onAppear(){
            viewModel.fetchSensores()
        }
    }
}

#Preview {
    HomeView()
}
