// Autor: Igor 
// Aula: Type Casting


class Funcionario {

    var nome:String
    var salario:Double
    
    init(_ nome:String, salario:Double) {
        self.nome = nome
        self.salario = salario
    }
}

class Senior : Funcionario {
    var PLR:Double = 2.0
}

class Diretor : Senior {
    var bonus:Double = 120_000
}

// as? é um typecasting condicional
// no caso abaixo, retorna 'Diretor' ou 'nil'
// 1) Sendo Diretor, o if let funciona, entra no if
// 2) Sendo nil, o if let falha e desce na execucao

func seráQueÉumDiretor(_ umFuncionario:Funcionario) -> Bool {
    
    if let umDiretor = umFuncionario as? Diretor {
        print("É um diretor, o bonus dele é de \(umDiretor.bonus)")
        return true
    }
    return false
}

let marcao = Diretor("Igor", salario: 25_000)
    seráQueÉumDiretor(marcao)


// Type Casting funciona com Switch

func salárioDeFevereiro(do funcionario: Funcionario) -> Double {
    switch funcionario {
    case let d as Diretor:
        return d.salario + d.PLR * d.salario + d.bonus
    case let s as Senior:
        return s.salario + s.PLR * s.salario
    default:
        return funcionario.salario
    }
}

let situacao = salárioDeFevereiro(do: marcao)
    print("Marcao ta rico, \(situacao)")

