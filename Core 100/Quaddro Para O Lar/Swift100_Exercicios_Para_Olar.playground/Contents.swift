/*
 
 - Autor: Igor Clemente
 - Exercicios para o lar
 
 */


// 1 - a


class Brinquedo {

    func mover() -> Void {
        print("Movendoo...")
    }
}


class Carro:Brinquedo {
    
    override func mover() -> Void {
        print("Correnddoo...")
    }
}

class Barco:Brinquedo {

    override func mover() -> Void {
        print("Vrummmmm...")
    }
}

class Aviao:Brinquedo {
    
    override func mover() -> Void {
        print("Teco teco teco ...")
    }
}


let meuAviao = Aviao()
    meuAviao.mover()
let meuCarro = Carro()
    meuCarro.mover()
let meuBarco = Barco()
    meuBarco.mover()


// 1 - b


class controleRemoto {

    let brinquedo:Brinquedo
    
    init(para brinquedo:Brinquedo) {
        self.brinquedo = brinquedo
    }
    
    func acionar() -> Void {
        brinquedo.mover()
    }
}

let meuControle = controleRemoto(para:meuAviao)
    meuControle.acionar()



/*
 
 - Desafio de Carnaval
 
 */

import Darwin

enum Criterio {

    case bateria
    case evolucao
    case enredo
    case alegorias
}

class EscolaDeSamba {
    
    private var nome:String = " "
    var notas:[Criterio:[Float?]] = [.alegorias:[],.bateria:[],.enredo:[],.evolucao:[]]
    
    init(_ nome:String) {
        self.nome = nome
    }
    
    func mediaParaCriterio(criterioAvaliado:Criterio) -> Float {
        
        var quantidadeNotas:Int? = nil
        var media:Float = 0.0
        var maiorNota:Float = 0.0
        var menorNota:Float = 0.0
        
        for (criterio,notas) in notas {
            if criterio == criterioAvaliado {
                var contador:Int = 0
                notas.forEach {
                    if let n = $0 {
                        contador += 1
                        media += n
                        maiorNota = max(n,maiorNota)
                        menorNota = min(n,menorNota)
                    }
                }
                quantidadeNotas = (contador != 0) ? contador : quantidadeNotas
                media -= menorNota
            }
        }
        
        if let q = quantidadeNotas {
            if q == 4 {
                return media/4
            }else {
                media += maiorNota
                return media/4
            }
        }else{
            return 10.0
        }
    }
    
    func mediaFinal() -> Float {
        var mediaFinal:Float = 0.0
        var contador:Int = 0
        
        for (criterio,_) in notas {
            mediaFinal += mediaParaCriterio(criterioAvaliado: criterio)
            contador += 1
        }
        return mediaFinal/Float(contador)
    }
    
    func pegarNome() -> String {
        return nome
    }
}


    
 let novaEscola = EscolaDeSamba("Escola de Teste Maximo")
 novaEscola.notas[.alegorias] = [8,6,8,nil]
 novaEscola.mediaParaCriterio(criterioAvaliado: .alegorias)


class Jurados {

    func atribuirNotas(Para escola:EscolaDeSamba) -> Void {
        for (criterio,_) in escola.notas {
            for _ in 1...4 {
                let rand = Float(arc4random_uniform(5)+5)
                escola.notas[criterio]?.append(rand)
            }
        }
    }
}


class Carnaval {

    var escolas:[EscolaDeSamba]
    var jurados:Jurados
    
    init(_ escolas:[EscolaDeSamba],_ jurados:Jurados) {
        self.escolas = escolas
        self.jurados = jurados
    }
    
    func apurar() -> Void {
        for (_,escola) in escolas.enumerated() {
            jurados.atribuirNotas(Para: escola)
        }
    }
    
    func vencedora() -> String? {
    
        var melhorEscola:String? = nil
        var melhorNota:Float = 0.0
        
        escolas.forEach {
            melhorNota = max($0.mediaFinal(),melhorNota)
            melhorEscola = (melhorNota == $0.mediaFinal()) ? $0.pegarNome() : melhorEscola
        }
        return melhorEscola
    }
}

let meuCarnaval = Carnaval([EscolaDeSamba("Unidos da Tijuca"),EscolaDeSamba("Sempre unidos"),EscolaDeSamba("Outra escola")],Jurados())
    meuCarnaval.apurar()
    meuCarnaval.vencedora()


// Desafio Carnaval -> https://pastebin.com/9TAr5VK8    
// Solucao LINO

// Para o Scopo da funcao que tem menos de 10 linhas é interessante abreviar os nomes dos parametros

// Desafio Controle Remoto -> https://pastebin.com/pkQEPrBE
