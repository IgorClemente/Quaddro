//: Protocols
// São acordos !


// Protocolo 'Descritível' diz que todos que respeitam,
// Assinam, estão em conformidade, implementa uma funcao
// chamada 'descricao'


protocol Descritivel {
    func descricao () -> String
}


// Um exemplo, com struct


struct Retangulo : Descritivel {
    
    var largura:Double
    var altura:Double
    
    func descricao() -> String {
        return "Olá, eu sou um retangulo com \(largura) de largura e \(altura) de altura"
    }

}

// Outro exemplo:

class corRGB : Descritivel {

    var red:UInt8 = 0
    var green:UInt8 = 0
    var blue:UInt8 = 0
    
    func descricao() -> String {
        if red > max(blue, green) {
            return "Avermelhada"
        }else if blue > max(red, green) {
            return "Azulado"
        }else if green > max(red,blue) {
            return "Esverdeado"
        }else {
            return "Acinzentado"
        }
    }
}

let retangulo = Retangulo(largura: 2, altura: 5)
    retangulo.descricao()

let cor = corRGB()
    cor.red = 120
    cor.descricao()

//Assim podemos fazer esse tipo de construcao

let coisa:Descritivel = cor
    coisa.descricao()


// Além de funcoes, podemos pedir variáveis ou constantes nesses acordos que são os Protocols

protocol QueLigaDesliga {
    
    var ligado:Bool { get set }
    // { get } só preciso ler
    // { get set } quero ler e escrever
}

protocol QueTemMarca {
    var marca:String { get } // nesse caso, só quero ler
}

// A classe sempre deve ser primeiro, no caso de estar extendendo outra classe

class Motoca: Veiculo, QueLigaDesliga, QueTemMarca {
    
    var ligado: Bool = false //get/set, logo var
    private(set) var marca:String //get, o set é privado
    
    init(marca:String) {
        self.marca = marca
    }
}
var minhaMoto = Motoca(marca: "Yamaha")
    minhaMoto.ligado = true

// Com isso podemos modelar várias coisas:

class TV : QueLigaDesliga {
    var ligado: Bool = false
}
