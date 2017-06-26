//: Classes

// Classes são a juncao de variáveis, constantes e métodos,
// Criando um molde que se poder tirar replicas
// Cada cópia tirada deste molde passar a ser chamada de 'objeto'.
// Suas variáveis, constante passam a interagir entre si e com
// Outros objetos


class Anotacao {
    
    var nota:String = ""
    var dia:Int = 0
    var mes:Int = 0
    var ano:Int = 0
    
    //Metodo Inicializador
    init(nota:String,_ d:Int,_ m:Int,_ a:Int){
        dia = d
        mes = m
        ano = a
        self.nota = nota
    }
    
    func descricao()->String{
        return "\(dia)/\(mes)/\(ano): \(nota)"
    }
}

let natal:Anotacao = Anotacao(nota:"Feriado: Natal",25,12,2017)
let diaDoTrabalho:Anotacao = Anotacao(nota:"Feriado: Dia do Trabalho",1,5,2017)

natal.descricao()
diaDoTrabalho.descricao()


// Blitz

// Faca uma agenda! Ou seja, uma classe que tenha
// ivar Dono:String (que o nome do dono da agenda)
// ivar anotacoes:[Anotacao] (vetor de notas, utilizando classe anterior)
// func adicionar(nota:Anotacao) -> ()
// [easy] func todasNotas() -> [String]
// [hard] func diasComNotas() -> [(Int,Int,Int)]

class Agenda{
    
    typealias Dias = (day1:Int,day2:Int,day3:Int)
    var dono:String
    var anotacoes = Array<Anotacao>()
    var descricoes = Array<String>()
    var diasNotas = Array<Dias>()
    
    init(dono:String){
    
        self.dono = dono
        self.anotacoes = []
    }
    
    func adicionar(nota:Anotacao)->(){
        anotacoes.append(nota)
    }
    
    func todasNotas()->[String]{
        anotacoes.forEach{
            descricoes.append($0.descricao())
        }
        return descricoes
    }
    
    func diasComNotas()->[Dias]{
        anotacoes.forEach{
            diasNotas.append(($0.dia,$0.mes,$0.ano))
        }
        return diasNotas
    }
}

let novaAgenda = Agenda(dono: "Igor")
    novaAgenda.adicionar(nota: natal)
    novaAgenda.adicionar(nota: diaDoTrabalho)

let notas = novaAgenda.todasNotas()




// Private e fileprivate

class ContaBancaria {

    let titular:String
    var saldo:Double
    var limite:Double
    
    static var banco:Int = 45     //Podemos também criar static vars
    
    var saldo:Double {
        willSet {
            print("O novo saldo será \(newValue)")
        }
    }
    
    var limite:Double {
        didSet {
            let limiteMax = 18_000.00
            if limite > limiteMax {
                limite = oldValue      //Old Value - Trás o valor antigo
            }
        }
    }

    init(_ nome:String) {
        self.titular = nome
        self.saldo = 0.0
        self.limite = 0.0
    }
    
    var disponivelParaSaque:Double{   //Variavel para fazer conta
        return saldo+limite
    }
    
    func setSaldo(saldo:Double){
        self.saldo = saldo
    }
    
    func getSaldo(){
        return saldo
    }
    
    //É possivel ter mais de um Init, para por exemplo, criar objetos passando menos parametros, assumindo valores
    convenience init(){
        self.init("Anonimo")
    }
}




