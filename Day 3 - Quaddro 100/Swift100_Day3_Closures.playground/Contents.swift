//:Closures [moderno]

// No Swift funcoes podem ser atribuidas a variaveis e constantes. Depois disso, podemos usar esse variavel closure para envia-la a metodos, incluir em vetor, tupla etc

let faladorDeOi = {
    
    print("Oi")
}

faladorDeOi()

// Exemplo de closure, sem 'param', com tipagem

let faladorDeHoraDoAlmoco:()->() = {
    
    print("Hora do Almoco!! 🍔")
}
faladorDeHoraDoAlmoco()
faladorDeHoraDoAlmoco()

// Closure recebendo parametro e retorno
// Uma CLOSURE que recebe String e retorna String
// O tipo funciona assim: (String)->(String) - Sendo "()"
// quem: É o parametro, (String)->String é tipo do(s) parametros

let criadorDeBoaTarde:(String)->String = { quem in
    
    return "Boa tarde, \(quem)"
}

let saudacao = criadorDeBoaTarde("Igor")

// Caso o 'in' nao exista ele coloca $0 e $1 implicito
// Obs: Caso tenha apenas uma linha, não necessita nomear e o return é implicito
// O return pode ser omitido

let soma:(Int,Int)->Int = { a , b in
    
    return a + b
}
print(soma(4,8))


// É possivel que recebe CLOSURE

let saudarNome:(String)->() = { nome in
    print("\(nome)")
}

func saudacao(ParaosNomes nomes:[String],fazer saudarNome:(String)->()){
    for nome in nomes{
        saudarNome(nome)
    }
}
saudacao(ParaosNomes:["Igor","Joana","João"],fazer:saudarNome)

// Quando o ultimo parametro de uma funcao é um closure, 
// Podemos extrair o trecho de código para fora

saudacao(ParaosNomes:["Jose","Carlos","Thiago"]){
    print("\($0)")
}


//Podemos passar tuplas de parametro para closure

typealias Pedido = (codigo:Int, quantidade:Int)

let requisicao:(Pedido)->Void = { p in

    print("Pedido para \(p.quantidade) itens")
}

let meuPedido:Pedido = (25, 2)
requisicao(meuPedido)


// Quiz

// Já fizemos uma closure soma, que recebe dois Int e retorna Int
// Faca agora as CLOSURES subtrai e multipla.
// Em seguida uma func executa, que recebe dois Int e um operacão
// Exemplo de uso: executa(10, 3, soma)
// Outro exemplo: executa(4, 2, multiplica)


let subtrai:(Int,Int)->Int = { a, b in
    return a-b
}

let multiplica:(Int,Int)->Int = { a, b in
    return a*b
}

func executa(_ primeiroNumero:Int,_ segundoNumero:Int,facaOperacao operacao:(Int,Int)->Int){
    print(operacao(primeiroNumero,segundoNumero))
}

executa(654,45,facaOperacao: subtrai)


// Outro: Implemente duas CLOSURES que recebem e retorna Strings:
// sóVogais, sóMaiusculas

// HARD: criar uma funcao alterarString que recebe uma vetor de closures
// e opera com cada uma delas na STRING
// uso: alteraString("Minha Nossa, Uia! O QUE?", [sóVogais, sóMaiuculas])
// print: MNUOQUE

let sóVogais:(String)->String = { texto in
    
    var vogais = String()
    
    for letra in Array(texto.characters){
        switch letra {
    
        case "a","e","i","o","u":
            vogais += String(letra)
        
        default:
            break
        }
    }
    return vogais
}

let sóMaiusculas:(String)->String = { texto in
    
    var maiusculas = String()
    let letrasMaiusculas = Array(texto.characters).filter{
        !($0 == Character(String($0).lowercased()))
    }
    
    letrasMaiusculas.forEach{
        maiusculas += String($0)
    }
    return maiusculas
}

func alteraString(_ texto:String, executaOperacoes operacoes:[(String)->String])->Void{
    for operacao in operacoes{
        print(operacao(texto))
    }
}

alteraString("Minha Nossa, Uia! O QUE?",executaOperacoes: [sóVogais])
alteraString("Minha Nossa, Uia! O QUE?",executaOperacoes: [sóVogais,sóMaiusculas])


// Outra solucao é utilizar o contains para verificar se existe o CHARACTER
// na STRING  Exemplo: "aeiou".characters.contains(letra)


