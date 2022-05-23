//
//  Alert.swift
//  TheShortestWay
//
//  Created by mac on 23.05.2022.
//

import UIKit

extension UIViewController{
    
    //alert for create points of route
    func alertAddAdress(title: String, placeholder: String, completionHandler: @escaping (String) -> Void) {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "ОК", style: .default) { (action) in
            let tfText = alertController.textFields?.first
            guard let text = tfText?.text else { return }
            completionHandler(text)
            
            
        }
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { (_) in
            
        }
        
        alertController.addTextField { (tf) in
            tf.placeholder = placeholder
            
        }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        present(alertController, animated:  true, completion: nil)
        
    }
    
    //alert for errors 
    func alertError(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: "ОК", style: .default)
        
        alertController.addAction(alertOk)
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    
}
