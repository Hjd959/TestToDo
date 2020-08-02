//
//  CategoryPhoto.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class CategoryPhoto: UITableViewController {

    //MARK: - DATA BASE
    
    // DataBase Array
     var CategoryArray = [CATEGORYPHOTO]()
     // This for ( Read , Write , Save .. data (Defuntion)
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     
     
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
          // The Photo Table
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "2"))

          loadCategories()

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

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CategoryArray.count
    }

    
     // This is for reload Data ( Cell )
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.textAlignment = .right
        //  cell.backgroundView = UIImageView(image: UIImage(named: "Dark"))
          cell.backgroundColor = .clear
        //  cell.backgroundColor = UIColor(white: 1, alpha: 0.5)
        cell.textLabel?.text = CategoryArray[indexPath.row].nameFolder

        return cell
    }
    
    
   // MARK: - Table view Delegate Methods

    // When You chick folder move to anthor Page
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
          // this when you Select ( Defintion Cell Tabel View )
         let didselct = CategoryArray[indexPath.row]
        performSegue(withIdentifier: "goToItems", sender: didselct)
    }

     // MARK: - RelationShip  Between (Category & Items)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let destinationVC = segue.destination as! ItemsPhoto
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
            
            // Title Move to New Item
            destinationVC.title = CategoryArray[indexPath.row].nameFolder
        }

    }
    
    
    // MARK: - Table view Manipulation Methods
       
       // Save Data
       func saveCategory()
       {
           do {
               try context.save()
           } catch  {
               print("Error Saving \(error)")
           }
           tableView.reloadData()
       }
       
       func loadCategories()
       {
           let request : NSFetchRequest<CATEGORYPHOTO> = CATEGORYPHOTO.fetchRequest()
           do{
               CategoryArray = try context.fetch(request)
           }catch{
               print("Error LadCategory \(error)")
           }
           tableView.reloadData()
       }
       
    
    
    // MARK:- Delete Category
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

         let noteEntity = "CATEGORYPHOTO" //Entity Name

         let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

         let note = CategoryArray[indexPath.row]

         if editingStyle == .delete {
            managedContext.delete(note)

            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }

         }
    
        //Code to Fetch New Data From The DB and Reload Table.
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: noteEntity)

        do {
            CategoryArray = try managedContext.fetch(fetchRequest) as! [CATEGORYPHOTO]
            
        } catch let error as NSError {
            print("Error While Fetching Data From DBBBBB: \(error.userInfo)")
        }
        tableView.reloadData()
    }
    
    // MARK: - Add New Categories to Tabel View as Aleart
    @IBAction func AddFolderPhoto(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
             let refreshAlert = UIAlertController(title: "إضافة مجلد جديد", message: "", preferredStyle: UIAlertController.Style.alert)

            let action = (UIAlertAction(title: "إضافه", style: .default, handler: { (action) in
                 
                 let newCategory = CATEGORYPHOTO(context: self.context)
                 newCategory.nameFolder = textField.text!
                 
                 
                 self.CategoryArray.append(newCategory)
                 
                 self.saveCategory()
                 
             }))
             
             refreshAlert.addAction(action)
             
             refreshAlert.addTextField { (alertTextField) in
                 alertTextField.placeholder = "اسم المجلد"
                 alertTextField.textAlignment = .center
                 textField = alertTextField
                 
             }
           
             refreshAlert.addAction(UIAlertAction(title: "رجوع", style: .cancel, handler: { (action: UIAlertAction!) in
                   print("Handle Cancel Logic here")
             }))

             present(refreshAlert, animated: true, completion: nil)
    }
    
}
