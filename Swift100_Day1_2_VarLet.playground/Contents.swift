//: Declaracao de Variaveis
// var `nomeDaVariavel` = `valor`


var meuNome = "Lino"
print(meuNome)
meuNome = "Igor"


//Swift usa tipagem forte,
//Ou seja, numero é numero e texto é texto
//Após declarar não podemos fazer meuNome = 89

//usando declaracao de tipo
//var `nomeVar`:`tipo` = `valor`

var numero:Int = 7

//Para numero é importante colocar o tipo


//Swift é UTF-8

var 🤔 = "Clm"
var leão = "IG6R"
print(leão)

//Lista de tipos básicos

var decimal:Double = 5.7883
var outroDecimal:Float = 6.9778
var d = 5.786 // <- Double Implicito (64 Bits)

// Inteiros

var inteiro = 4 // Inferindo Int (64 Bits)

Int8.max
Int16.max
Int32.max
Int64.max

// Para inteiros sem sinal
UInt8.max


// Tipos dentro dos Kits da Apple
// CGFloat <- ponto flutuante da placa de video

// Texto / String

var frase:String = "Lorem 🏈 ipsum"
var letra:Character = "A"       // ** //

// Dá para pegar a lista de Characters
// Usando a propriedade `characters`

Array(frase.characters)


// Tipo True/False (Boolean)

var flag:Bool = false  // Explicito
var valido = true      // Com inferencia

// Constantes

let interjeicao = "Constante"
//Não funciona: interjeicao = "Igor Clm"


let tamanho = "G"
let ficaria:String

//Não funciona, pois não foi definido: print(ficaria)

if tamanho == "G" {

    ficaria = "Grande"

}else{
    ficaria = "Na medida"
}


// Exercicio 1 - Declaracao - Variaveis - Tipos - Constantes


// - meuNomeCompleto
var meuNomeCompleto = "Igor Clemente dos Santos"

// - meuAnoDeNascimento
let dataNascimento:UInt = 1997

// - minhaNacionalidade
var nacionalidade:String = "Brasileiro"

// - minhaNaturalidade
let naturalidade:String  = "Guarujá"

// - minhaIdade
var idade:Int = 20

// - minhaAltura
var altura:Double = 1.85

// - tenhoCNH
let cnh:Bool = false




