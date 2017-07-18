//:Extensions

//Extensions são maneiras de incluir funcionalidades em classes, structs que já existem, principalmente as do sistema


extension String {

    func sóVogais() -> String {
        let vogais = ["a","e","i","o","u"]
        let resposta = self.characters.filter {
            return vogais.contains(String($0))
        }
        return String(resposta)
    }
}

"Nossa!".sóVogais()


//Outro exemplo:
// Faca uma extension de Int que adicione a funcao repita,
// essa funcao recebe uma closure ()->() e repete esse
// codigo o mesmo número de vezes que a própria variável
// Int


// Exemplo:
// 3.repita { print "Hello!" }
// terminal:
// Hello!
// Hello!
// Hello!


extension Int {
    func repita(codigo:()->()) -> Void {
        for _ in 1...self {
            codigo()
        }
    }
}

3.repita(codigo: { print("Hello!") })

4.repita {
    print("Oláaaaaaaa")
}


// Extensions + Protocols

protocol DaqueleOnOff {
    var ligado:Bool { get set }
}

extension DaqueleOnOff {
    mutating func desliga(){
        ligado = false
    }
    
    mutating func ligar(){
        ligado = true
    }
    
    mutating func apertaBotaoOnOff(){
        ligado = !ligado
    }
}

class AspiradorDePo: DaqueleOnOff {
    var ligado = false
}

var meuAspirador = AspiradorDePo()
    meuAspirador.ligar()
    meuAspirador.ligado


