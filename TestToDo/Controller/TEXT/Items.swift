//
//  Items.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 18/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class Items: UITableViewController {
    
    // DataBase Array
    var itemArray = [ITEMS]()
    
    // This is RelationShip
    var selectedCategory : CATEGORY? {
        didSet{
            loadItem()
        }
    }
    
    // This for ( Read , Write , Save .. data (Defuntion)
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.titelText
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let slelectedItem = itemArray[indexPath.row]
        performSegue(withIdentifier: "goToShow", sender: slelectedItem)
    }
    
    // This ReationShip With Add TEXT
    
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
    
    // MARK: - Add New Text Single Titel
    //    @IBAction func SA(_ sender: UIBarButtonItem)
    //    {
    //                var textField = UITextField()
    //
    //                let aleart = UIAlertController(title: "Add New Todoey Item ", message: "", preferredStyle: .alert)
    //                let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
    //
    //
    //
    //                    let newItem = ITEMS(context: self.context)
    //                    newItem.titelText = textField.text!
    //                    newItem.perntCategoryRELATIONSHIP = self.selectedCategory
    //
    //
    //                    self.itemArray.append(newItem)
    //                      self.tableView.reloadData()
    //
    //
    //                }
    //                aleart.addTextField { (alertTextField) in
    //                    alertTextField.placeholder = "Create new Item"
    //                    textField = alertTextField
    //                }
    //
    //                aleart.addAction(action)
    //                present(aleart, animated: true, completion: nil)
    //    }
}
