/*
 
 - Revisando Classes
 - 07/07/2017
 - Autor: Igor Clemente
 
 */


class Person{

    var nome:String
    private var idade:Int
    
    init(_ nome:String,_ idade:Int) {
        
        self.nome = nome
        self.idade = idade
    }
    
    func alterarIdade(novaIdade:Int) -> Void {
        idade = novaIdade
    }

    func exibirNome() -> Int {
        return idade
    }
}