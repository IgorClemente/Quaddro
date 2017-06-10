//: Dicionários

var rodizio = [
 
    "SEG":"1 e 2",
    "TER":"3 e 4",
    "QUA":"5 e 6",
    "QUI":"7 e 8",
    "SEX":"9 e 0"
]

rodizio["QUI"]
"QUA".hashValue

//Valores não Ordenados
rodizio["DOM"] = "Todas"
print(rodizio)

rodizio["SEG"] = "Nenhum"
print(rodizio)

rodizio["FERIADO"]  //Retorna Nulo, Porque não existe
rodizio["DOM"] = nil //Para remover, escrevemos nulo
print(rodizio)

// Variacao com declaracoes explicitas de tipo
// jeitos:/

var jeito1:[String:String] = [String:String]()
var jeito2:[String:String] = [:] // <- Dicionario Vázio
var jeito3 = Dictionary<String, String>() // <- Cria um dicionario vázio de String:String


// - Listando os Valores

let nomeDoNumero:[Int:String] = [

    1: "UM",
    2: "DOIS",
    3: "TRES"
]

nomeDoNumero[1]
nomeDoNumero[2]
nomeDoNumero[4] // <- Não Existe esse dia - RETORNO "nil"


var todosOsNumeros = ""
for(numero, nome) in nomeDoNumero {
   
    todosOsNumeros += "\(numero) é o: \(nome),"
}
print(todosOsNumeros)


/*
 
 Faca um dicionario com filmes, em que a chave seja o nome do filme 
 e o valor uma tupla contendo: Diretor, ano e nota de zero até 10
 
*/

typealias Descricao = (diretor: String, ano: Int, nota: Int)

var filmes:[String:Descricao] = [

    "Titanic":("James Cameron",1997,9),
    "O Hobbit":("Peter Jackson",2014,10),
    "Os Mercenarios":("Sylvester Stallone",2012,8)
]
print("\(Array(filmes.keys))")
print("\(Array(filmes.values))")


//Ultimo módulo de Swift:

filmes["O Hobbit"]?.diretor





 
