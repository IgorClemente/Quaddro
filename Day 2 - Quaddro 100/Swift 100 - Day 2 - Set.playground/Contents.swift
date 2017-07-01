//:Set

//Declaracao Sempre Explicito 
//var 'nomedavar':Set<'tipo'> = []

var conjunto:Set<String> = []
    conjunto.insert("Pinheiros")
    conjunto.insert("Bela Vista")

print(conjunto)

var novoConjunto:Set<String> = ["Vl","Str","String"]


conjunto.intersection(novoConjunto)
print(novoConjunto)

conjunto.union(novoConjunto)
print(conjunto)

//Não tem cópia

//conjunto.insert("Pinheiros") <- Não pode duplicar o valor
print(conjunto)

conjunto.insert("Jardins")
print(conjunto)

conjunto.insert("Butantã")
print(conjunto)


//Operacoes em conjunto

var conjunto3:Set<Double> = []
    conjunto3.insert(90.90)
    conjunto3.insert(56.84)

var conjunto4:Set<Double> = []
    conjunto4.insert(90.90)
    conjunto4.insert(50.89)

conjunto3.intersection(conjunto4) // Pega o que e comum aos dois
conjunto3.union(conjunto4)        // Faz a uniao ignorando valores repetidos

var valoresDiversos:[Double] = [34.0,67.0,87.5,54.5,32.8,54.9,76.8,54.9,98.6,100.0]
valoresDiversos.forEach{
    conjunto3.insert($0)
    conjunto4.insert($0)
}




