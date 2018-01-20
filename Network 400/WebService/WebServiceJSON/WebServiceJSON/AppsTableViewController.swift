//
//  AppsTableViewController.swift
//  WebServiceJSON
//
//  Created by Swift on 20/01/2018.
//  Copyright © 2018 Swift. All rights reserved.
//

import UIKit

class AppsTableViewController: UITableViewController {

    var aplicacoes = [App]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.atualizar()
    }

    func atualizar() -> Void {
        // Garantir que possuimos uma URL
        guard let url = URL(string: "https://itunes.apple.com/br/rss/newapplications/json") else {
            return
        }
        
        // Criar a sessão
        let sessao = URLSession(configuration: .default)
        
        // Criar tarefa
        let tarefa = sessao.dataTask(with: url) { (dados, _, _) in
            guard let dadosRecebidos = dados else {
                return
            }
            
            do {
                // Transformar o JSON em um objeto nativo
                guard let resultadoJSON = try JSONSerialization.jsonObject(with: dadosRecebidos, options: []) as? [String:[String:Any]] else {
                    return
                }
                
                guard let feed = resultadoJSON["feed"] else {
                    return
                }
                
                guard let entry = feed["entry"] as? [[String: Any]] else {
                    return
                }
                
                // Criar os objetos dos apps
                for appJSON in entry {
                    // Criar o objeto App
                    let app = App(dadosJSON: appJSON)
                    self.aplicacoes.append(app)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
            } catch let erro {
                print("Error -> \(erro.localizedDescription)")
            }
        }
        
        tarefa.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.aplicacoes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let appInformation = self.aplicacoes[indexPath.row]
        
        cell.textLabel?.text       = appInformation.nome
        cell.detailTextLabel?.text = appInformation.preco
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
