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
    
    
    // الصوره كامله بدون اطار 
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
   

}

