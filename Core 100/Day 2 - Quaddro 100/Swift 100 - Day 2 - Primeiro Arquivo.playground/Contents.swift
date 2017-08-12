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



/*
 
 :Quiz
 
 Faca uma tupla para representar uma capital do sudeste, que contenha nome
 e Populacao. Adicione as 4 capitais num vetor de tuplas
 
 Utilizando filter, mostre as com mais de 5 milhoes de habitantes
 Utilizando map, faca um vetor de Strings somente com o nome
 Utilizando reduce, some toda populacao das capitais do sudeste
*/

typealias Capital = (nome: String, populacao: Int)
var sudeste = Array<Capital>()

["Sao Paulo","Minas Gerais","Rio de Janeiro","VE"].forEach{
    
    let novaCapital:Capital = ($0,0)
    sudeste.append(novaCapital)
}

var nordeste:[Capital] = []

["Bahia","Sergipe","Alagoas","Ceara","Maranhao","Paraiba","Pernambuco","Piaui","Rio Grande do Norte"].forEach{

    let novaCapital:Capital = ($0,0)
    nordeste.append(novaCapital)
}

sudeste[0].populacao = 5000000
sudeste[1].populacao = 3000000
sudeste[2].populacao = 6000000
sudeste[3].populacao = 2000000

nordeste[0].populacao = 6000000
nordeste[1].populacao = 7000000
nordeste[2].populacao = 4000000
nordeste[3].populacao = 3000000
nordeste[4].populacao = 3000000
nordeste[5].populacao = 2000000
nordeste[6].populacao = 8000000
nordeste[7].populacao = 1000000
nordeste[8].populacao = 1000000


/*
 
 Aplicando Filtro, Mapa e Reduce  Regiao-Sudeste
 
*/

let sudesteFiltro = sudeste.filter{
    $0.populacao >= 5000000
}
print("Capitais Populacao > 5000000: \(sudesteFiltro)")

let sudesteMapa = sudeste.map{
    $0.nome
}
print("Capitais Nome: \(sudesteMapa)")

//reduce(0) - Valor Inicial
let sudesteReduce = sudeste.reduce(0){
    $0 + $1.populacao
}
print("Numero Total: \(sudesteReduce)")


/* 
 
 Aplicando Filtro, Mapa e Reduces Regiao-Nordeste 
 
*/

let nordesteFiltro = nordeste.filter{
    $0.populacao >= 6000000
}
print("Filtro Nordeste: \(nordesteFiltro)")

let nordesteMapa = nordeste.map{
    $0.nome
}
print("Mapa Nordeste: \(nordesteMapa)")

let  nordesteReduce = nordeste.reduce(0){
    $0 + $1.populacao
}
print("Reduce Nordeste: \(nordesteReduce)")


/*

 - Regioes do Brasil
 - Dicionarios
 
*/


var brasil:[String:[Capital]] = [:]
    brasil["Nordeste"] = nordeste
    brasil["Sudeste"] = sudeste

print("Brasil: \(brasil)")
print("Sudeste: \(sudeste)")
print("Nordeste: \(nordeste)")

brasil["Sudeste"]



