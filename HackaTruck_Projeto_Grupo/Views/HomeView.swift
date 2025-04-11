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
    
    @State private var isSheetPresented = false
    
    let items = Array(1...5)
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM   HH:mm"
        return formatter
    }
    @State var sensor2: Sensor = Sensor(
               id: 0,
               grupoId: 0,
               nome: "placeholder",
               umidadeMin: 20,
               umidadeMax: 80,
               leituras: [42, 77, 25, 90, 3, 59, 64, 33, 14, 88,
                          45, 17, 66, 92, 11, 38, 70, 5, 96, 29,
                          54, 81, 23, 49, 37, 67, 8, 91, 2, 60,
                          34, 85, 13, 99, 41, 26, 74, 18, 7, 62,
                          93, 36, 6, 55, 20, 80, 1, 73, 10, 68],
               datas: [1711929600000,1711929600000,1712016000000,1712102400000,1712102400000,1712188800000,1712275200000,1712361600000,1712361600000,1712448000000,
                       1712534400000,1712620800000,1712707200000,1712793600000,1712880000000,1712966400000,1712966400000,1713052800000,1713139200000,1713225600000,
                       1713312000000,1713312000000,1713398400000,1713484800000,1713571200000,1713657600000,1713657600000,1713744000000,1713830400000,1713916800000,
                       1714003200000,1714089600000,1714176000000,1714262400000,1714348800000,1714348800000,1714435200000,1714521600000,1714608000000,1714694400000,
                       1714780800000,1714867200000,1714953600000,1715040000000,1715126400000,1715212800000,1715299200000,1715385600000,1715385600000,1715472000000]
           )
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

                                        Text("Última leitura:   " + dateFormatter.string(from: data))
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
                                .onTapGesture {
                                    isSheetPresented = true
                                    sensor2 = sensor
                                }
                                .sheet(isPresented: $isSheetPresented) {
                                    SensorView(sensor: $sensor2)
                                }
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
