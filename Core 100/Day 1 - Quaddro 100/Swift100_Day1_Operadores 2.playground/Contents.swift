//: Operadores

//Atribuacao(=)


var valor = 300
var codigo = 5

//Aritiméticos

let soma = 4 + 5
let subtracao = 8 - 2
let multiplicacao = 100 * 0.3
let divisao = 200 / 3 //Duvisao Int - Int descarta decimais

let divisãoDecimal = 200 / 3.0 //Considera a casa decimal - Int - Double
let resto = 7%4
let éPar = 50%2 == 0


//Operadores Compostos

var numero = 5
numero += 3
numero -= 2
numero *= 2
numero /= 5
numero %= 2

//Concatenar String - Composto
var texto = "Olá"
texto += ", Igor"

//Não existe no Swift: numero++

let (a,b) = (1,3)

var igual =  a == b
var diferente =  a != b

igual
!igual

a > b
a < b

a >= b
a <= b

//Operador ternário
//<Expressão Logica> ? <retorno true> : <retorno false>

let n = 5
var parOuImpar = "Não sei"
    parOuImpar = n % 2 == 0 ? "Par" : "Impar"

//Blocos
//[parOuImpar] = [n % 2 == 0] ? ["Par"] : ["Impar"]
//[parOuImpar] = [true] ? ["Par"] : ["Impar"]

//Exercício - Sala

let nome = "Igor"
let sobrenome = "Clemente"

var tamanhoNome = Double(nome.characters.count)
var tamanhoSobrenome = Double(sobrenome.characters.count)

var variacaoTotal = tamanhoNome / tamanhoSobrenome

/**

let nomeG = "Gustavo"
let sobrenomeG = "Lino"

var tamanhoNome = Double(nomeG.characters.count)
var tamanhoSobre = Double(sobrenomeG.characters.count)

var variacao = tamanhoNome / tamanhoSobre
    variacao -= 1
    variacao *= 100

var resultado = variacao == 75 ? "Verdade" : "Falso"
 
**/