/*
 
 Autor: Igor Clemente
 Data: 19/06/2017
 
*/

/*
typealias Materia = (nome:String,notas:[Double],aprovado:Bool,recuperacao:Bool)

var Julio = Array<Materia>()

   Julio.append(("Calculo",[3,8,9,7],false,false))
   Julio.append(("Financas",[9,9,8,9],false,false))
   Julio.append(("Redacao",[10,10,4,6],false,false))

var media:Double = 0.0

for (chave,materia) in Julio.enumerated(){
    media = materia.notas.reduce(0.0){ $0+$1 }
    media /= 4
    print("\(materia.nome) \(media)")
    if(!(media <= 5)){
        if(media <= 7){
            Julio[chave].aprovado = false
            Julio[chave].recuperacao = true
        }else{
            Julio[chave].aprovado = true
            Julio[chave].recuperacao = false
        }
    }
}

let aprovado = Julio.filter{ $0.aprovado == true && $0.recuperacao == false }
    print(aprovado)

if(aprovado.count >= 2){
    var materiasAprovadas = String()
    aprovado.forEach{
        materiasAprovadas += ($0.aprovado) ? $0.nome : $0.nome
        materiasAprovadas += ","
    }
    print("Materias Aprovadas: \(materiasAprovadas)")
}
*/


/*

 Outra Solucao
 - Usando Dicionario de Dados
 
*/

//Obs: Poderia usar tupla em notas[], para que o conteudo tenha 4 notas

typealias Materia = (nome:String,notas:[Double])
typealias ItemBoletim = (materia: Materia,media:Double,aprovado:Bool)

var boletim = Array<ItemBoletim>()
var escola = Dictionary<String,[ItemBoletim]>()

boletim.append((("Calculo",[3,8,9,7]),0.0,false))
boletim.append((("Financas",[9,9,8,9]),0.0,false))
boletim.append((("Redacao",[10,10,4,6]),0.0,false))
escola["Julio"] = boletim

var media = Double()
var materias = Array<ItemBoletim>()

for (aluno,boletim) in escola{
    boletim.forEach{
        media = $0.materia.notas.reduce(0.0){$0+$1}
        media /= Double($0.materia.notas.count)
        if !(media <= 5.0) {
           let aprovado = (media <= 7) ? false : true
           materias.append(($0.materia,media,aprovado))
        }
    }
    escola[aluno] = materias
}

for (aluno,boletim) in escola{
    let materiasAprovado = boletim.filter{ $0.aprovado == true }
    
    if materiasAprovado.count == 2{
        let recuperacao = boletim.filter{ $0.aprovado == false }
        let materiaRecuperacao = recuperacao.map{ $0.media }
        
        switch materiaRecuperacao[0]{
            
        case 6...7:
            materiasAprovado.forEach{
                print("O aluno: \(aluno) foi aprovado em: \($0.materia.nome), com Media: \($0.media), Porem ficou de recuperacao em: \(recuperacao[0].materia.nome)")
            }
        case 0...5:
            print("O aluno reprovou")
            
        default:
            print("Infelizmente não posso ajudar")
        }
    }else{
        print("O aluno: \(aluno) Reprovou")
    }
}


/*

 Segundo Desafio:
 
  - Desafio do carnaval 🎉🎉🎉
    Dado um vetor de notas de carnaval, retornar a nota final da escola. 
    Regra: são quatro notas de 5.0 até 10.0. Deve descartar a menor e tirar a média das         restantes. Se alguma nota faltar, considerar o valor da maior das notas válidas (indicado por nota = 0.0).
    Utilize:
 
*/


typealias EscolaSamba = (nome:String, nota:[Double])
let escolas:[EscolaSamba] = [
    (nome:"Green House Empire", nota:[10.0,9.5,9.0,10.0]),
    (nome:"Tucuruvi Academics", nota:[10.0,10.0,9.0,10.0]),
    (nome:"Faithful Eagles", nota:[0.0,10.0,10.0,9.5])
]

var mediaEscola = Double()
var escolasModify = escolas
var notaMaior:Double = 0.0

for (numero,escola) in escolasModify.enumerated(){
    notaMaior = escola.nota.reduce(0.0){ max($0,$1) }
    if escola.nota.count == 4{
        var filtroZero = escola.nota.filter{ $0 == 0.0 }
        if !filtroZero.isEmpty{
            for (chave,valor) in filtroZero.enumerated(){
                escolasModify[numero].nota[chave] = notaMaior
            }
        }
    }/*else{
        let faltam = (4 - escola.nota.count)
        let notaInserir = (faltam != 0) ? notaMaior : 0.0
        
        for nota in (0..<faltam){
            escolasModify[numero].nota.append(notaInserir)
        }
    } */
}

for (chave,valor) in escolasModify.enumerated(){
    
    let melhoresNotas = valor.nota.sorted().dropFirst()
    
    mediaEscola = melhoresNotas.reduce(0.0){ $1+$0 }
    mediaEscola /= Double(melhoresNotas.count)
    print("Escola: \(valor.nome), Nota: \(mediaEscola)")
}





