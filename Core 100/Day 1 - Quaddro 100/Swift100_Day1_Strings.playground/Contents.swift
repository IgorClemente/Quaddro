//: Strings
// Imprimindo Textos de uma linha

print("Hello!")

//Para VAR e LET

var nome = "Igor"
nome += " Clemente"
print(nome)

let idade = 20
print(idade)

//Interpolacao de String - Texto & Variaveis

print("O nome é \(nome), com idade: \(idade)")
print("\(4) + \(5) = \(4+5)")

// '\' Barra invertida é o caracter de escape (Para Marcacoes)

let paragrafo = "Igor \n Clemente \n Clm \n Cli"
print(paragrafo)

let tabulacao = "Items: \nPão \t1\nLeite\t2"
print(tabulacao)

let bebida = "Caf\u{E9}" // \u{Código UTF-8} 
let comida = "Pão"

print(bebida, comida, separator: "-", terminator: "")
print(comida, bebida, paragrafo, separator: "_", terminator: "_")

comida.uppercased()
comida.lowercased()




