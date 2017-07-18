//:ARC


class Inquilino {
    
    var nome:String
    var moraEm:Apartamento?

    init(nome n:String){
        nome = n
    }
}

class Apartamento {
   weak var morador:Inquilino?
}


func ocuparPorTemporada(apto:Apartamento) {
    let bob:Inquilino? = Inquilino(nome: "Bob")
    apto.morador = bob
    bob?.moraEm = apto
    
    apto.morador?.nome
    bob?.moraEm?.morador?.moraEm?.morador?.nome
    
    // bob deixa de existir aqui : '7'
    // tchau, bob, vai embora !!
}

let apto12 = Apartamento()
    ocuparPorTemporada(apto: apto12)
    apto12.morador?.nome