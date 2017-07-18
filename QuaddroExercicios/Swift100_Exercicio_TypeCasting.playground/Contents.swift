/*
 
 - Autor: Igor Clemente
 - Data: 16/07/2017
 - Conteudo: TypeCasting - Exercicios
 
 */


class Midia {
    
    private var nome:String
    
    init(_ nome:String) {
        self.nome = nome
    }
    
    func getNome() -> String {
        return nome
    }
}

class Filme : Midia {

    private var diretor:String
    
    init(diretor:String,_ nomeMidia:String) {
        self.diretor = diretor
        super.init(nomeMidia)
    }
    
    func getDiretor() -> String {
        return diretor
    }
    
}

class Musica : Midia {

    private var artista:String
    
    init(artista:String,_ nomeMidia:String) {
        self.artista = artista
        super.init(nomeMidia)
    }
    
    func getArtista() -> String {
        return artista
    }
}


func descricao(_ minhaMidia:Midia) -> Void {
    
    if let midia = minhaMidia as? Filme {
        print("Nome: \(midia.getNome()) de Diretor: \(midia.getDiretor())")
    }
    
    if let midia = minhaMidia as? Musica {
        print("Nome: \(midia.getNome()) de Artista: \(midia.getArtista())")
    }
}

let filme = Filme(diretor:"Robert Peterson","O Hobbit")
    descricao(filme)

let musica = Musica(artista:"Bob Dylan","Blowin in the Wind")
    descricao(musica)

