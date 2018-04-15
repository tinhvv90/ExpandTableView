//
//  CheckboxViewController.swift
//  VNA
//
//  Created by Tinh Vu on 4/14/18.
//  Copyright © 2018 Tinh Vu. All rights reserved.
//

import UIKit

class CheckboxViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var myPerferences : MyPreferencesResponse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return myPerferences?.favoriteFoodDTOs?.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (myPerferences?.favoriteFoodDTOs![section].foodDTO!.count)!
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath) as! CheckboxCell
        
        return cell
    }

}
