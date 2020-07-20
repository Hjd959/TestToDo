//
//  CategoryPhoto.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class CategoryPhoto: UITableViewController {

    // DataBase Array
     var CategoryArray = [CATEGORYPHOTO]()
     // This for ( Read , Write , Save .. data (Defuntion)
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
     
     
     
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
          loadCategories()

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return CategoryArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)

        cell.textLabel?.text = CategoryArray[indexPath.row].nameFolder

        return cell
    }
    
    
   // MARK: - Table view Delegate Methods

    // When You chick folder move to anthor Page
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItems", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let destinationVC = segue.destination as! ItemsPhoto

        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = CategoryArray[indexPath.row]
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
       
    
    @IBAction func AddFolderPhoto(_ sender: UIBarButtonItem)
    {
        var textField = UITextField()
        
        let aleart = UIAlertController(title: "Add New Todoey Category ", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            
            
            
            let newCategory = CATEGORYPHOTO(context: self.context)
            newCategory.nameFolder = textField.text!
            
            
            self.CategoryArray.append(newCategory)
            
            self.saveCategory()
            
            
        }
        aleart.addAction(action)
        
        aleart.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Category"
            textField = alertTextField
        }
        
        
        present(aleart, animated: true, completion: nil)
    }
    
}
