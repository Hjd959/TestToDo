//
//  ItemsPhoto.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class ItemsPhoto: UITableViewController {

     // MARK: - DATA BASE
    
    // DataBase Array  ITEMS
       var itemArray = [ITEMSPHOTO]()
       
    //MARK:-  This is RelationShip
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

        // This is Table Photo  ... The View
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "2"))
        title = title
        tableView.reloadData()
    }

    //MARK:- Hide The Line For NavigationBar
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
         // Make the navigation bar background clear
         navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         navigationController?.navigationBar.shadowImage = UIImage()
         navigationController?.navigationBar.isTranslucent = true
            tableView.reloadData()
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
         
         // Restore the navigation bar to default
         navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
         navigationController?.navigationBar.shadowImage = nil
     }
    // MARK: - Table view data source

 // this for array list data Numbers
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

     // this is for reload Data ( Cell )
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemsCell", for: indexPath)

         cell.textLabel?.textAlignment = .right
        let item = itemArray[indexPath.row]
        cell.backgroundColor = .clear
        cell.textLabel?.text = item.titelPhoto
       

        return cell
    }
    
    

    // This ReationShip With Add TEXT
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let slelectedItem = itemArray[indexPath.row]
        performSegue(withIdentifier: "goToShowPhoto", sender: slelectedItem)
    }
  override func prepare(for segue: UIStoryboardSegue, sender: Any?)
  {
      if let destinationVC = segue.destination as? AddItemsPhoto
      {
          destinationVC.toDoTableVC = self
      }
      
      if let completVC = segue.destination as? ShowPhoto {
          if let toDo = sender as? ITEMSPHOTO {
            completVC.toDo = toDo
            completVC.toDoTableVC = self
           
          }
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

   //MARK: - Search bar methods
    @available(iOS 13.0, *)
    extension ItemsPhoto: UISearchBarDelegate {
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {


            let request : NSFetchRequest<ITEMSPHOTO> = ITEMSPHOTO.fetchRequest()
            print(searchBar.text!)

           let predicate = NSPredicate(format: "titelPhoto CONTAINS[cd] %@", searchBar.text!)

            request.sortDescriptors = [NSSortDescriptor(key:"titelPhoto", ascending: true)]
            loadItem(with: request , predicate: predicate)
        }
       func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          if searchBar.text?.count == 0 {
               loadItem()
               DispatchQueue.main.async {
                   searchBar.resignFirstResponder()
               }
}
       }
    }

