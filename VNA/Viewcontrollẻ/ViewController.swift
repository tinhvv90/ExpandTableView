//
//  ViewController.swift
//  VNA
//
//  Created by Tinh Vu on 4/14/18.
//  Copyright © 2018 Tinh Vu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myPreferenceContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myPreferenceContainer.layer.cornerRadius = 6
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMyPreferences" {
            
        }
    }

}

