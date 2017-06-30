//: Functions


/*
 
func <nome>([nomeParam:Tipo], ...)[-> Tipo]{
    <corpo>
}
*/

func falarBomDia(){
    print("Bom dia")
}
//Sem paramentro, sem retorno
falarBomDia()

func falarBomDia(nome: String){
    print("Bom dia, seu \(nome)")
}
//Com parametro, sem retorno
falarBomDia(nome: "João")


//Terceiro: Com paraemtro e retorno

func boaNoite(nome: String) -> String {
    return "Bom noite, \(nome) 🤡"
}

let mensagem = boaNoite(nome: "Tatiana")
print(mensagem)

//Funcao so com retorno

func diaDoBanho() -> String{
    return "Sábado"
}

diaDoBanho()
print("Sempre tomo banho \(diaDoBanho())")


//:Wizz

//1) Faca uma funcao que print 'Oi' por um determinado numero de vezes, ou seja, essa funcao recebe um Int chamado 'vezes' de parametro
// ex. de uso: repitaOi(vezes:3)

//2) Faca uma funcao que retorna true ou false se um nome é bem grande (maior que 6 letras)
// ex. de uso: éUmNomeGrande("Lino")


func repitaOi(vezes: Int){
    for _ in 0..<vezes{
        print("Oi")
    }
}
repitaOi(vezes: 4)

func éUmNomeGrande(nome: String) -> Bool{
    if nome.characters.count > 6{
        return true
    }else{
        return false
    }
}

let isGrande = éUmNomeGrande(nome: "igor") ? "Grande" : "Pequeno"
print("O nome é: \(isGrande)")


// Funcão com multiplos parametros

func avaliar(metros:Int, vagas:Int, lazer:Bool) -> Int{
    
    var valor = 8000*metros
    valor += vagas*5000
    valor += lazer ? 15000 : 0
    return valor
}
avaliar(metros: 30, vagas: 0, lazer: false)


//Funcoes com multiplos retornos
//Ele retorna uma tupla

func erroParaPáginaNãoEncontrada() -> (code:Int, status:String){
    return (404,"Not Found")
}
erroParaPáginaNãoEncontrada().code
erroParaPáginaNãoEncontrada().status


// :Quiz
// Faca uma funcao que diz se um dado nome é maior que um dado sobrenome. Ou seja, receber 'nome' e 'sobrenome' de parametro.
// Retornar TRUE se o nome é maior que sobrenome
// Aproveite para pensar no melhor e mais descritivo nome para a funcao

// :Importante [ nomeParaFora nomeParaDentro: tipo ]

func comparaTamanhoNomeSobrenome(_ nome:String, _ sobrenome:String) -> Bool{
    let tamanhoNome = nome.characters.count
    let tamanhoSobrenome = sobrenome.characters.count
    
    if tamanhoNome > tamanhoSobrenome{
        return true
    }else{
        return false
    }
}
comparaTamanhoNomeSobrenome("Igor","Clemente") ? print("Nome é maior") : print("Nome é menor")


// :Importante [ nomeParaFora nomeParaDentro: tipo ]
/* Outro Exemplo


func temMaisLetras(nome:String, doQueNoSobrenome sobrenome:String) -> Bool{
    return nome.characters.count > sobrenome.characters.count
}

temMaisLetras(nome:"Igor",doQueNoSobrenome:"Clemente")
*/

// Nomeando os parametros da funcao

func duplicar(numero n:Int) -> Int{
    return n*2
}
duplicar(numero: 4)

//Removendo nome dos Parametros
// [_NomeParaDentro:Tipo] (_ Descarta o nome para fora)

func multiplicar(_ a:Int, _ b:Int) -> Int{
    return a*b
}
multiplicar(3,8)

//Parametros com valor padrão
// Algumas funcoes recebem parametros, mas existe um valor comum padronizado

func contagemRegressiva(comecandoDe valor:Int = 5){
    for numero in Array(1...valor).reversed(){
        print(numero)
    }
}

contagemRegressiva()
contagemRegressiva(comecandoDe: 3)

// Faca uma funcao que receba um nome String e um Int de parametro
// Chamado 'Vezes'. Na funcao, chamada 'aplaudir', faca print do
// texto "👏 \(nome)" este numero de vezes. Depois defina o valor
// padrão de vezes para 3.

// Default: numero = 3

func aplaudir(nome:String, Vezes numero:Int = 3){
    for _ in 0..<numero{
        print("👏 \(nome)")
    }
}
aplaudir(nome: "Igor Clemente", Vezes: 5)
aplaudir(nome: "Joana")


