//: Primeiro Arquivo do Dia
// Swift 100 - Day 2 - 10/06

var calculo = 5 * 10
var conta = 2 + 2


switch (calculo < 10, conta == 5){
    
    case(true, true):
    print("Calculo é menor que 10. A conta dá 5")
    
    case(false, true):
    print("Calculo não é menor que 10. A conta dá 5")
    
    case(true, false):
    print("Calculo é menor que 10. A conta não dá 5")
    
    default:
    print("Calculo não é menor que 10. A conta não dá 5")
}


//:Quiz
// Faca uma tupla para representar uma capital do sudeste, que contenha nome
// e Populacao. Adicione as 4 capitais num vetor de tuplas

// Utilizando filter, mostre as com mais de 5 milhoes de habitantes
// Utilizando map, faca um vetor de Strings somente com o nome
// Utilizando reduce, some toda populacao das capitais do sudeste


typealias Capital = (nome: String, populacao: Int)

var capitais:[Capital] = []

["Sao Paulo","Minas Gerais","Rio de Janeiro","VE"].forEach{
    
    let novaCapital:Capital = ($0,0)
    capitais.append(novaCapital)
}

capitais[0].populacao = 5000000
capitais[1].populacao = 3000000
capitais[2].populacao = 6000000
capitais[3].populacao = 2000000

let capitaisFiltro = capitais.filter{ $0.populacao >= 5000000 }
print("Capitais Populacao > 5000000\(capitaisFiltro)")

let capitaisMapa = capitais.map{ $0.nome }
print("Capitais Nome: \(capitaisMapa)")

let capitaisReduce = capitais.reduce(0){ $0 + $1.populacao }
print("Numero Total: \(capitaisReduce)")