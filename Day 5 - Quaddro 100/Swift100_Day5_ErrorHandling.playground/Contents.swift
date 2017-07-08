//: No Swift temos estruturas para permitir o 
// tratamento de erros em tempo de execucao


enum FalhaNaImpressao : Error {
    case faltouPapel
    case faltouTinta
}


class Impressora {

    var quantidadeDePapel:Int = 0
    var nivelDaTinta:Double   = 0.0
    
    // 'throws' significa que a funcao pode dar errado
    // um erro pode ser gerado, ela 'dispara' um erro
    func imprimir(_ texto:String) throws {
        
        guard quantidadeDePapel > 0 else {
            throw FalhaNaImpressao.faltouTinta
        }
        
        guard nivelDaTinta > 0.0 else {
            throw FalhaNaImpressao.faltouPapel
        }
        
        print("Imprimindo... \(texto)")
        quantidadeDePapel -= 1
        nivelDaTinta -= 0.1
    }
}


let EPSON = Impressora()
/*
 
func tentaImprimir(_ texto:String) -> Bool {
    // Aqui vamos chamar a funcao imprimir que dispara erros
    // dentro de um ambiente controlado:
    do{
        try EPSON.imprimir(texto)
        return true
        
    } catch FalhaNaImpressao.faltouPapel {
        print("Precisava de papel!! Orra")
        EPSON.quantidadeDePapel += 10
        return tentaImprimir(texto)
        
    } catch FalhaNaImpressao.faltouTinta {
        print("Agora está sem tinta")
        EPSON.nivelDaTinta += 1.0
        return tentaImprimir(texto)
        
    } catch {
        print("Erro ao imprimir ! 😏")
        return fa
    }
}

tentaImprimir("Hello Worlds")
 
*/



// Podemos utilizar try? para receber valores de funcoes com throws. Nesse caso,
// se exceptions forem geradas voce recebe um nil


enum MathematicalError : Error {
    case DividindoPorZero
}

func divide(_ a:Int,_ b:Int) throws -> Int {
    
    guard b != 0 else {
        throw MathematicalError.DividindoPorZero
    }
    return  a/b
}

let divisao = try? divide(10,5)