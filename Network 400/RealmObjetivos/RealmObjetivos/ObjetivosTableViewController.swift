//
//  ObjetivosTableViewController.swift
//  RealmObjetivos
//
//  Created by Swift on 03/02/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import RealmSwift

class ObjetivosTableViewController: UITableViewController {

    // Variável do Realm
    var realm: Realm!
    var objetivos = [Objetivo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Instanciar o Realm
        self.realm = try! Realm()
        
        // Resgatar do DB os objetos que já foram criados
        let objetivosResgatados = self.realm.objects(Objetivo.self)
        self.objetivos.append(contentsOf: objetivosResgatados)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func tapAdicionar(_ sender: UIBarButtonItem) {
        
        let alert  = UIAlertController(title: "Criar Objetivo", message: "", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        
        let action = UIAlertAction(title: "Adicionar", style: .default) { (_) in
            // Garantir que possuímos o texto digitado pelo usuário
            guard let objetivoNome = alert.textFields?.first?.text else { return }
            
            // Criar uma objeto do objetivo
            let novoObjetivo  = Objetivo()
            novoObjetivo.nome = objetivoNome
            novoObjetivo.concluido.value = false
            
            // Vamos criar uma transação no DB
            try! self.realm.write {
                 // Adicionar o novo registro no DB
                 self.realm.add(novoObjetivo)
            }
            
            // Adicionar o registro no Array
            self.objetivos.append(novoObjetivo)
            DispatchQueue.main.async {
               self.tableView.insertRows(at: [IndexPath(row: self.objetivos.count - 1, section: 0)], with: .automatic)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
      
        alert.addAction(action)
        alert.addAction(cancelAction)
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
        
        let objetivo = self.objetivos[indexPath.row]
        cell.textLabel?.text = objetivo.nome
        cell.accessoryType   = objetivo.concluido.value! ? .checkmark : .none
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Resgatar o objetivo que foi selecionado
        let objetivo = self.objetivos[indexPath.row]
        
        // Efetuar uma transação e alterar o registro
        try! self.realm.write {
            objetivo.concluido.value = objetivo.concluido.value! ? false : true
        }
        
        // Resgatar a célula da linha selecionada
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = objetivo.concluido.value! ? .checkmark : .none
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let objetivo = self.objetivos[indexPath.row]
            
            // Transação no DB
            try! self.realm.write {
                self.realm.delete(objetivo)
            }
            self.objetivos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
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
