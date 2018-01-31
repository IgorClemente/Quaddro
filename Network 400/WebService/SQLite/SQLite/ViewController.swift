//
//  ViewController.swift
//  SQLite
//
//  Created by Swift on 27/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nomeTextField: UITextField?
    @IBOutlet weak var idadeTextField: UITextField?
    @IBOutlet weak var logTextView: UITextView?
    
    // Será utilizado OpaquePointer pois como a library SQLite é escrita em C não possuimos uma representação em Swift
    // Variável que representará a base de dados
    var banco: OpaquePointer? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         
         FMDB
         
         **/
        
        self.logTextView?.text = nil
        
        // Resgatar o caminho da pasta de documents
        let documentosURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        
        // Criar o caminho do banco de dados
        guard let caminhoDB = documentosURL?.appendingPathComponent("db.sqlite") else {
            return
        }
        print(caminhoDB)
        
        // Funcao que cria ou abre um banco de dados SQLite
        if sqlite3_open(caminhoDB.absoluteString, &self.banco) == SQLITE_OK {
            self.exibir(log: "Abriu o banco")
            
            // Montar o comando de criação da tabela
            let query = "CREATE TABLE IF NOT EXISTS PESSOAS (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, nome TEXT, idade INTEGER)"
            
            // Executar o comando no DB
            if sqlite3_exec(self.banco, query, nil, nil, nil) == SQLITE_OK {
               self.exibir(log: "Tabela Criada")
            } else {
                self.exibir(log: "Falha na criação da tabela: \(String(cString: sqlite3_errmsg(self.banco!))) ")
            }
            
        } else {
            self.exibir(log: "Falha ao Criar/Abrir o banco: \(String(cString: sqlite3_errmsg(self.banco!)))")
        }
    }

    @IBAction func tapSalvar(_ sender: UIButton) {
        // Garantir que possuímos nome e idade
        guard let nome  = self.nomeTextField?.text,
              let idade = self.idadeTextField?.text else {
            return
        }
        // Converter idade de String para Int
        let idadeInt = Int(idade)
    
        // Comando de inserção na tabela
        let query = "INSERT INTO PESSOAS values (NULL,'\(nome)',\(idadeInt!))"
        
        if sqlite3_exec(self.banco!, query, nil, nil, nil) == SQLITE_OK {
           self.exibir(log: "Registro adicionado")
           self.nomeTextField?.text  = nil
           self.idadeTextField?.text = nil
        } else {
           self.exibir(log: "Falha ao adicionar o registro \(String(cString: sqlite3_errmsg(self.banco!)))")
        }
    }
    
    @IBAction func tapResgatar(_ sender: UIButton) {
        
        // Comando para resgatar dos dados da tabela
        let query = "SELECT * FROM PESSOAS"
        
        // Variável que armazenará o valor gerado pelo select
        var statement:OpaquePointer?
        
        // Função que executa o comando gerando um resultado
        if sqlite3_prepare_v2(self.banco!, query, -1, &statement, nil) != SQLITE_OK {
           self.exibir(log: "Falha ao resgatar registros \(String(cString: sqlite3_errmsg(self.banco!)))")
           return
        }
        
        // Criar um array para salvar os dados do SELECT
        var pessoas = [[String: Any]]()
        
        // Estrutura de repetição para resgatar todos os registros do SELECT
        while sqlite3_step(statement) == SQLITE_ROW {
            // Regastar os dados
            let id = sqlite3_column_int64(statement, 0)
            let nome  = sqlite3_column_text(statement, 1)
            let idade = sqlite3_column_int64(statement, 2)
            
            // Converter o cString para String
            let nomeString = String(cString: nome!)
            
            // Adicionar o registro no Array
            pessoas.append(["id": id,"nome": nomeString,"idade": idade])
        }
        
        // Ao concluir o trabalho, descartar o statement
        sqlite3_finalize(statement)
        
        // Exibir os resultados
        for pessoa in pessoas {
            self.exibir(log: "ID \(pessoa["id"]!), NOME: \(pessoa["nome"]!), IDADE: \(pessoa["idade"]!)")
        }
    }
    
    func exibir(log:String) {
        self.logTextView?.text.append("\n\(log)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

