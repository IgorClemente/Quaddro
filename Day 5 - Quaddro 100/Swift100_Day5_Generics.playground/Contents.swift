//:Generics

// Day 5 - Generics



// Imagine um funcao que inverte as pontas de um vetor de inteiros

func invertePontaInteiros(_ vetor:[Int]) -> [Int] {
    
    //Isolar os casos
    guard let ultimo = vetor.last,
          let primeiro = vetor.first else{
        return vetor
    }
    
    var novo = vetor
    novo[0] = ultimo
    novo[vetor.count-1] = primeiro
    return novo
}

invertePontaInteiros([1,5,4,7])

// Mas, e seu eu quiser inverter um vetor de Float? Ou 
// de Double? Precisaria repetir tudo? 👩‍✈️
// Pra isso utilizamos genérics

// O tipo é decidido em tempo de execucao

func inverterPontas<T>(_ vetor:[T]) -> [T] {

    guard let ultimo = vetor.last,
        let primeiro = vetor.first else{
            return vetor
    }
    var novo = vetor
    novo[0] = ultimo
    novo[vetor.count-1] = primeiro
    return novo
}

inverterPontas(["a","b","c"])

// Outras coisas, por exemplo

func igual<T>(_ a:T,_ b:T) -> Bool where T:Equatable {
     return a == b
}
igual(1, 5)



// Com generics podem adicionar estes comportamentos de tipos variáveis também em classes

class Maioral <T> where T:Comparable {

    var maiorAtual:T? = nil
    
    // init(primeiro:T) {                  //Se no INIT tiver o T - Na instancia não precisa conter o Diamond T
    //    maiorAtual = primeiro
    //}
    
    func considere(_ candidato:T) {
        if maiorAtual == nil {
            maiorAtual = candidato
        }else if let m = maiorAtual, candidato > m{
            maiorAtual = candidato
        }
    }
}


// Quando utilizamos essa classe, agora vai ser preciso passr no construtor o tipo envolvido

var umMaioral = Maioral<Int>()
    umMaioral.considere(2)
    umMaioral.considere(5)
    umMaioral.considere(1)
    umMaioral.maiorAtual

var outroMaioral = Maioral<String>()
    outroMaioral.considere("Igor")
    outroMaioral.considere("Outra String")
    outroMaioral.maiorAtual



// BLITZ
// Generics: Faca uma funcao genérica que embaralhe
// elementosde um vetor

// embaralha([1,2,3])
// embaralha(["a","b","c"])

//Para random:
// * import Darwin
// *  arc4random_uniform

import Darwin

func embaralha<T>(Osvalores de:[T]) -> [T] {
    
    var ultimoGerado:Int = 0
    var vetorEmbaralhado = de
    var retorno = Array<T>()
    
    for _ in vetorEmbaralhado {
        let numeroRand = arc4random_uniform(UInt32(vetorEmbaralhado.count))
        retorno.append(vetorEmbaralhado[Int(numeroRand)])
        vetorEmbaralhado.remove(at: Int(numeroRand))
    }
    return retorno
}

embaralha(Osvalores: [1,2,3,4,5])
embaralha(Osvalores: [])
embaralha(Osvalores: ["a","b","c","d"])


//Outra Solucao:

