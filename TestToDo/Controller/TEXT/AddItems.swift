//
//  AddItems.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 18/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
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
        
        // For Keybord
        dismissKey()
    }
    
    
    //MARK:- Hide The Line For NavigationBar
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
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
        
        
        let aleart = UIAlertController(title: "تم إضافة ملاحظه جديده", message: "بعنوان :  \(newItem.titelText!)", preferredStyle: .alert)
        let action = UIAlertAction(title: "موافق", style: .default) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        aleart.addAction(action)
        present(aleart, animated: true, completion: nil)
       
        
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
