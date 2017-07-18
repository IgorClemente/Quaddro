/*
 
 - Autor: Igor Clemente
 - Data: 16/07/2017
 - Exercicio Error Handling
 
 */

enum FalhaDeEstoque : Error {
    case NenhumFuncionarioPresente
    case AcabaramAsPecas
}

class LinhaDeProducao {
    
    var funcionarios = Array<String>()
    var kitPecasEstoque:Int
    
    init() {
        
        kitPecasEstoque = 0
        funcionarios = []
    }
    
    func iniciarTrabalhos(nomeFuncionario:String) {
        
        funcionarios.append(nomeFuncionario)
    }
    
    func gerarProduto() throws {
        
        guard kitPecasEstoque > 0 else {
            throw FalhaDeEstoque.AcabaramAsPecas
        }
        
        guard !funcionarios.isEmpty else {
            throw FalhaDeEstoque.NenhumFuncionarioPresente
        }
        kitPecasEstoque -= 1
    }
}

let linha = LinhaDeProducao()

func controleEstoque() -> Bool {
    
    do {
        try linha.gerarProduto()
        return true
        
    } catch FalhaDeEstoque.NenhumFuncionarioPresente {
        print("Nao tem nenhum funcionario na empresa.")
        linha.funcionarios.append("Novo Funcionario")
        return controleEstoque()
        
    } catch FalhaDeEstoque.AcabaramAsPecas {
        print("Nao tem pecas no estoque")
        linha.kitPecasEstoque += 10
        return controleEstoque()
    
    } catch {
        print("Erro no estoque !")
        return false
    }
}

