//
//  NavItemsExtension.swift
//  On the Map
//
//  Created by Reem on 5/11/19.
//  Copyright © 2019 Udacity. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    @IBAction func addImage(_ sender: UIBarButtonItem){
        performSegue(withIdentifier: "AddLocation", sender: nil)
    }
    
    @IBAction func logout(_ sender: UIBarButtonItem){
       
        UdacityClient.deleteSession { (data, error) in
            if data != nil {
                self.dismiss(animated: true, completion: nil)
            }
            else{
                self.showAlert(message: "Failed to Logout, Reason: \(String(describing: error?.localizedDescription))")
            }
        }
      
    }

    
}
