//: Loops

//FOR

let almocoSemanal = Array(repeating:"Bacon 🥓", count: 7)

//Estrutura Básica
//for 'novaVariavelComUmDosItens' in 'vetor/array/lista'
//  ... código para fazer alguma coisa com o item
// }

for almoco in almocoSemanal {
    
    print("Hoje Almocei")
}

for (indice, almoco) in almocoSemanal.enumerated(){
    print("Dia \(1+indice), almocei \(almoco)")
}

//Intervalos
// Exemplo: loop de 0 até 10, incluso

for indice in (0...10) {
    print("Indice \(indice)")
}

let limite = 2
for i in 0...limite {
    print("NO LIMITE :B")
}

var emon:String = ""
var meuNome = "Igor Clemente dos Santos"

for letra in Array(meuNome.characters).reversed() {
    emon += String(letra)
}
print(emon)

let nomeAoContrário = meuNome.characters.reduce(""){ "\($1)\($0)" }
    nomeAoContrário


// Por ultimo
// While -> Enquanto

var valor = 0

while valor < 3 {

    valor += 1
    print("Subindo \(valor)")
}

repeat {

    valor -= 1
    print("Descendo: \(valor)")

}while valor > 0


//Quizzzzzzz zzzz zzz 
/*
1) Print da contagem de 1 a 10
2) Print dos números pares de 1 a 10
3) Print da contagem regressiva de 5 até 0
4) Print da contagem regressiva do impares de 10 até 0
5) Extrair as vogais de um texto
*/

var value = 0
    valor = 0

while valor < 10 {
    valor += 1
    print("Contagem: \(valor)")
}

while value < 10 {
    value += 1
    if(value%2 == 0){
        print("Par: \(value)")
    }
}

for i in (0...5).reversed(){
    print("Contagem (5...0)\(i)")
}

for i in (0...10).reversed(){
    
    if(i%2 != 0){
        print("Contagem (10...0)\(i)")
    }
}

let textoParaTeste = "ola,bem vindo"
var textoVogais:String = " "

for letra in Array(textoParaTeste.characters) {
    
    switch letra{
       
       case "a","e","i","o","u":
       
       textoVogais += String(letra)
        
       default:
        
       print("\(letra) Não é Vogal")
    }
}
print(textoVogais)


var vogais = ["a","e","i","o","u"]

/*
var filtrado = Array(textoParaTeste.characters).filter{
    $0 == 
}
print(filtrado)
*/






