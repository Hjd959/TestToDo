//
//  AddItems.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 18/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class AddItems: UIViewController  {
    
    var toDo = ITEMS()
    
    // This is For Inhernens VC
    var toDoTableVC : Items? = nil
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var bigText: UITextView!
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKey()
    }


    //MARK:- Add new Text
    
    @IBAction func addTapped(_ sender: UIButton)
    {
        
        let newItem = ITEMS(context: self.context)
        newItem.titelText = nameTextField.text!
        newItem.textView = bigText.text
        newItem.perntCategoryRELATIONSHIP = toDoTableVC?.selectedCategory
        toDoTableVC?.itemArray.append(newItem)
        toDoTableVC?.tableView.reloadData()
        toDoTableVC?.tableView.reloadData()
        navigationController?.popViewController(animated: true)
        
    }
    
}


extension UIViewController {
func dismissKey()
{
let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
tap.cancelsTouchesInView = false
view.addGestureRecognizer(tap)
}
@objc func dismissKeyboard()
{
view.endEditing(true)
}
}
