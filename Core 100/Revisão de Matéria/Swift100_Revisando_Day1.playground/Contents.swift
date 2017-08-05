/*
 
 - Autor: Igor Clemente dos Santos
 - Data: 22 de Julho de 2017
 - Revisando: Introdução a Linguagem Swift
 - Var, Let
 - Comentários, Marcadores
 - Tipos, Operadores, String, Tuplas, Arrays
 
 */


//: Var, Let, String, Character, Tipos

var numeroNormal: Int = 12345

var anoDeNascimento: Int = 1997

var meuNomeCompleto: String = "Igor Clemente dos Santos"

var altura: Float = 20.8   //Float 32 Bits

var meuSalário: Double = 1600 //Double 64 Bits

var mensagemDeSaudação = "Olá \(meuNomeCompleto), Seja Bem vindo"

var mensagemDeInterpolação: String = "Minha casa tem \(altura) de altura"

var oMotorDoCarroEstáLigado = Bool()
    oMotorDoCarroEstáLigado = true

UInt8.max
UInt16.max
UInt32.max
UInt64.max

Int8.max
Int16.max
Int32.max
Int64.max


//:Operadores

//Atribuição  =

var a = 3
var b = 10

//Comparacao ==

var igual = a == b
    !igual

a > b
a < b
a >= b
a <= b
a != b

var numero = 10
    numero += 3
    numero -= 1
    numero *= 2
    numero /= 3
    numero %= 2

var qualquerTexto = "Olá"
    qualquerTexto += ",Igor Clemente"

var (j,c,i,n) = (1,2,98,56)


var MinhasInformações = ("Igor Clemente dos Santos",20,1997)
    MinhasInformações.0
    MinhasInformações.1
    MinhasInformações.2

typealias Endereco = (logradouro:String,numero:Int)
typealias Informacoes = (rg:Int,cpf:Int)

let enderecoCasa : Endereco = ("Rua Durval Fontoura Castro",40)
    enderecoCasa.logradouro
    enderecoCasa.numero

var informacoesPessoais : (nome:String, sobrenome:String, Endereco, Informacoes) = ("Igor","Clemente dos Santos",("Rua Durval Fontoura Castro",40),(4433225542,8585877444))
    informacoesPessoais.nome
    informacoesPessoais.sobrenome
    informacoesPessoais.2.logradouro
    informacoesPessoais.2.numero
    informacoesPessoais.3.cpf
    informacoesPessoais.3.rg

//:Arrays

var numeros = [1,2,3,4,5,6,7,8]
    numeros.append(50)
    numeros.insert(49,at:2)
    numeros.count
    numeros.dropFirst()
    numeros.dropLast()

var textosAleatorios = Array<String>()
var textoConcatenado = String()


["Igor","Outro Texto","Palavra Qualquer","Clemente","meuSobrenome"].forEach {
    
    textosAleatorios.append($0)
    textoConcatenado += $0
}
print(textosAleatorios)
print("Texto concatenado, texto aleatório: ",textoConcatenado)

let formatado = textosAleatorios.filter {
    $0 != " "
}

formatado.forEach {
    print($0)
}

var enderecos = [Endereco]()

[("Rua dos Prazeres",90),("Rua Durval Fontoura Castro",40),("Rua Luigi Caruso",8)].forEach {
    enderecos.append($0)
}

let logradouros = enderecos.map { $0.logradouro }
    print(logradouros)

let numerosAbaixo50 = enderecos.filter { $0.numero < 50 }
    print("Enderecos com numeros abaixo de 50 -> <- ",numerosAbaixo50)

var m:Int = 90
var y:Int = m

m == y
m != y

typealias Filho = (nome:String, idade:Int)
typealias Mae = (nome:String, filhos:[Filho])

let minhaMae:Mae = ("Maria Quitéria dos Santos",[("Igor Clemente dos Santos",20),("Nicole Clemente dos Santos",15),("Nicolas Clemente dos Santos",25)])

for filho in minhaMae.filhos {
    print("O filho \(filho.nome), tem \(filho.idade) anos de idade")
}


typealias Produto = (nome:String,preco:Double,quantidade:Int,categoria:String)

var produtos = Array<Produto>()
    produtos.append(("Arroz",10.80,2,"A"))
    produtos.append(("Feijão",7.98,4,"A"))
    produtos.append(("Carne",20.89,8,"B"))
    produtos.append(("Danone",7.90,2,"C"))

var descontosPorProduto = [Double]()

for produto in produtos {
    if produto.quantidade > 3 {
        let descontoAplicado = (produto.categoria == "A" || produto.categoria == "E") ? (produto.preco/100 * 0.7) : (produto.preco/100 * 0.9)
        descontosPorProduto.append(produto.preco - descontoAplicado)
    }
}
print("Desconto aplicado por produto: ",descontosPorProduto)













