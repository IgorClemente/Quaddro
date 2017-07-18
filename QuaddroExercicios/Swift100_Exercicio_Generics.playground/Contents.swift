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