//: Enumeradores


enum StatusDoPedido {
    
    case feito
    case faturado
    case emSeperacao
    case enviado
    case entregue
    case cancelado
}

// São como listas de opcoes, utilizados amplamente para organizar o código e deixar explicitas as possibilidades
// Também podemos listar em uma unica linha

enum Classe {

    case economica, executiva, primeira
}


// usamos desta maneira

let minhaClasse:Classe = .economica

// Pode associar um tipo primitivo ao enumerador
// QUE ? exemplo:

enum Erros:Int {

    case badRequest   = 400
    case unauthorized = 401
    case forbidden    = 403
    case notFound     = 404
}

let umErro = Erros.notFound

// para recuperar o valor, usamos 'rawValue'

let codigoDoErro = umErro.rawValue


// Quando o tipo é String.. rawValue funciona também
// Podemos extrair a string somente declarando um case

enum CoberturaDeSorvete:String {

    case Maracujá
    case Chocolate
    // é possível customizar cases especificos
    case Manga
}

var preferida:CoberturaDeSorvete = .Maracujá
    preferida.rawValue


// Ritz

/*

 - 1) Faca um enumerador que represente os estados de um semáforo de transito
 - 2) Faca um enumerador para representar o status de um jogador de futebol em uma partida (em campo...)
 - 3) Faca um enum de canais de TV aberta, em que o tipo associado seja o numero de canal

*/


enum Estados:String {

    case verde
    case vermelho
    case amarelo
}

let semáforo:Estados = .verde
    semáforo.rawValue

enum Status:String {
    
    case machucado
    case jogando
    case no_banco
}

let jogadorFutebol:Status = .jogando
    jogadorFutebol.rawValue

enum Canais:Int {

    case cultura = 2
    case sbt = 4
    case record = 21
    case band = 13
}

let televisao:Canais = .cultura
    televisao.rawValue


// Outra funcionalidades de enum é armazenar valores

enum StatusVeiculo {
    case estacionado
    case movimentando(velocidade:Int)
}

class Fusca {
    
    var estado:StatusVeiculo = .estacionado
}

var 🚘 = Fusca()
    🚘.estado
    🚘.estado = .movimentando(velocidade: 80)
    🚘.estado

// Enums são práticos com Switch

enum CorDoCarro:String {
    
    case preto
    case prata
    case branco
    case azul
    case vermelho
}

let corDoMeuCarro = CorDoCarro.azul

switch corDoMeuCarro {
case .azul:
    print("do igor")
case .preto:
    print("do uber")
case .branco:
    print("do taxi")
case .vermelho, .prata:
    print("normal")
}


// Quando tem valor associado melhor ainda

switch 🚘.estado {

case .estacionado:
    print("Está seguro 👊🏻")
case .movimentando(let velocidade):
    if velocidade < 60 {
        print("Andando mas seguro")
    }else{
        print("Cuidado ! ⚠️")
    }
}


/*
 
 - 4) Faca em enum de marchas de um cambio de um carro
 - 5) Faca um enum de estados do motor, que tenha parado, e funcionando, sendo que o funcionando tenha um valor associado do tipo de marcha
 - 6) Faca um Switch que diga se o carro está parado, andando para frente ou para trás
 
 */



enum Marchas:Int {
    
    case primeira = 1
    case segunda = 2
    case terceira = 3
    case quarta = 4
    case quinta = 5
    case sexta = 6
}

enum EstadosMotor {

    case parado
    case funcionando(marcha:Int)
}


class meuCarro {

    var estadoMotor:EstadosMotor = .funcionando(marcha: 5)
}


let carrinho = meuCarro()

switch carrinho.estadoMotor {

case .parado:
    print("Ligue o motor, engate uma marcha")
    
case .funcionando(let marcha):
    if [1,2,3,4,5,6].contains(marcha) {
        print("Carro fucionando na marcha \(marcha), Pode acelerar")
    }else{
        print("Engate um marcha")
    }
}

// Por ultimo, enums também tem métodos

enum Botão {
    case ligado, desligado
    mutating func troca() {
        if self == .ligado {
            self = .desligado
        }else{
            self = .ligado
        }
    }
}

var meuInterruptor:Botão = .desligado
    meuInterruptor
    meuInterruptor.troca()
    meuInterruptor
