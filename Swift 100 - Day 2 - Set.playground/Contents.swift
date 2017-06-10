//:Set

//Declaracao Sempre Explicito 
//var 'nomedavar':Set<'tipo'> = []

var conjunto:Set<String> = []
    conjunto.insert("Pinheiros")
    conjunto.insert("Bela Vista")

print(conjunto)

//Não tem cópia

//conjunto.insert("Pinheiros") <- Não pode duplicar o valor
print(conjunto)

conjunto.insert("Jardins")
print(conjunto)

conjunto.insert("Butantã")
print(conjunto)


//Operacoes em conjunto

let pares:Set<Int> = [2,4,6,8,10]
let impares:Set<Int> = [1,3,5,7,9,7]

pares.union(impares)

let primos:Set<Int> = [1,2,3,5,7,9,11,13,15,17,19,23]
impares.intersection(primos)

