//
//  HomeView.swift
//  TestToDo
//
//  Created by عبدالوهاب العنزي on 28/07/2020.
//  Copyright © 2020 Abdulwahab. All rights reserved.
//

import UIKit

class HomeView: UIViewController {

    @IBOutlet weak var text: UIButton!
    @IBOutlet weak var photo: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

   
         text.layer.cornerRadius = 18
         photo.layer.cornerRadius = 18
        
    }
    

   

}
