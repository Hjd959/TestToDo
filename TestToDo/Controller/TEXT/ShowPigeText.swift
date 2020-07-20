//
//  ShowPigeText.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 19/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit
import CoreData

class ShowPigeText: UIViewController {

    @IBOutlet weak var titelText: UILabel!
    @IBOutlet weak var bigText: UITextView!
    
    // This is For Inhernens VC
    var toDoTableVC : Items? = nil
    
    // This for ( Read , Write , Save .. data (Defuntion)
       let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var toDo = ITEMS()
    override func viewDidLoad() {
        super.viewDidLoad()

        titelText.text = toDo.titelText
        bigText.text = toDo.textView
    }
    

    func deleteRecords() {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext

        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "titelPhoto")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }
    }

    @IBAction func dlete(_ sender: UIButton)
    {
      deleteRecords()
    }
}
