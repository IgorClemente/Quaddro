//: Switch

let numero = 100

switch numero {

case 1:
    print("Número 1")
    //Não tem Break !
    
case 2:
    print("Número 2")
    
case 3:
    
    fallthrough  //*

case 4:
    print("Fall")
 
case 10..<30:
    print("Número entre 10 e 30, 30 não incluso")
    
case 30 ... 100:
    print("Número entre 30 e 100, com 30 e 100 inclusos")
    
default:
    print("Nenhum dos Números")
}


//Quiz
//Faca um Switch que diga se uma
//Variável é vogal

let letra:Character = "a"

switch letra {

case "a","e","i","o","u":
    print("Sim, é uma vogal")
    
default:
    print("Não é uma vogal")
}


//Switch em tuplas

let ponto = (x: -2,y: 0)

switch ponto {

case(0,0):
    print("Estou na origem")
    
case(0,_):
    print("Estou no eixo Y")
    
case(_,0):
    print("Estou no eixo X")

case(-2...2, -2...2):
    print("Ué?, é uma quadrado !")
    
default:
    print("Fora da Area")
}



//Validacao de Tipo de Objeto

let valor:Any = "Texto, Teste, Texto"


// Any Significa: qualquer coisa, não sei
// Prejuizo: perde todos os métodos do tipo
// Exemplo: isso não funciona -> valor.lowercased()


switch valor {

case let s as String:
    print("Ahh, mano é um texto !!! Olha: \(s)")
default:
    print("Não sei lidar com isso 😧")
}


//Where ?

let dinheiros:Any = 10.0

switch dinheiros {
    
case let d as Double where d > 100.0:
    print("Temos muito Dinheiro 😏")
    
case let d as Double where d >= 0:
    print("Quase sem Dinheiro 😱")
    
case let d as Double where d < 0:
    print("Eita, estamos no vermelho! 📉")

default:
    print("Não vamos falar de dinheiro ")
}




