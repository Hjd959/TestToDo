//
//  ItemsPhoto.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class ItemsPhoto: UITableViewController {

    // DataBase Array
       var itemArray = [ITEMSPHOTO]()
       
    
    // This is RelationShip
    var selectedCategory : CATEGORYPHOTO? {
        didSet{
            loadItem()
        }
    }
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad()
    {
        super.viewDidLoad()


    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)

           let item = itemArray[indexPath.row]
             
        cell.textLabel?.text = item.titelPhoto

        return cell
    }
    
    
    // This ReationShip With Add TEXT
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destinationVC = segue.destination as? AddItemsPhoto
        {
            destinationVC.toDoTableVC = self
        }
        
        
    }
    
    // MARK: - Table view Manipulation Methods
      
      // Save Data
      
      func saveItems()
      {
          do
          {
              try context.save()
          }catch
          {
              print("Error Saving \(error)")
          }
          self.tableView.reloadData()
      }
      
      // Read Data
      func loadItem(with request : NSFetchRequest<ITEMSPHOTO> = ITEMSPHOTO.fetchRequest() ,predicate :NSPredicate? = nil)
      {
          
          // Query
          
          let Categorypredicate = NSPredicate(format: "perntREATIONSHIPphoto.nameFolder MATCHES %@", selectedCategory!.nameFolder!)
          
          if let addtionalPredicate = predicate {
              request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [Categorypredicate,addtionalPredicate])
          }
          else{
              request.predicate = Categorypredicate
          }
          
          
          do {
              itemArray = try context.fetch(request)
          }catch{
              print("error Fetch \(error)")
          }
          tableView.reloadData()
          
      }
      



}
