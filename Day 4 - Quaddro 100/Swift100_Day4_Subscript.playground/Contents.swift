/*
 
 - Day 4 - 100
 
 */

//: Subscript

class Dobrador {
    subscript(valor:Int) -> Int {
        return valor * 2
    }
}

let umDobrador = Dobrador()
    umDobrador[4]


// Mais um exemplo do uso de subscript

typealias Colaborador = (nome:String, setor:String)

class Empresa {
    
    private var colaboradores:[Colaborador] = []
    
    func empregar(_ candidato:Colaborador) {
        colaboradores.append(candidato)
    }
    
    subscript(setorBuscado:String) -> [Colaborador] {
        return colaboradores.filter{ pessoa in
            pessoa.setor == setorBuscado
        }
    }
}

let quaddro = Empresa()
    quaddro.empregar(("Dedé","Professores"))
    quaddro.empregar(("Lino","Professores"))
    quaddro.empregar(("Hemerson","Atendimento"))
print(quaddro["Professores"])


/*
 
    - Exercicios
    - Enderecos
 
*/

class Endereco {

    let nome:String
    let rua:String
    let numero:Int
    
    init(nome:String, rua:String, numero:Int) {
        self.nome = nome
        self.rua = rua
        self.numero = numero
    }
}

class Mapa {

    var enderecos:[Endereco] = []
    
    func incluirEndereco(_ novoEndereco:Endereco) {
        enderecos.append(novoEndereco)
    }
    
    //Buscamos um endereco pela rua e número
    
    subscript(_ rua:String,_ numero:Int) -> String {
        get {
            for endereco in enderecos {
                if endereco.rua == rua && endereco.numero == numero {
                    return endereco.nome
                }
            }
            return "Não Encontrado"
        }
        set {
            let novoEndereco = Endereco(nome:newValue, rua:rua, numero:numero)
            incluirEndereco(novoEndereco)
        }
    }
    
    subscript(_ rua:String) -> [Endereco] {
        return enderecos.filter{ logradouro in
            logradouro.rua == rua
        }
    }
}


let novoMapa = Mapa()

/*
novoMapa.incluirEndereco(Endereco(nome:"Casa",rua:"Durval Fontoura Castro",numero:40))
novoMapa.incluirEndereco(Endereco(nome:"Qualquer lugar",rua:"Lugar Nenhum",numero:0))
novoMapa.incluirEndereco(Endereco(nome:"Outro Lugar",rua:"Lugar Nenhum",numero:80))

novoMapa["Lugar Nenhum",0]
novoMapa["Lugar Nenhum",90] = "Masp"
*/

novoMapa["Durval Fontoura Castro",40] = "Casa"
novoMapa["Lugar Nenhum",0] = "Qualquer lugar"
novoMapa["Outro lugar",80] = "Outro lugar"

//Quizz

/*
 
 1) Faca um subscript para Mapa que receba o nome da Rua e retorne todos os enderecos dessa rua num vetor
 2) Subscripts podem também escrever!
 vetor[0] -> Retorna primeiro
 vetor[0] = 'abc' -> Escreve no vetor

 Altere o subscript que recebe rua e numero para também adicionar enderecos
 
 - Dica
 
 subscript(rua:String,numero:Int) -> String {
    
    get {
 
    }
 
    set {
 
    }
 
 }
 */



