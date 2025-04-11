import SwiftUI
import Charts

struct SensorView: View {
    @Binding var sensor: Sensor
    
    func getMediastUltimos30Dias() -> [LeituraPorDia] {
        var mediasDiarias = [LeituraPorDia]()
        var somaLeituras = 0
        var contadorLeituras = 0
        var dataInicioDia = sensor.datas[0]
        
        for i in 0..<sensor.leituras.count {
            let leitura = sensor.leituras[i]
            let data = sensor.datas[i]
            
            // Verifica se a data é do mesmo dia
            if data - dataInicioDia < 86400000 { // 86400000 ms = 1 dia
                somaLeituras += leitura
                contadorLeituras += 1
            } else {
                // Calcula a média do dia anterior
                let mediaDiaAnterior = Double(somaLeituras) / Double(contadorLeituras)
                let diaAnterior = Date(timeIntervalSince1970: TimeInterval(dataInicioDia / 1000))
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let diaFormatado = formatter.string(from: diaAnterior)
                
                mediasDiarias.append(LeituraPorDia(id: UUID(), dia: diaFormatado, media: mediaDiaAnterior))
                
                // Reseta para o próximo dia
                somaLeituras = leitura
                contadorLeituras = 1
                dataInicioDia = data
            }
        }
        
        print(somaLeituras)
        // Adiciona a última média
        if contadorLeituras > 0 {
            let mediaDiaFinal = Double(somaLeituras) / Double(contadorLeituras)
            let diaFinal = Date(timeIntervalSince1970: TimeInterval(dataInicioDia / 1000))
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let diaFormatado = formatter.string(from: diaFinal)
            
            mediasDiarias.append(LeituraPorDia(id: UUID(), dia: diaFormatado, media: mediaDiaFinal))
            
        }

        return mediasDiarias
    }
    
    func ObterUltimos30Dias() -> [LeituraPorDia] {
        let leituras = getMediastUltimos30Dias()
        let total = leituras.count
        
        // Verifica se o array tem menos de 50 elementos, caso tenha, retorna o array inteiro
        if total < 30 {
            return Array(leituras.suffix(30))
            //Array(leituras.suffix(countToFetch))
        } else {
           return Array(leituras.suffix(30))
        }
    }

    
    var body: some View {
        ZStack(){
            Color.verdeEscuruIrriga
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            VStack(){
                    Text(sensor.nome)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/.bold())
                        .padding(.bottom, 30)
                        .foregroundStyle(Color.white)
                    Text("Umidade atual: " + "\(sensor.leituras.last ?? -1)%")
                        .font(.title2)
                        .bold()
                        .padding(.bottom, 10)
                        .foregroundStyle(Color.white)
                    HStack(){
                        Text("Mínima: " + "\(sensor.umidadeMin ?? -1)%")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                        Text("Máxima: " + "\(sensor.umidadeMax ?? -1)%")
                            .font(.title3)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.bottom, 10)
                    Text("Média da umidade nos Últimos 30 dias")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(Color.white)
                    Chart(ObterUltimos30Dias()) { dataPoint in
                        LineMark(
                            x: .value("Dia", dataPoint.dia),
                            y: .value("Média", dataPoint.media)
                        )
                        
                        RuleMark(y: .value("Umidade minima", sensor.umidadeMin))
                            .annotation(alignment: .leading) {
                                Text("\(sensor.umidadeMin)%")
                                    .foregroundStyle(.red)
                            }
                            .foregroundStyle(Color.red)
                        RuleMark(y: .value("Umidade máxima", sensor.umidadeMax))
                            .annotation(alignment: .leading) {
                                Text("\(sensor.umidadeMax)%")
                                    .foregroundStyle(.black)
                            }
                            .foregroundStyle(Color.black)
                    }
                    .frame(height: 300)
                    .chartXAxis(.hidden)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
            }.onAppear(){
                
                print(sensor.umidadeMax)
                print(sensor.umidadeMin)
            }
        }
    }
}

//struct usada para obter a media diaria das leituras
struct LeituraPorDia: Identifiable {
    var id: UUID
    var dia: String
    var media: Double
}

//#Preview {
//    SensorView()
//}
