//: Tupla 

let empresa = ("Quaddro","5354-8909","contato@quaddro.com.br")
    empresa.0
    empresa.1
    empresa.2

var pessoa:(String, Int, Double) = ("Igor",20,1.85)
    pessoa.0
    pessoa.1
    pessoa.2

var carro:(nome:String, ano:Int) = ("Fiat", 1443)
    carro.nome
    carro.ano


// :Dar apelidos a tupla

typealias NomeCompleto = (nome: String, sobrenome: String)
let aluno:NomeCompleto = ("Igor", "Clemente")
    aluno.sobrenome

let aluno2:NomeCompleto = ("KKK","LLL")
    aluno2.nome

// :Podemos usar tuplas em retornos de funcao

func acessarSite() -> (error: String, código: Int){

    return ("Não Encontrado",404)
}

acessarSite().código
acessarSite().error


// :Quiz
// 1.Faca uma tupla para representar um endereco, com:
// -- rua, numero, cidade

typealias CPF = (numero: Int, digito: Int)
typealias Endereco = (rua:String , numero:Int, cidade:String)

var endereco:Endereco = ("Rua 43",23,"SP")
    endereco.rua
    endereco.numero
    endereco.cidade

// 2.Faca uma tupla para representar um CPF:
// -- numero, digito

var cpf:CPF = (464654123,7)
    cpf.numero
    cpf.digito

// 3. Faca uma tupla para representar uma pessoa, com:
// -- nome, cpf e endereco (Tupla de Tuplas)

var pessoa2:(nome: String, CPF, Endereco) = ("Igor Clemente",(134_456_677,7),("Rua 43",23,"São Paulo")) // O '_' é desconsiderado na prática
    pessoa2.nome
    pessoa2.1.numero
    pessoa2.1.digito

    pessoa2.2.rua
    pessoa2.2.cidade
    pessoa2.2.numero


//: Array


// :Construcao

var pessoas = ["Igor","João","Maria","Joana"]


// O tamanho do vetor e vitualmente infinito

// :Tipagem Explicita (Dois Jeitos)

let constantes:[Int] = [1,2,3,5,8,13]
let megaNumeros:Array<Int> = [12,18,46,50,53,55]

// :Array de Tuplas

var arrayDeTuplas:[(nome:String, idade:Int)]
var tuplaComArray:(nome:String, filhos:[String])

arrayDeTuplas = [
    ("Maria de Lourdes",54),
    ("Maria de Fatima", 59),
    ("Maria José",62)
]

tuplaComArray = ("Maria de Lourdes",pessoas)
tuplaComArray.filhos[0]
tuplaComArray.filhos[1]

// :Diferenca de VAR e LET com Array

let lista = ["Pão","Queijo"]

//: Não Podemos alterar, Pois foi declarado com LET

pessoas.append("Simone")
pessoas.insert("Miguel", at: 0)

// :Removendo

pessoas.removeFirst()
pessoas.removeLast()

pessoas.dropFirst()   //Retorna um novo Array

var notas = [8,10,8,7,9]
let melhores = notas.sorted().dropFirst()
        
//: Contando

var refeicoes = ["Arroz","Arroz","Pizza"]
    refeicoes.count
    refeicoes.isEmpty // <- Melhor do que Count == 0
    refeicoes.underestimatedCount    //Contagem do Estimada do Vetor


// :Procurar em um vetor

refeicoes.contains("Pizza")

// :Vetor Vázio

let solidão:[Int] = []

Array(refeicoes.enumerated())   //Para saber a posicao e o que tem dentro

//Funcional:

/*

 1 Vez: $0 -> 0
 2 Vez: $0 -> 1
 3 Vez: $0 -> 2
 4 Vez: $0 -> 3
 5 Vez: $0 -> 4
 6 Vez: $0 -> 5
   Vez: $0 -> 6
 
*/

var soma = 0
constantes.forEach{ soma += $0 }
print(soma)

// :Filter - Percorre o Vetor e Verifica Qual item deve aparecer - Através do Cloujure

let filtrado = constantes.filter{ $0%2 == 0 }
filtrado


// :Map - Passa em cada item transformando cada coisa

let mapeado = constantes.map{ $0 * 2}

// - Reduce
// Reduz o vetor a um item só - Exemplo abaixo usa '$0' como indice temporario e '$1' como valor corrente

let reduzido = constantes.reduce(0) { $0 + $1 }
print(reduzido)

/* 
 
   Quiz
   Lista de Compras
   
   1. Criar uma tupla Produto (nome: String, comprado: Bool)
   2. Adicionar produtos na listaDeCompras (vetor de Produtos)
   3. Listar com print os produtos (nome e se foi comprado)
   4. Marcar dois produtos como comprado
   5. Listar produtos (igual passo 3)
   6. Listar somente os não comprados

*/

/*

:Minha Solucao - Ruim Porem Funcional
 
typealias Produto = (nome: String, comprado: Bool)

var produto1:Produto = ("Arroz",false)
var produto2:Produto = ("Carne",false)
var produto3:Produto = ("Feijão",false)

var listaDeCompras:[Produto]
    listaDeCompras = [produto1,produto2,produto3]
print(listaDeCompras)

    listaDeCompras[0].comprado = true
    listaDeCompras[1].comprado = true
print(listaDeCompras)

let filtro = listaDeCompras.filter{ $0.comprado == false }
filtro

*/


// :Solucao Lino

typealias Produto = (nome: String, comprado: Bool)
var listaDeCompras:[Produto] = []

listaDeCompras.append(("Arroz", false))
listaDeCompras.append(("Feijão",false))

["Veja","Macã","Laranja","Sabonete"].forEach {

    let novoProduto:Produto = ($0, false)
    listaDeCompras.append(novoProduto)
}

// :Listar

listaDeCompras.forEach {

    print("\($0.nome)")
}

// :Marcar como comprado

listaDeCompras[2].comprado = true
listaDeCompras[3].comprado = true


let filtrado3 = listaDeCompras.filter { $0.comprado == false }

filtrado3.forEach{

    print("Falta: \($0.nome)")
}


/*
    
 - Trabalhando com Arrays
 - Aplicando Metodos - Arrays
 
*/


var funcionarios:[String] = ["Igor Clemente dos Santos","Pedro Nogueira","Caio Lorde"]
var departamentos = Array<Int>()
    departamentos = [102,104,108,110]

for departamento in (111...190){
    
    departamentos.append(departamento)
}

departamentos.forEach{
    print($0)
}

departamentos.insert(156, at:3)
departamentos.sorted()
departamentos.removeFirst()
departamentos.removeLast()
departamentos.count
departamentos.isEmpty

var retornados = Array(departamentos.enumerated())

departamentos.dropFirst()
departamentos.remove(at: 3)
departamentos.contains(108)

let parDepartamentos = departamentos.filter{
    $0%2 == 0
}

let mapeadoDepartamentos = parDepartamentos.map{
    $0
}

let reduzidoDepartamentos = mapeadoDepartamentos.reduce(0){
    $1 + $0
}


