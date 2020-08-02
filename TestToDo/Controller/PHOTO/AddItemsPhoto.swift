//
//  AddItemsPhoto.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class AddItemsPhoto: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var designSaveButton: UIButton!
    // This is For Inhernens VC
    var toDoTableVC : ItemsPhoto? = nil
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var photoViews: UIImageView!
    @IBOutlet weak var photoTitel: UITextField!
    
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        designSaveButton.layer.cornerRadius = 5
     

        
        
        // For Keybord
         dismissKey()
        
        pickerController.delegate = self
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
    

    @IBAction func cam(_ sender: UIBarButtonItem)
    {
        pickerController.sourceType = .camera
          present(pickerController,animated: true , completion: nil)
    }
    
    @IBAction func filesPhoto(_ sender: UIBarButtonItem)
    {
        pickerController.sourceType = .photoLibrary
        present(pickerController,animated: true , completion: nil)
    }

    
    @IBAction func savePhoto(_ sender: UIButton)
    {
        let newItem = ITEMSPHOTO(context: self.context)
        newItem.titelPhoto = photoTitel.text
        newItem.imageDB = photoViews.image?.jpegData(compressionQuality: 1.0)
        newItem.perntREATIONSHIPphoto = toDoTableVC?.selectedCategory
        toDoTableVC?.itemArray.append(newItem)
        toDoTableVC?.tableView.reloadData()
        
        let aleart = UIAlertController(title: "تم إضافة ملاحظه جديده", message: "بعنوان :  \(newItem.titelPhoto!)", preferredStyle: .alert)
             let action = UIAlertAction(title: "موافق", style: .default) { (action) in

                self.navigationController?.popViewController(animated: true)
             }
             aleart.addAction(action)
             present(aleart, animated: true, completion: nil)
      
    }
    
}
