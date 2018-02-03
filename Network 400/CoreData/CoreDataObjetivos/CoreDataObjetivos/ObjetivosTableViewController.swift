//
//  ObjetivosTableViewController.swift
//  CoreDataObjetivos
//
//  Created by Swift on 03/02/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import CoreData

class ObjetivosTableViewController: UITableViewController {

    // Vamos criar uma variável para armazenar objetivos e auxila a tableView
    var objetivos = [Objetivo]()
    
    // Variável do AppDelegate, para acessarmos o banco de dados
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    // Variável do Context do banco. Uma espécie de cópia local do DB.
    // Onde efetuamos as alterações e depois salvamos no DB "fisico".
    var contextBanco:NSManagedObjectContext? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Resgatar um instancia do contexto
        self.contextBanco = self.appDelegate?.persistentContainer.viewContext
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapAddObjetivo(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Criar Objetivo", message: nil, preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Audi RS6"
            textField.autocapitalizationType = .words
        }
        
        let action = UIAlertAction(title: "Salvar", style: .default) { (_) in
            // Garantir que possuimos o texto digitado pelo usuário
            guard let nomeObjetivo = alert.textFields?.first?.text,
                  let context      = self.contextBanco else {
                return
            }
            
            // Criar o objeto do objetivo
            let objetivo = NSManagedObject(entity: Objetivo.entity(), insertInto: context)
            objetivo.setValue(nomeObjetivo, forKey: "nome")
            objetivo.setValue(false, forKey: "concluido")
            objetivo.setValue(Date(), forKey: "dataCriacao")
            
            // Salvar o contexto atual no banco fisico
            do {
                try context.save()
            } catch {
                print("Error saving \(error.localizedDescription)")
                return
            }
            
            // Adicionar o objetivo na lista local, para exibição
            self.objetivos.append(objetivo as! Objetivo)
            
            // Adicionar uma célula para o novo registro, na tableView
            self.tableView.insertRows(at: [IndexPath(row: self.objetivos.count - 1, section: 0)], with: .automatic)
        }
        
        let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(action)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objetivos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Resgatar o objetivo da linha atual
        let objetivo = self.objetivos[indexPath.row]
        cell.textLabel?.text = objetivo.nome
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
