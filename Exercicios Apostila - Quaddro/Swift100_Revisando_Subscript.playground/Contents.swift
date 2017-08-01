/*
 
 - Autor: Igor Clemente
 - Data: 06/07/2017
 
 */



class Endereco{

    let nome:String
    let logradouro:String
    let numero:Int
    
    init(nome:String,logradouro:String,numero:Int){
        
        self.nome = nome
        self.logradouro = logradouro
        self.numero = numero
    }
}


class Mapa{
    
    var enderecos:[Endereco] = []
    
    func incluirEndereco(_ novoEndereco:Endereco) {
        enderecos.append(novoEndereco)
    }
    
    subscript(_ rua:String,_ numero:Int) -> String {
        
        get {
            for endereco in enderecos {
                if endereco.logradouro == rua && endereco.numero == numero{
                    return endereco.nome
                }
            }
            return "Endereco Nao Encontrado!"
        }
        
        set {
            let novoEndereco = Endereco(nome:newValue,logradouro:rua,numero:numero)
            incluirEndereco(novoEndereco)
        }
    }
    
    subscript(_ rua:String) -> [Endereco] {
        return enderecos.filter { endereco in
            endereco.logradouro == rua
        }
    }
}


let novoMapa = Mapa()
    novoMapa["Rua Durval Fontoura",40] = "Minha Casa"
    novoMapa["Rua Durval Fontoura",67] = "Casa Joana"
    novoMapa["Rua Durval Fontoura"]


/*
 
 - Empresa - Subscript
 
 */


typealias Colaborador = (nome:String,setor:String)

class Empresa{

    private var colaboradores:[Colaborador] = []
    
    func empregarFuncionario(_ funcionario:Colaborador) {
        colaboradores.append(funcionario)
    }

    subscript(_ setor:String) -> [Colaborador] {
        return colaboradores.filter { colaborador in
            colaborador.setor == setor
        }
    }
}

let novaEmpresa = Empresa()
novaEmpresa.empregarFuncionario(("Igor Clemente","Suporte TI"))
novaEmpresa.empregarFuncionario(("Joana Texeira","Suporte TI"))
novaEmpresa.empregarFuncionario(("Thiago Henrique","Pagamento Financeiro"))
novaEmpresa["Suporte TI"] 
novaEmpresa["Pagamento Financeiro"]


import Darwin

class dobrarNumero{

    subscript(_ valor:Int) -> Int {
        return valor*2
    }
}

let dobrar = dobrarNumero()
    dobrar[4]
