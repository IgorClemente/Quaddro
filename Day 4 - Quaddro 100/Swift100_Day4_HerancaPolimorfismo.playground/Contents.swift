//: Polimorfismo

//: Heranca é um conceito importante de orientacao a objetos, utlizando com frequencia, gerando ganhos em clareza e reaproveitamento
// Básicamente: o que é do meu pai também


class Personagem {

    final var vida:Int = 10_000  //Nenhuma classe que herde pode alterar a vida
    
    func grito() -> String {
        if vida > 8_000 {
            return "Haaaa!"
        }else{
            return "Arrghh!"
        }
    }
}

//Inimigo herda de Personagemx
class Inimigo:Personagem {
    
    let defesa:Int = 6_000
    
    override func grito() -> String { // Sobrescrevendo o metodo Grito
        return "Muhahahaahahaah"
    }
}

class Herói:Personagem {
    
    let ataque:Int = 9_500
    
    func atacar(_ alvo:Inimigo) {
        alvo.vida = self.ataque - alvo.defesa
    }
}

let goku = Herói()
let vegeta = Inimigo()

goku.atacar(vegeta)
goku.grito()        //Grito é um func herdado de Personagem
vegeta.grito()

print("Goku ataca  vegeta, que agora tem \(vegeta.vida)")



//Frizz 


/*
 
 
 - Faca uma classe animal e em seguida e apartir dessa classe, duas outras: Cachorro e Gato
 - Crie propriedades e métodos, pelo menos 3 de cada, pensando em heranca e orientacao a objetos.
 
    Não precisa implementar, só pensar no nome
 
    Exemplo:
 
    class Animal {
 
        var cor:String
        var peso:Double
        func respirar ()
    }
 
*/


class Animal {
    
    var cor:String = ""
    var peso:Double = 0.0
    var tamanho:String = ""
    
    func respirar() {
        print("Respirando ...")
    }
}

class Cachorro:Animal {
    
    var raca:String
    var castrado:Bool
    var ossosPorKm:Int = 0
    var kmsPercorridos:Int = 0
    
    init(_ raca:String,_ tamanho:String,_ castrado:Bool) {
        
        self.raca = raca
        self.castrado = castrado
    }
    
    func pular() {
        print("🐕")
    }
    
    func correr(kms:Int) {
        kmsPercorridos += kms
    }
    
    func rolar() {}
}

class Gato:Animal {
    
    var raca:String = ""
    var vidasRestantes:Int = 10
    
    func pular() {
        print("🐈")
    }
    
    func correr() {}
    
    
    func dormir() {
        print("💤")
    }

}


