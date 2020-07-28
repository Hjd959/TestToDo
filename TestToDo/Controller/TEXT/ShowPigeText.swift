//
//  ShowPigeText.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class ShowPigeText: UIViewController {

    @IBOutlet weak var titelText: UILabel!
    @IBOutlet weak var bigText: UITextView!
    
        var toDo = ITEMS()
    
    // This is For Inhernens VC
    var toDoTableVC : Items? = nil
 
    // This for ( Read , Write , Save .. data (Defuntion)
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

        titelText.text = toDo.titelText
        bigText.text = toDo.textView
    }
    
    @IBAction func de(_ sender: UIBarButtonItem)
    {

                if  toDo != nil {
                toDo.perntCategoryRELATIONSHIP = toDoTableVC?.selectedCategory
                    context.delete(toDo)
                toDoTableVC?.tableView.reloadData()
                toDoTableVC?.tableView.reloadData()
                
        }
        toDoTableVC?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
    }

}
