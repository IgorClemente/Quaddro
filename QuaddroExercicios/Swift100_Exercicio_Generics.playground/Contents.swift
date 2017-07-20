/*
 
 - Autor: Igor Clemente
 - Data: 17/07/2017
 - Exercicio Generics
 
 */


// - Generics -
// Faça uma função que embaralhe os elementos
// de um vetor de elementos genéricos


import Darwin

func embaralhar<T>(_ vetor:[T]) -> [T] {

    var vetorDeRetorno = Array<T>()
    var vetorEmbaralhar = vetor
    for _ in vetorEmbaralhar {
        
        let indiceAleatorio = arc4random_uniform(UInt32(vetorEmbaralhar.count))
        vetorDeRetorno.append(vetorEmbaralhar[Int(indiceAleatorio)])
        vetorEmbaralhar.remove(at: Int(indiceAleatorio))
    }
    return vetorDeRetorno
}

embaralhar([1,2,3,4,5,6,7,8])


func trocarPontas<T>(_ vetor:[T]) -> [T] {
    
    var novoVetor = vetor
    guard let primeiro = vetor.first,
          let ultimo = vetor.last else {
        return vetor
    }

    novoVetor[0] = ultimo
    novoVetor[vetor.count - 1] = primeiro
    return novoVetor
}

trocarPontas(["a","b","c","d"])


func fatiar<T>(_ vetor:[T],inicio:Int,fim:Int) -> [T] {

    var novoVetor = [T]()
    guard !vetor.isEmpty else {
        return vetor
    }
    guard (fim-inicio) < vetor.count else {
        return vetor
    }
    
    for indice in (inicio...fim) {
        novoVetor.append(vetor[indice])
    }
    return novoVetor
}

fatiar(["igor","clemente","dos","santos"],inicio:0,fim:4)

