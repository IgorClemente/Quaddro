//: Optionals

// Vamos utilizar optionals em situacoes onde um valor pode estar ausente. Um optional diz:

// A) Existe um valor, e ele é igual a x
// OU
// B) Não existe valor nenhum, no geral

// Veja que 0 é um valor, -1 também
// Estes números eram utilizados antigamente para marcar
// Valores inválidos, não temos mais que fazer isso em Swift


class Time {

    let nome:String
    var gols:Int
    var golsNosPenalties:Int?      //Marcador de Optional   - Pode Existir um Int ou nil
    
    init(nome:String) {
        self.nome = nome
        self.gols = 0
        self.golsNosPenalties = nil
    }
}

let mengao = Time(nome: "Flamengo")
    mengao.golsNosPenalties
    mengao.golsNosPenalties = 1
    mengao.golsNosPenalties


// Estruturas para lidar com optionals
// IF LET
// O que ele faz ? verifica se um optional tem valor e, se sim, já desempacota o optional em uma nova constante/variável desempacota nos usa é chamado de 'unwrap'

if let seTevePenaltisFoi = mengao.golsNosPenalties {
    print("Nossam Teve! foi: \(seTevePenaltisFoi)")
}else{
    print("Não teve!")
}


// > GUARD LET
// o que ele faz ? Ele 'garante'. Usado quando precisamos garantir que um optional tem valor antes de continuar a execucao do código

let vasco = Time(nome: "Vasco")

func quemGanhouNosPenalties(_ a:Time,_ b:Time) -> Time? {
    guard let golsPenaltiesA = a.golsNosPenalties,
        let golsPenaltiesB = b.golsNosPenalties else {
            print("Não teve penalties")
            return nil
    }
    
    if golsPenaltiesA == golsPenaltiesB {
        return nil
    }
    
    if golsPenaltiesA > golsPenaltiesB {
            return a
    }else{
            return b
    }
}

//Optional Chaining

quemGanhouNosPenalties(mengao, mengao)?.nome

// Mesmo nome não sendo optional na classe Time,
// o retorno da funcao é optional! Isso faz com que a 
// chama .nome sej  convertida para optional também
// chamamos isso de 'optional chaining'


//GIZZ

// 1) Crie uma struct Almoco, contendo:
// * prato:String
// * sobremesa:String?
// 2) Agora nela crie uma funcao com o print da descricao
//    a) o almoco foi feijoada, com pudim de sobremesa
//          ou
//    b) o almoco foi feijoada, sem sobremesa
// Para isso crie duas variáveis de almoco, 
// uma com e uma sem sobremesa


struct Almoco {
    
    var prato:String
    var sobremesa:String?

    func descricao()->String {
        if let s = sobremesa {
            return "O almoco foi \(prato), com \(s) de sobremesa"
        }else{
            return "O almoco foi \(prato), sem sobremesa"
        }
    }
}
let refeicao = Almoco(prato:"Feijoada",sobremesa:"Pudim")


func menorValor(De vetor:[Int])->Int? {
    
    guard vetor.isEmpty == false else{
        return nil
    }
    return vetor.reduce(vetor[0]){ min($0,$1) }
}


// Dois Detalhes !

// Coalescencia: podemos rapidamente optar por outro valor no caso de um optional estar nulo

var optional:String? = "Pizza"

// diferente de: var optional:String = "Pizza"
// o segundo não pode receber nil nunca

print("O valor é", optional ?? "desconhecido")


// VEJA:

optional = nil
print("O valor é",optional ?? "desconhecido")

//Force unwrap! (do mal, morte à frente)
// Utilizando para forcar o desempacotamento


let idade:Int?
idade = 30
print("Minha idade é \(idade)")

// Cuidado se não houver causa um crash na mão do usuário


// PARAOLAR: pastebin.com/1C47nkvJ
// ALZOPARAOLAR: pastebin.com/tnWB1GUT
