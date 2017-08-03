/*
 
 - Autor: Igor Clemente dos Santos
 - Data: 02 de Agosto de 2017
 - Revisando: Dicionários,
 - Condicionais, Controle de Fluxo
 
 */

//: Dicionários

var cidadesAeroportos = [String : String]()
    cidadesAeroportos["GRU"] = "Guarulhos"
    cidadesAeroportos["SAO"] = "São Paulo"
    cidadesAeroportos["GYN"] = "Goiania"

for (sigla,cidade) in cidadesAeroportos {
    print("A cidade \(sigla) refere-se a cidade \(cidade)")
}

cidadesAeroportos.forEach { (sigla,cidade) in
    print("Podemos imprimir através de um closure com a sigla \(sigla) e a cidade\(cidade)")
}

cidadesAeroportos["BBU"] = "Bauru"
cidadesAeroportos["CGH"] = "Congonhas"
cidadesAeroportos["RAO"] = "Ribeirão Preto"

cidadesAeroportos.forEach {
    print("Sigla \($0) e Cidade \($1)")
}

typealias Diretor = (nome:String, segmento:String)
typealias Descricao = (diretor:Diretor,ano:Int,nota:Int)

var filmes = Dictionary<String,Descricao>()
    filmes["O Hobbit"] = (("Peter Jackson","Aventura e Ficção"),2014,10)
    filmes.forEach { nome, descricao in
        print("Filme: \(nome), feito pelo Diretor: \(descricao.diretor.nome)")
    }

filmes["O Hobbit"]?.ano  //Retorna valores das chaves do Dicionários


var placasRodizio:[String:String] = [:]
    placasRodizio["SEG"] = "1 e 2"
    placasRodizio["TER"] = "3 e 4"
    placasRodizio["QUA"] = "5 e 6"
    placasRodizio["QUI"] = "7 e 8"
    placasRodizio["SEX"] = "9 e 0"

placasRodizio.forEach {
    print("No dia \($0) é permitido os veiculos com final de placa \($1)")
}

print("\(Array(placasRodizio.values))")
print("\(Array(placasRodizio.keys))")

placasRodizio["SEG"] = nil
placasRodizio.removeValue(forKey:"TER")

for (dia,placa) in placasRodizio {
    print(dia + " " + placa)
}
"QUA".hashValue



/*
 
 - Desafio
 - Já posso aposentar no brasil colonial?
 - Tempo de contribuicao mínimo: 15 anos
 - Idade miníma? é preciso de 65 anos para homem, 60 para mulheres
 
 */

let contribuicao = 16
let idade = 60
let sexo = true

if contribuicao >= 15 {
    let idadeAposentar = sexo ? 65 : 60
    if idadeAposentar < idade && sexo {
        print("Contribuinte é homem e pode aposentar")
    }else if idadeAposentar < idade && !sexo{
        print("Contribuinte é mulher e pode aposentar")
    }else {
        print("O contribuinte não pode aposentar")
    }
}

if contribuicao >= 15 {
    let idadeMinima = sexo ? 65 : 60
    if idadeMinima == 65 || idadeMinima == 60 {
        print("Sim, pode aposentar")
    }
}


