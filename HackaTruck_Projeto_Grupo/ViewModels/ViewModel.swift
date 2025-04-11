//
//  ViewModel.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 04/04/25.
//

import Foundation

class ViewModel: ObservableObject{
    @Published var plantas: [Planta] = []
    @Published var sensores: [Sensor] = []
    
    func fetchPlantas() {
        guard let url = URL(string: "http://192.168.128.82:1880/plantGET") else {
            return //se a url não estiver disponível
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _ , error in
            guard let data = data, error == nil else{
                return //retornar nulo caso ocorra um erro ou não contém alguma data
            }
            
            //tentar decodificar para a struct em model
            do {
                let parsed =  try JSONDecoder().decode([Planta].self, from: data)
                
                DispatchQueue.main.async {
                    //alimentar o struct com os dados, objeto por objeto
                    self?.plantas = parsed
                }
            } catch{
                //caso a decodificação falhe
                print(error)
            }
        }
        //inicia a task para buscar os dados
        task.resume()
    }
    
    func fetchSensores() {
        guard let url = URL(string: "http://192.168.128.82:1880/sensorGET") else {
            return //se a url não estiver disponível
        }
        
        let task = URLSession.shared.dataTask(with: url){
            [weak self] data, _ , error in
            guard let data = data, error == nil else{
                return //retornar nulo caso ocorra um erro ou não contém alguma data
            }
            
            //tentar decodificar para a struct em model
            do {
                let parsed =  try JSONDecoder().decode([Sensor].self, from: data)
                
                DispatchQueue.main.async {
                    //alimentar o struct com os dados, objeto por objeto
                    self?.sensores = parsed
                }
            } catch{
                //caso a decodificação falhe
                print(error)
            }
        }
        //inicia a task para buscar os dados
        task.resume()
    }
    
    func plantasOrdenadas() -> [Planta] {
        return plantas.sorted { (planta1, planta2) -> Bool in
            // Lidar com valores nil
            switch (planta1.nomePopular, planta2.nomePopular) {
            case let (nome1?, nome2?): // Caso ambos sejam não nulos
                return nome1 <= nome2
            case (nil, _): // Caso o primeiro seja nil
                return false
            case (_, nil): // Caso o segundo seja nil
                return true
            }
        }
    }
}
