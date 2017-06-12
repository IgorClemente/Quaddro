//:Controle de Planetas


typealias Planeta = (nome: String, distancia: Double)

var controle:[Planeta] = []
var distancias:[Double] = [45.7,766.54,44.54,76.87,766.7,766.9,776.9]
var contador:Int = 0

["Mercurio","Venus","Marte","Jupiter","Saturno","Urano","Plutao"].forEach{

    let novoPlaneta:Planeta = ($0,0.8)
    controle.append(novoPlaneta)
}

controle.forEach{
    
    print("\($0)")
}