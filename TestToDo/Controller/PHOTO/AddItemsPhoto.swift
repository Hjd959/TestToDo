//
//  AddItemsPhoto.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class AddItemsPhoto: UIViewController {
    
    // This is For Inhernens VC
    var toDoTableVC : ItemsPhoto? = nil
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    @IBOutlet weak var photoTitel: UITextField!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func savePhoto(_ sender: UIButton)
    {
        let newItem = ITEMSPHOTO(context: self.context)
        newItem.titelPhoto = photoTitel.text!
        newItem.perntREATIONSHIPphoto = toDoTableVC?.selectedCategory
        toDoTableVC?.itemArray.append(newItem)
        toDoTableVC?.tableView.reloadData()
        toDoTableVC?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }
    
}
