/*
 
 : Dicionários - Day 2 - Swift 100
 : Exercicios e Exemplos Feitos em Sala de Aula
 : Arquivo para Referencia
 
*/

//Dicionario possuem valores não Ordenados

var rodizio = [
 
    "SEG":"1 e 2",
    "TER":"3 e 4",
    "QUA":"5 e 6",
    "QUI":"7 e 8",
    "SEX":"9 e 0"
]

rodizio["QUI"]
"QUA".hashValue

rodizio["DOM"] = "Todas"
print(rodizio)

rodizio["SEG"] = "Nenhum"
print(rodizio)

rodizio["FERIADO"]      //Retorna Nulo, Porque não existe
rodizio["DOM"] = nil    //Para remover, escrevemos nulo
print(rodizio)

// Variacao com declaracoes explicitas de tipo
// Jeitos:

var jeito1:[String:String] = [String:String]() // <- Cria um dicionario vazio de String:String
var jeito2:[String:String] = [:]               // <- Dicionario Vázio
var jeito3 = Dictionary<String, String>()      // <- Cria um dicionario vázio de String:String


// - Listando os Valores

let nomeDoNumero:[Int:String] = [
    1: "UM",
    2: "DOIS",
    3: "TRES"
]

nomeDoNumero[1]
nomeDoNumero[2]
nomeDoNumero[4] // <- Não Existe esse dia - RETORNO "nil" = null em outras linguagens


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


/*
 
 Dicionario de Dados
 Mais Exemplos
 
*/


typealias Departamento = (nome: String, local: String)
var departamentos = Dictionary<Int,Departamento>()

    departamentos[1] = ("Financeiro","1 ANDAR")
    print(departamentos)

    departamentos[2] = ("Pagamentos Operacionais","6 ANDAR")
    print(departamentos)

print("\(Array(departamentos.keys))")
print("\(Array(departamentos.values))")


for (numero, nome) in departamentos{

    print("Nome Departamento: \(nome), Numero Departamento: \(numero)")
    
}


//Ultimo módulo de Swift:

filmes["O Hobbit"]?.diretor

var livros:[String:String] = [:]
    livros["A lei dos Ignorantes"] = "Lucas Silveira"
    print(livros)

    livros["Do Zero ao Chao"] = "Peterson Fips"
    print(livros)


var rodizio2:[String:String] = [

    "SEG":"1 a 2",
    "TER":"3 a 4",
    "QUA":"5 a 6",
    "QUI":"7 a 8",
    "SEX":"9 a 0"
]
    rodizio2["SEG"]
    rodizio2["TER"]

for (dia, placa) in rodizio2 {

    print("No dia: \(dia), e permitido as placas com final \(placa)")
    if(dia == "SEG"){
        rodizio[dia] = nil     //Para remover Chave e Valor do Dicionario
    }
}

"SEG".hashValue

rodizio2.removeValue(forKey: "SEG")
rodizio2.removeValue(forKey: "TER")



