//: Condicionais


let estaChovendo = true

if estaChovendo {
    
   print("É bom levar guarda-chuva")
}

// note: parenteses na condicional é opcional
// a chave é obrigatória
// if de uma unica linha não funciona

// IF - ELSE (SE-SENÃO)
// Todas as condicoes são sempre e somente Boolean
// if 0 { ... 
// if nil { ...

let carroTemCombustível = true

if carroTemCombustível {
    
    print("Segue viagem")
}else{

    print("Melhor abastecer")
}

let farol = "verde"

if farol == "vermelho" {

    print("Pare")

}else if farol == "amarelo" {
   
    print("Atencao")

}else{

    print("Siga")

}

//Mais um exemplo

/*
let temperatura = 23

if temperatura < 10 {

    print("Frio")

}else if temperatura < 20 {
    
    print("Morno")
    
}else{

    print("Quente")
}
  
//Operadores && (e) || (ou)

let somAlto = true
let passouDas10 = true

if somAlto && passouDas10 {
    
    print("Ai vem multa")
}


let moroNumaCasa = true

//AND com negativa

if somAlto && passouDas10 && !moroNumaCasa {
    
   print("Ai vem multa")
}

//OR - Uma ou outra verdadeira

let feriado = true
let ferias = false

if ferias || feriado {

    print("Praia?")
}else{

    print("Bora trabalhar")
}
*/


//Quizz

//Dado:

let número = 7

// 1) é maior que zero ?
// 2) esse número é par

//Dado:

let texto = "Aaah, eu conheco esse lugar! 🗼"

// 3) esse texto tem mais que 3 letras
// 4) esse texto comeca com 'a'?

//1)

if número > 0 {

    print("O número é maior")
}

//2)

if número%2 == 0 {

    print("O número é par")
}else{
    print("O número é impar")
}

//3)

if texto.characters.count > 3 {
    
    print("Ele tem mais que 3 Letras")
}else{
    print("Ele tem menos, \(texto.characters.count) Caracteres")
}

//4)

if texto.lowercased().characters.first == "a" {
    print("Comeca com 'a'")
}else{
    print("Comeca com")
}



//Desafio
//Já posso aposentar no brasil colonial?
//Tempo de contribuicao mínimo: 15 anos
//Idade miníma? é preciso de 65 anos para homem, 60 para mulheres

let éMulher = false // depois: true
let tempoDeContribuicao = 15 //depois: 10, 25
let idade = 65 //depois: 70


if !éMulher && idade >= 65 {
    if tempoDeContribuicao >= 15 {
        print("Pode Aposentar")
    }else{
        print("Não Pode Aposentar")
    }
}else if éMulher && idade >= 60 {
    if tempoDeContribuicao >= 15 {
        print("Pode Aposentar")
    }else{
        print("Não Pode Aposentar")
    }
}else{
    print("Não Atende os requisitos")
}

//Outra solucao

if tempoDeContribuicao >= 15 {
    let idadeMinima = éMulher ? 60 : 65
    if idadeMinima {
        print("N")
    }
}


 
