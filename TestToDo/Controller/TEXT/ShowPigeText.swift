//
//  ShowPigeText.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class ShowPigeText: UIViewController {
    
    
    @IBOutlet weak var bigText: UITextView!
    
    var toDo = ITEMS()
    
    // This is For Inhernens VC
    var toDoTableVC : Items? = nil
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //   titelText.text = toDo.titelText
        title = toDo.titelText
        bigText.text = toDo.textView
    }
    
    
    //MARK:- Hide The Line For NavigationBar
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Restore the navigation bar to default
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    // Save Data when you get out of the app
    override func viewWillAppear(_ animated: Bool)
    {
        
        // Make the navigation bar background clear
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        toDoTableVC?.tableView.reloadData()
    }
    @IBAction func de(_ sender: UIBarButtonItem)
    {
        //        if toDo.titelText != nil {
        //            toDo.perntCategoryRELATIONSHIP = toDoTableVC?.selectedCategory
        //            context.delete(toDo)
        //            toDoTableVC?.tableView.updateConstraints()
        //
        //            let aleart = UIAlertController(title: "تم حذف الملاحظه", message: "", preferredStyle: .alert)
        //            let action = UIAlertAction(title: "موافق", style: .default) { (action) in
        //            }
        //            aleart.addAction(action)
        //            present(aleart, animated: true, completion: nil)
        //            toDoTableVC?.tableView.reloadData()
        //
        //
        if toDo.perntCategoryRELATIONSHIP != nil {
            
            toDo.perntCategoryRELATIONSHIP = toDoTableVC?.selectedCategory
            context.delete(toDo)
            
            let aleart = UIAlertController(title: "تم حذف الملاحظه", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "موافق", style: .default) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            aleart.addAction(action)
            present(aleart, animated: true, completion: nil)
            toDoTableVC?.tableView.reloadData()
        }
        
        
        
    }
}


