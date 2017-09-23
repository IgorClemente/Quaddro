//
//  IdadeViewController.swift
//  Qasino
//
//  Created by Luiz Gustavo Lino on 10/22/16.
//  Copyright © 2016 Luiz Gustavo Lino. All rights reserved.
//

import UIKit

class IdadeViewController: UIViewController {

    
    @IBOutlet weak var seletorDeData: UIDatePicker!
    
    @IBAction func tapEntrar(_ sender: AnyObject) {
        
        let selecionada = seletorDeData.date
        let agora       = Date()
        let componentes = seletorDeData.calendar.dateComponents([.year],
                                                                from: selecionada,
                                                                to: agora)
        if let idade = componentes.year {
            
            print("Idade digitada: \(idade)")
            
            if idade > 18 {
                performSegue(withIdentifier: "entrar", sender: nil)
            }else{
                
                let aviso = UIAlertController(title: "Ops!", message: "Você precisar ter mais de 18 anos para entrar em casinos", preferredStyle: .alert)
                
                let fechar = UIAlertAction(title: "Entendi", style: .default) { _ in
                    aviso.dismiss(animated: true, completion: nil)
                }
                
                aviso.addAction(fechar)
                
                self.present(aviso, animated: true, completion: nil)
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        estudoNSDate()
    }
    
    func estudoNSDate(){
        
        // data atual
        let agora = Date()
        print("Agora: \(agora)")
        
        // 10 minutos depois
        let maisTarde = Date(timeIntervalSinceNow: 10*60)
        print("Daqui 10 minutos: \(maisTarde)")
        
        // Qual é mais cedo?
        if maisTarde > agora {
            print("Agora é mais cedo do que mais tarde!")
        }
        
        // adicionando tempo
        let depoisDeAgora = agora.addingTimeInterval(20*60)
        
        if maisTarde < depoisDeAgora {
            print("Agora + 20 minutos é depois que daqui a pouco")
        }
        
        // outra maneira de comparar:
        let dataA = agora
        let dataB = maisTarde
        switch dataA.compare(dataB) {
            case .orderedAscending     :   print("Data A vem antes da B")
            case .orderedDescending    :   print("Data A vem depois da B")
            case .orderedSame          :   print("As duas são iguais!")
        }
        
        
        // Valores pré-definidos
        let epoch = Date(timeIntervalSince1970: 0)
        let futuro = Date.distantFuture
        let passado = Date.distantPast
        
        print("epoch: \(epoch)")
        print("futuro: \(futuro)")
        print("passado: \(passado)")
        
        // Tempo e entre datas
        let intervalo = agora.timeIntervalSince(maisTarde)
        print("Tem \(intervalo) segundos entre agora e mais tarde")
        
        
        // Date formaters
        let formato = DateFormatter()
        formato.dateStyle = .long
        formato.locale    = Locale(identifier: "pt_BR")
        print("Formatadinho: ", formato.string(from: agora))
        
        // colocando hora também
        formato.timeStyle = .medium
        print("Formatadinho, com hora: ", formato.string(from: agora))
        
        // formatos customizados! (http://bit.ly/1O0K61i)
        // formato UOL:
        formato.dateFormat = "YYYYMMddHHmmss"
        print("Formatadinho, customizado: ", formato.string(from: agora))
        
        // A mesma coisa pra recuperar a data
        let natal = "20161225220000"
        let dataDoNatal  = formato.date(from: natal)
        formato.dateStyle = .short
        print("Recuperando data de string: ", formato.string(from: dataDoNatal!))
        
        
        // Date components
        if let calendar = NSCalendar(calendarIdentifier: .gregorian) {
            // Buscando os componentes de uma data
            let hora = calendar.component(.hour, from: agora)
            let minuto = calendar.component(.minute, from: agora)
            print("agora são \(hora):\(minuto)")
        }
        
        // - Desafios -
        // Mostrar: 10h20 AM
        // Hoje é terça?
        // Quantos dias faltam pro natal?
        
    }
    
    
    
}
