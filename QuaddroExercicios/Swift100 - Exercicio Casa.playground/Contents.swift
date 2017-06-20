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
 
*/

typealias Materia = (nome:String,notas:[Double])
typealias ItemBoletim = (materia: Materia,media:Double,aprovado:Bool)

var materias = Array<Materia>()
var boletim = Array<ItemBoletim>()
var escola = Dictionary<String,[Materia]>()

    materias.append(("Calculo",[3,8,9,7]))
    materias.append(("Financas",[9,9,8,9]))
    materias.append(("Redacao",[10,10,4,6]))

    escola["Julio"] = materias

var media = Double()

for (aluno,materias) in escola{
    materias.forEach{
        media = $0.notas.reduce(0.0){ $1 + $0 }
        media /= 4
        boletim.append(($0,media,false))
    }
    
    for (chave,valor) in boletim.enumerated(){
        if(!(valor.media <= 5)){
            boletim[chave].aprovado = (valor.media <= 7) ? false : true
        }
    }
}

let aprovados = boletim.filter{ $0.aprovado == true }
if aprovados.count >= 2{
    aprovados.forEach{
        print("Aprovado em: \($0.materia.nome), Media: \($0.media)")
    }
}


/*

 Segundo Desafio:
 
  - Desafio do carnaval 🎉🎉🎉
    Dado um vetor de notas de carnaval, retornar a nota final da escola. Regra: são quatro notas de 5.0 até 10.0. Deve descartar a menor e tirar a média das restantes. Se alguma nota faltar, considerar o valor da maior das notas válidas (indicado por nota = 0.0).
    Utilize:
 
*/


typealias Escola2 = (nome:String, nota:[Double])
let escolas:[Escola2] = [
    (nome:"Green House Empire", nota:[10.0, 9.5, 9.0, 10.0]),
    (nome:"Tucuruvi Academics", nota:[10.0, 10.0, 9.0, 10.0]),
    (nome:"Faithful Eagles", nota:[0.0,10.0, 10.0, 9.5])
]

var media2 = Double()
var escolasModify = escolas
for (numero,escola) in escolasModify.enumerated(){
    
    var filtroZero = escola.nota.filter{ $0 == 0.0 }
    if filtroZero.count > 0{
        for (key,value) in filtroZero.enumerated(){
            escolasModify[numero].nota[key] = 10.0
        }
    }
}

for (chave,valor) in escolasModify.enumerated(){

    let melhores = valor.nota.sorted().dropFirst()
    media2 = melhores.reduce(0.0){ $1+$0 }
    media2 /= Double(melhores.count)
    print("Escola: \(valor.nome), Nota: \(media2))") //Valor Arredondado
}





