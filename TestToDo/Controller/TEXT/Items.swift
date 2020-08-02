//
//  Items.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 18/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

@available(iOS 13.0, *)
class Items: UITableViewController {
    
    
    // MARK: - DATA BASE
    
    // DataBase Array  ITEMS
    var itemArray = [ITEMS]()
    
    //MARK:-  This is RelationShip
    var selectedCategory : CATEGORY? {
        didSet{
            loadItem()
        }
    }
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // This is Table Photo  ... The View
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "2"))
        title = title
        tableView.reloadData()
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
        tableView.reloadData()
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
        cell.textLabel?.text = item.titelText
        
        return cell
    }
    
    
    
    // This ReationShip
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let slelectedItem = itemArray[indexPath.row]
        performSegue(withIdentifier: "goToShow", sender: slelectedItem)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destinationVC = segue.destination as? AddItems
        {
            destinationVC.toDoTableVC = self
        }
        if let completVC = segue.destination as? ShowPigeText {
            if let toDo = sender as? ITEMS {
                completVC.toDo = toDo
                completVC.toDoTableVC = self
            }
        }
    }
    
    // MARK:- Delete Category
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        //    let noteEntity = "ITEMS" //Entity Name
        
        //  let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        var note = itemArray[indexPath.row]
        note.perntCategoryRELATIONSHIP = selectedCategory
        
        if editingStyle == .delete {
            
            context.delete(note)
            
            do {
                try context.save()
            } catch let error as NSError {
                print("Error While Deleting Note: \(error.userInfo)")
            }
            
            tableView.reloadData()
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
    func loadItem(with request : NSFetchRequest<ITEMS> = ITEMS.fetchRequest() ,predicate :NSPredicate? = nil)
    {
        
        // Query
        let Categorypredicate = NSPredicate(format: "perntCategoryRELATIONSHIP.nameFolder MATCHES %@", selectedCategory!.nameFolder!)
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
extension Items: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        
        let request : NSFetchRequest<ITEMS> = ITEMS.fetchRequest()
        print(searchBar.text!)
        
        let predicate = NSPredicate(format: "titelText CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key:"titelText", ascending: true)]
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

