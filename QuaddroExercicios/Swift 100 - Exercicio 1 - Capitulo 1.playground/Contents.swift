//Exercicio 1 - Capitulo 1

/* A */

var (a,b) = (12,12)

if a != b {
    print("Os dois sao diferentes \(a != b)")

}else{
    print("Os dois sao iguais \(a != b)")
}

/* B */

var pessoas:[String] = ["igor","joao","carlos","ana"]

/* C */

typealias Carro = (marca: String,modelo: String,valor: Double)
var veiculo:Carro = ("Fiat","Sedan",34.900)
    veiculo.marca
    veiculo.modelo
    veiculo.valor

var veiculo2:(marca: String, modelo: String, valor: Double) = ("Volks","Ratch",45.900)
    veiculo2.marca
    veiculo2.modelo
    veiculo2.valor


/* D */

var nomeCompleto:String = "IgorClemente"
    print(nomeCompleto)

/* E */

var quaddro:String = "quaddroTreinamentos"
    print(quaddro)