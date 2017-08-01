//: Brincando com Variaveis

var (a,b) = ("Igor",20);

var nome = "Igor Clemente";
var idade = 20;

print("Meu nome \' \(nome) \' tenho \' \(idade) \' anos de idade.")

var empresa = "Aerosoft Cargas"
var empresa2 = "Pontocom Services"

print(empresa + " " + empresa2)

let caracter1 = "caf\u{E9}"
let caracter2:Character = "\u{24}"
let caracter3 = "\u{2665}"

print("Palavra Acentuada: \(caracter1)")
print("Simbolo Cifrao: \(caracter2)")
print("Coracao: \(caracter3)")

let meuNome:String = "Igor Clemente dos Santos"
let idade2:Int = 20

let x = "Clemente"
let y = "Clemente"

print(x == y)


//Operadores Aritmeticos

let soma = 10 + 5
let multiplicacao = 10*5
let divisao = 10/5
let resto = 10%5

print(-soma)


//Operadores Compostos

var valor = 100
    valor += 10

var valorProduto = 300.00
    valorProduto -= 45.80
    valorProduto *= 0.1
    valorProduto /= 2.0

var nomeCompleto = "Igor Clemente"
let result = (nomeCompleto == "Igor Clemente") ? "Seja Bem Vindo \(nomeCompleto)" : "Desconhecido"

var nomeCompleto2 = "Joao Lorde"
let resultado = (nomeCompleto2 == "Igor Clemente") ? "Seja Bem Vindo \(nomeCompleto2)" : "Desconhecido"

var parOuImpar = (10%2 == 0) ? "Par" : "Impar"
    parOuImpar = (3%2 == 0) ? "Par" : "Impar"

//Declaracao de Valores do Mesmo tipo:

/**
var empresa = ("Apple", "iOS", "Swift")

    empresa:(String, String, String) = {
    
        0 = "Apple"
        1 = "iOS"
        2 = "Swift"
    }

var pessoa = ("Pedro Alvares Cabral", 40, 87.3)

    pessoa:(String, Int, Double) = {

        0 = "Pedro Alvares Cabral"
        1 = 40
        2 = 87.3000000000000000
    }

print(empresa.0)
print(pessoa.0)
**/

var person:(String, Int, Double) = ("Igor Clemente", 20, 1.85)
    person.0
    person.1
    person.2

var person2 = ("Joao Cravo",40,23.6)
    person2.0
    person2.1
    person2.2

var carro:(String, String, String) = (modelo: "Sedan", marca: "Hiunday", potencia: "2.0")
    carro.0
    carro.1
    carro.2

//Decompor uma tupla

var (modelo,marca,potencia) = carro
    modelo
    marca
    potencia

//Ignorando um valor

var (modelo2,_,potencia2) = carro
     modelo2
     potencia2

//Array vazio - Declaracao Explicita

var arr  = [String]()
var arr2:[String] = ["igor","joao","pedro"]
var arr3 = ["igor","clemente","dos"]

arr3.append("Primeiro Valor")
arr3.append("Segundo Valor")

arr3 += ["Terceiro Valor"]
print(arr3)

arr3.insert("Novo Valor", at: 1)
print(arr3)

arr3.remove(at: 0)
print(arr3)

arr3[3] = "Valor Substituido"
print(arr3)

