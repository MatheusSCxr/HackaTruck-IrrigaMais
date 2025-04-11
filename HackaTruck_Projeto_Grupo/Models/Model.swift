//
//  Model.swift
//  HackaTruck_Projeto_Grupo
//
//  Created by Turma02-24 on 04/04/25.
//

import Foundation

struct Planta: Identifiable, Codable {
    var id: Int
    var nomePopular: String?
    var nomeCientifico: String?
    var imagemURL: String?
    var descricao: String?
    var nivelCuidado: String?
    var umidadeIdealMin: Int?
    var umidadeIdealMax: Int?
    var frequenciaRega: String?
    var ambienteIdeal: String?
    var luminosidade: String?
    var tamanho: String?
    var temperaturaIdealMin: Int?
    var temperaturaIdealMax: Int?
    var dicas: [String]?
    var toxicaParaPets: Bool?
}

struct Sensor: Identifiable, Codable {
    var id: Int
    var grupoId: Int
    var nome: String
    var umidadeMin: Int
    var umidadeMax: Int
    var leituras: [Int]
    var datas: [Int64]
}
