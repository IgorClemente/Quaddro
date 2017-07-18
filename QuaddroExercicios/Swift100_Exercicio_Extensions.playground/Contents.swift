/*
 
 - Autor: Igor Clemente
 - Data: 17/07/2017
 - Exercicios Extensions
 
 */


// - Extensions -
// A) Faça uma extensão de Int que diz que um número é par
// B) Faça uma extension na string para retornar
// um vetor de letras, do tipo String!


extension Int {
    func numeroPar() -> Void {
        if self%2 == 0 {
            print("O numero e par")
        }
    }
}

2.numeroPar()


extension String {
    func todasLetras() -> [Character] {
        return self.characters.filter{ $0 != " " }
    }
}

"Igor Clemente".todasLetras()

