/*
 
 - Autor: Igor Clemente 
 - Aula: TypeCasting
 - Aula 5 - 100
 
 */


class Pessoa {

    private var nome:String
    private var idade:Int
    private var altura:Float
    
    init(_ nome:String,_ idade:Int,_ altura:Float) {
    
        self.nome = nome
        self.idade = idade
        self.altura = altura
    
    }
    
    func setNome(_ nome:String) -> Void {
        self.nome = nome
    }
    
    func getNome() -> String {
        return nome
    }
    
    func setIdade(_ idade:Int) -> Void {
        self.idade = idade
    }
    
    func getIdade() -> Int {
        return idade
    }
    
    func setAltura(_ altura:Float) -> Void {
        self.altura = altura
    }
    
    func getAltura() -> Float {
        return altura
    }
}



class PessoaFisica : Pessoa {

    private var cpf:Int
    private var rg:Int
    
    init(_ nome:String,_ idade:Int,_ altura:Float,_ cpf:Int,_ rg:Int) {
        
        self.cpf = cpf
        self.rg = rg
        super.init(nome,idade,altura)
    }
    
    func setCpf(_ cpf:Int) -> Void {
        self.cpf = cpf
    }
    
    func getCpf() -> Int {
        return cpf
    }
    
    func setRg(_ rg:Int) -> Void {
        self.rg = rg
    }
    
    func getRg() -> Int {
        return rg
    }
}


class PessoaJuridica : Pessoa {
    
    private var cnpj:String
    
    init(_ cnpj:String,_ nome:String,_ idade:Int,_ altura:Float) {
        
        self.cnpj = cnpj
        super.init(nome,idade,altura)
        
    }
    
    func setCnpj(_ cnpj:String) -> Void {
        self.cnpj = cnpj
    }
    
    func getCnpj() -> String {
        return cnpj
    }
}


class Diretor : PessoaJuridica {

    private var bonus:Int = 9000
    
    override init(_ cnpj:String,_ nome:String,_ idade:Int,_ altura:Float) {
        
        super.init(cnpj,nome,idade,altura)
    }
}


func ePessoa(_ pessoa:Pessoa) -> Bool {
    
    if let person = pessoa as? PessoaFisica {
        print("E uma pessoa sim \(person.getNome())")
        return true
    }
    return false
}


let novoDiretor = Diretor("3444555","Igor Clemente dos Santos",20,1.87)
    ePessoa(novoDiretor)

/*
 
 - Exemplo Type Casting - Apostila
 
 */


//Superclasse Funcao

class Funcao {
    var nome : String
    
    init(umNome : String){
        self.nome = umNome
    }
}

//Subclasse Engenheiro baseada em Funcao

class Engenheiro: Funcao {
    var area : String
    
    init(umNome:String, umaArea:String){
        self.area = umaArea
        super.init(umNome: umNome)
    }
}

//Subclasse Arquiteto baseada em Funcao

class Arquiteto: Funcao {
    var ramo : String
    
    init(umNome:String, umRamo:String){
        self.ramo = umRamo
        super.init(umNome: umNome)
    }
}

//Instancias Engenheiros e Arquitetos em um Array:

let todasFuncoes = [

    Engenheiro(umNome: "Joao", umaArea: "Civil"),
    Engenheiro(umNome: "Jose", umaArea: "Eletrica"),
    Engenheiro(umNome: "Mario", umaArea: "Hidraulica"),
    Arquiteto(umNome: "Oscar", umRamo: "Concreto"),
    Arquiteto(umNome: "Santiago", umRamo: "Metalica"),
    Arquiteto(umNome: "Vilanova", umRamo: "Espacos"),
    Engenheiro(umNome: "Clemente", umaArea: "Eletronica")

]

//Controles para checagem de tipo

var quantidadeEngenheiros = 0
var quantidadeArquitetos = 0

//Acrescentando elementos aos controles de checagem

for profissional in todasFuncoes {
    if profissional is Arquiteto {
        quantidadeArquitetos += 1
    }
    
    if profissional is Engenheiro {
        quantidadeEngenheiros += 1
    }
}

//Impressao dos resultados em console

print("Numero de Engenheiros. : \(quantidadeEngenheiros)")
print("Numero de Arquitetos. : \(quantidadeArquitetos)")





