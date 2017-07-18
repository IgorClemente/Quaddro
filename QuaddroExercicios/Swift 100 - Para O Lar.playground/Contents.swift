//: Exercicios - Conteudo da Aula

//: Essentials

// Exercicio A

func dobro(De numero:Int)->Int {
    return numero*2
}

dobro(De: 4)


// Exercicio B

func mediaAritmetica(comecandoEm numeroA:Int, terminandoEm numeroB:Int)->Int {
    
    let inicio = min(numeroA,numeroB)
    let fim  = max(numeroA,numeroB)
    var media = Int()
    
    for numero in inicio...fim {
        media += numero
    }
    media /= (inicio...fim).count
    return media
}

mediaAritmetica(comecandoEm: 5, terminandoEm: 2)


// Exercicio C

func avaliar(numeroNegativo numero:Int)->Bool {
    return numero < 0 ? true : false
}

avaliar(numeroNegativo: 3)


//  Exercicio D

func inverso(De numero:Int)->Int {
    return -numero
}

inverso(De: 5)


//: Challenges


// Exercicio E


func menor(ValorDe valores:[Int])->Int {
    
    if !valores.isEmpty {
        let menor = valores.reduce(valores[0]){ min($0,$1) }
        return menor
    }else {
        return 0
    }
}

let menorNumero = menor(ValorDe: [6,8,5,8,2,6])

// Exercicio F

/*
 
 - Dividindo palavras
 
 import Foundation
 
 let texto = nome.components(separatedBy:" ")
 var resposta = ""
 for pedaco in components {
    resposta += String(Array(pedaco.characters)[0])
 }
 return resposta
 
 */

func iniciais(nome:String)->String {

    let mapeado = Array(nome.characters).map{ $0 == " " }
    var iniciais = String()
    
    for (numero,valor) in mapeado.enumerated() {
        if valor {
           iniciais += String(Array(nome.characters)[numero+1])
        }else if numero == 0 {
                iniciais += String(Array(nome.characters)[numero])
        }
    }
    return iniciais
}

iniciais(nome: "Igor Clemente dos Santos")


// Exercicio G

func ultimasLetras(palavra:String)->String {
    
    let mapeado = Array(palavra.characters).map{ $0 == " " }
    var iniciais = String()
    
    for (numero,valor) in mapeado.enumerated() {
        if valor {
            iniciais += String(Array(palavra.characters)[numero-1])
        }else if numero == (mapeado.count-1) {
                iniciais += String(Array(palavra.characters)[numero])
        }
    }
    return iniciais
}

ultimasLetras(palavra: "aqui tem muitas palavras")

import Foundation

func finais(nome:String) -> String {
    
    let componentes = nome.components(separatedBy: " ")
    var resposta = ""
    for pedaco in componentes {
        resposta += String(Array(pedaco.characters)[componentes.count + 1])
    }
    return resposta
}



//:Classes

class Motor{
    
    private var potencia = Int()
    private var combustivel = String()
    private var ativo = Bool()
    var nivelDoOleo:Float {
            didSet {
                if nivelDoOleo < 0 {
                    nivelDoOleo = 0
                }
        }
    }
    
    var kmsRodados = Int()
    
    init(ligado ativo:Bool, potencia:Int = 90, combustivel:String){
    
        self.potencia = potencia
        self.combustivel = combustivel
        self.ativo = ativo
        kmsRodados = 0
        nivelDoOleo = 1.0
    }
    
    func rodar(kms:Int)->Void {
        
        if nivelDoOleo <= 0 {
            print("Não posso rodar porque não tem óleo no motor!")
        }
        
        let kmAntigo = kmsRodados
        kmsRodados += kms
        
        let quantidadeAtual = kmsRodados / 120
        let quantidadeAnterior = kmAntigo / 120
        
        if quantidadeAtual > quantidadeAnterior {
            for _ in (1...(quantidadeAtual-quantidadeAnterior)) {
              nivelDoOleo -= 0.03
            }
        }
    }
}

let novoMotor = Motor(ligado:true, combustivel:"Gasolina")
    novoMotor.kmsRodados
    novoMotor.rodar(kms: 4080)
    novoMotor.nivelDoOleo



class Pneu {
    
    var marca = String()
    var furado:Bool{
        willSet{
            let furou = newValue ? "Furou" : "Foi Consertado"
            print("O pneu: \(furou)")
        }
    }
    
    var aro:Int {
        didSet {
            let aroDefault:Int = 13
            if !([13,14,15,16].contains(aro)) {
                aro = aroDefault
            }
        }
    }
    
    var kmsRodados = Int()
    
    init(marca:String,aro:Int = 13) {
        
        self.marca = marca
        self.aro = aro
        furado = false
        kmsRodados = 0
        
    }
    
    func rodar(kms:Int)->Void {
        
        if furado {
            print("Não posso rodar de pneu furado!")
            return
        }
    
        var porcentagemPneu = Float()
        let kmsAntigo = kmsRodados
        kmsRodados += kms
        
        let quantidadeAtual = kmsRodados / 50
        let quantidadeAnterior = kmsAntigo / 50
        
        if quantidadeAtual > quantidadeAnterior {
            for _ in (1...(quantidadeAtual-quantidadeAnterior)) {
                porcentagemPneu += 0.02
            }
            
            if porcentagemPneu >= 1.0 {
                furado = true
            }
        }
    }
}


let pneu1 = Pneu(marca:"Pirelli",aro:20)
let pneu2 = Pneu(marca:"Pirelli",aro:20)
let pneu3 = Pneu(marca:"Pirelli",aro:20)
let pneu4 = Pneu(marca:"Pirelli",aro:20)



class Carro {

    var cor = String()
    var ano = Int()
    var marca = String()
    var pneus = [pneu1,pneu2,pneu3,pneu4]
    let motor:Motor = novoMotor
    
    init(marca:String,ano:Int,cor:String) {
    
        self.marca = marca
        self.ano = ano
        self.cor = cor
    }
    
    func rodar(kms:Int) {
        
        pneus.forEach {
            $0.rodar(kms: kms)
        }
        motor.rodar(kms: kms)
    }
}


let novoCarro:Carro = Carro(marca:"Chevrolet",ano:2017,cor:"Vermelho")

    novoCarro.rodar(kms: 10000)
    novoCarro.motor.nivelDoOleo


// https://pastebin.com/BwkW5L1Y








