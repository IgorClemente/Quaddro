/*
 
 - Structs
 - São bem semelhantes a classes, mas representam de maneira mais simples estruturas menos complexas (não há heranca)
 - Tem init automático
 
*/


struct Coordenadas {
    
    var latitude:Float
    var longitude:Float
}

let brasilia = Coordenadas(latitude: -15.79, longitude: -47.86)


struct Retangulo {
    
    var largura:Int
    var altura:Int
    
    func área() -> Int {
        return largura * altura
    }
}

let quadrado = Retangulo(largura: 4, altura: 4)
    quadrado.área()

struct  Contador {

    var valor:Int = 0
    mutating func incrementa() {
        valor += 1
    }
}

var meuContador = Contador()

for _ in 1...10 {
    meuContador.incrementa()
}

meuContador.valor

/*
 
 - Diferente de um objeto de uma classe, um struct LET não pode alterar nenhum de seus valores, por mais que eles sejam VAR
 - Observacao

*/


/*
 
 Quick Fix 
 
 - 1) Crue uma struct Círculo, que contenha raio e uma funcao que retorna a area

 - 2) Cria uma struct Cadastro, com nome, cpf, data de nascimento e calcule a idade por meio de uma func (assumindo que estamos em 2017)
 
*/


import Darwin

struct Circulo {

    var raio:Double
    
    func area() -> Double {
        return 2*3.14*pow(raio, 2)
    }
}

var novoCirculo = Circulo(raio: 4)
    novoCirculo.area()


struct Cadastro {

    var nome:String
    var cpf:Int
    var dataNascimento:Int
    
    func calcula() -> Int {
        return 2017-dataNascimento
    }
}

var novoCadastro = Cadastro(nome:"Igor Clemente",cpf:456978543,dataNascimento:1997)
    novoCadastro.calcula()