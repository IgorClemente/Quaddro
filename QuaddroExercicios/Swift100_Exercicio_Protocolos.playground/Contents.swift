/*
 
 - Autor: Igor Clemente
 - Data: 17/07/2017
 - Exercicio de Protocolos
 
 */


// - Protocols -
// Faça um protocolo Comestível, que tenha
// uma 'constante' gosto do tipo enum: Amargo, Doce, Salgado
// Agora modele as classes: Brigadeiro, Pastel e Giló


enum Gosto {
    
    case amargo
    case doce
    case salgado
}


protocol Comestivel {

    var gosto:Gosto { get }
}


class Brigadeiro : Comestivel {

    let gosto: Gosto
    
    init(_ gosto:Gosto) {
        self.gosto = gosto
    }
}

class Pastel : Comestivel {
    
    let gosto: Gosto
    
    init(_ gosto:Gosto) {
        self.gosto = gosto
    }
}

class Gilo : Comestivel {
    
    let gosto: Gosto
    
    init(_ gosto:Gosto) {
        self.gosto = gosto
    }
}


let umPastel = Pastel(.salgado)
    umPastel.gosto
let umBrigadeiro = Brigadeiro(.doce)
    umBrigadeiro.gosto
let umGilo = Gilo(.amargo)
    umGilo.gosto