//
//  ObjetivosTableViewController.swift
//  CloudKitObjetivos
//
//  Created by Swift on 03/02/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit
import CloudKit

class ObjetivosTableViewController: UITableViewController {

    // Array local para armazenar os registros de objetivos
    var objetivos = [CKRecord]()
    
    // Criar um tipo de identidade do registro
    let tipoRegistro = "Objetivo"
    
    var bancoDeDados:CKDatabase?
    var zona:CKRecordZone?
    let container:CKContainer = CKContainer.default()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Criar uma instancia do Database no container privado
        self.bancoDeDados = container.privateCloudDatabase
        
        // Criar uma zona de registros
        self.zona = CKRecordZone(zoneName: "MeusObjetivos")
        self.bancoDeDados?.save(self.zona!, completionHandler: { (zonaSalva, error) in
            if let erroRecebido = error {
               guard let errorCloudKit = erroRecebido as? CKError else { return }
               if errorCloudKit.errorCode == 9 {
                  let message = "Para utilizar o cloud kit é necessário fazer login na sua conta do iCloud"
                  let alerta  = UIAlertController(title: "Acesso negado",
                                                  message: message,
                                                  preferredStyle: .alert)
                  let alertAction = UIAlertAction(title: "Logar", style: .default, handler: {
                      (_) in
                      let settingsIOS = URL(string: "App-Prefs:root")
                      if let url = settingsIOS, UIApplication.shared.canOpenURL(url) {
                         UIApplication.shared.open(url, options: [:], completionHandler: nil)
                      }
                  })
                  alerta.addAction(alertAction)
                  self.present(alerta, animated: true, completion: nil)
               }
            } else {
               print("Sucesso ao criar zona")
            }
        })
        
        self.atualizar()
    }
    
    func atualizar() -> Void {
        self.bancoDeDados?.perform(CKQuery(recordType: self.tipoRegistro, predicate:NSPredicate(value: true)) , inZoneWith: self.zona!.zoneID, completionHandler: { (registros, error) in
            if let erroRecebido = error {
               print("Falha ao resgatar registros \(erroRecebido.localizedDescription)")
            } else {
               print("Registros recebidos \(registros)")
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tapAdicionar(_ sender: UIBarButtonItem) {
        let addAlert  = UIAlertController(title: "Adicionar", message: nil, preferredStyle: .alert)
        addAlert.addTextField(configurationHandler: nil)
        
        let addAction = UIAlertAction(title: "Criar", style: .default) { (_) in
            // Garantir que possuímos o text digitado pelo usuário
            guard let textObjetivo = addAlert.textFields?.first?.text else { return }
            let novoObjetivo = CKRecord(recordType: self.tipoRegistro, zoneID: (self.zona?.zoneID)!)
            
            // Definir o valor do nome do registro
            novoObjetivo.setValue(textObjetivo, forKey: "nome")
            self.bancoDeDados?.save(novoObjetivo, completionHandler: { (registroSalvo, error) in
                if let erroRecebido = error {
                   print("Falha na criação do registro \(erroRecebido.localizedDescription)")
                } else {
                   print("Registro criado com sucesso!")
                   
                   // Adicionar o objeto criado no Array local
                   guard let registro = registroSalvo else {
                       return
                   }
                   self.objetivos.append(registro)
                   DispatchQueue.main.async {
                      self.tableView.insertRows(at: [IndexPath(row: self.objetivos.count - 1,
                                                               section: 0)], with: .automatic)
                   }
                }
            })
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .default, handler: nil)

        addAlert.addAction(addAction)
        addAlert.addAction(cancelAction)
        self.present(addAlert, animated: true, completion: nil)
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
        cell.textLabel?.text = objetivo.value(forKey: "nome") as? String
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
