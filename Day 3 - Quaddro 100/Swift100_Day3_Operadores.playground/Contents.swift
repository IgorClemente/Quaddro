//:Operadores

// No Swift podemos criar novos operadores!
// Ou seja:

let a = 10
let b = 12
print(a + b) //Na verdade, + é um operador

//Tipo 1: Prefix

//Prefix : Operador vem antes
//Infix : Operador que vem entre os valor
//Postfix: Operador que vem depois do valor


// Tipo 1: Prefix
// Vem antes do valor

prefix operator ✂️

prefix func ✂️(texto:String)->String {
    return String(texto.characters.filter{
        "aeiou".characters.contains($0)
    })
}

let vogais = ✂️"Igor"

// Frizz
// Crie um operador raiz quadrada
// Exemplo: print(√9)

// Dica:

import Darwin
sqrt(9)

prefix operator √
prefix func √(numero:Double)->Double {
    return sqrt(numero)
}
let raiz = √9

postfix operator ❌
postfix func ❌(numero:Double)->Double {
    return (numero/100)
}
let porcento = 200 * 9❌


//Infix
//Sym ♒︎ -> aquarius

infix operator ♒︎
func ♒︎(esquerda:Int, direita:Int) -> [Int] {
    let inicio = min(esquerda, direita)
    let fim = max(esquerda, direita)
    
    var resposta:[Int] = []
    for i in inicio...fim {
        resposta.append(i)
    }
    return resposta
}
print(2♒︎8)


//PARA O LAR: https://pastebin.com/e195DUDr

