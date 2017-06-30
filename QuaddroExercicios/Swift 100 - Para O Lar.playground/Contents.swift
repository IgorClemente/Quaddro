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
    
    let menor = valores.reduce(valores[0]){ min($0,$1) }
    return menor
}

let menorNumero = menor(ValorDe: [6,8,5,8,4,6])

// Exercicio F

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


//:Classes

class Motor{
    
    private var potencia = Int()
    private var combustivel = String()
    private var ativo = Bool()
    var nivelDoOleo:Float {
                didSet {
                    if nivelDoOleo < 0 {
                        print("Filtro trocado")
                        nivelDoOleo = 1.0
                    }
        }
    }
    
    var kmsRodados = Int()
    
    init(ligado ativo:Bool, potencia:Int, combustivel:String){
    
        self.potencia = potencia
        self.combustivel = combustivel
        self.ativo = ativo
        kmsRodados = 0
        nivelDoOleo = 1.0
    }
    
    func rodar(kms:Int)->Void {
        
        let kmAntigo = kmsRodados
        kmsRodados += kms
        
        let quantidadeInteiro = kmsRodados / 120
        let quantidadeAnterior = kmAntigo / 120
        
        if quantidadeInteiro > quantidadeAnterior {
            for _ in (1...(quantidadeInteiro-quantidadeAnterior)) {
              nivelDoOleo -= (nivelDoOleo*0.03)
            }
        }
    }
}


let novoMotor = Motor(ligado:true,potencia:90,combustivel:"Gasolina")



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
    
    init(marca:String,aro:Int) {
        
        self.marca = marca
        self.aro = aro
        furado = false
        kmsRodados = 0
        
        setAro(self.aro)
    }
    
    func setAro(_ aro:Int)->() {
        self.aro = aro
    }
    
    func getAro()->(Int) {
        return aro
    }
    
    
    func rodar(kms:Int)->Void {
        
        var porcentagemPneu = Float()
        let kmsAntigo = kmsRodados
        kmsRodados += kms
        
        let quantidadeInteiro = kmsRodados / 50
        let quantidadeAnterior = kmsAntigo / 50
        
        if quantidadeInteiro > quantidadeAnterior {
            for _ in (1...(quantidadeInteiro-quantidadeAnterior)) {
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












