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
    var index: Int? = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
    }
    
    func setupTableView() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(_:)), name: NSNotification.Name.init(NotificationIndexOfCellType), object: nil)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib.init(nibName: "HeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "HeaderCell")
        self.tableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedSectionHeaderHeight = UITableViewAutomaticDimension
    }
    
    @objc func handleNotification(_ notification: Notification) {
        if let index = notification.object as? Int {
            self.index = index
        }
        
        self.tableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let index = self.index else { return 0 }
        switch index {
        case CellType.food.rawValue:
            return myPerferences?.favoriteFoodDTOs?.count ?? 0
        case CellType.bevegate.rawValue:
            return myPerferences?.favoriteBeverageDTOs?.count ?? 0
        case CellType.newspaper.rawValue:
            return myPerferences?.favoriteReadingDTOs?.count ?? 0
        case CellType.seat.rawValue:
            return myPerferences?.favoriteSeatDTOs?.count ?? 0
        case CellType.lifestyle.rawValue:
            return 0
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let index = self.index else { return 0 }
        switch index {
        case CellType.food.rawValue:
            return myPerferences?.favoriteFoodDTOs?[section].foodDTO?.count ?? 0
        case CellType.bevegate.rawValue:
            return myPerferences?.favoriteBeverageDTOs?[section].beverageDTO?.count ?? 0
        case CellType.newspaper.rawValue:
            return myPerferences?.favoriteReadingDTOs?[section].readingDTO?.count ?? 0
        case CellType.seat.rawValue:
            return 1
        case CellType.lifestyle.rawValue:
            return 0
        default:
            break
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckboxCell", for: indexPath)
        guard let index = self.index else { return UITableViewCell() }
        if let checkBoxCell = cell as? CheckboxCell {
            switch index {
            case CellType.food.rawValue:
                checkBoxCell.lblTitle.text = myPerferences?.favoriteFoodDTOs?[indexPath.section].foodDTO?[indexPath.row].description ?? ""
            case CellType.bevegate.rawValue:
                checkBoxCell.lblTitle.text = myPerferences?.favoriteBeverageDTOs?[indexPath.section].beverageDTO?[indexPath.row].description ?? ""
            case CellType.newspaper.rawValue:
                checkBoxCell.lblTitle.text = myPerferences?.favoriteReadingDTOs?[indexPath.section].readingDTO?[indexPath.row].description ?? ""
            default:
                break
            }
        }
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderCell")
        if let cell = cell as? HeaderCell {
            guard let index = self.index else { return UITableViewCell() }
            switch index {
            case CellType.food.rawValue:
                cell.titleLbl.text = myPerferences?.favoriteFoodDTOs?[section].category ?? ""
            case CellType.bevegate.rawValue:
                cell.titleLbl.text = myPerferences?.favoriteBeverageDTOs?[section].category ?? ""
            case CellType.newspaper.rawValue:
                cell.titleLbl.text = myPerferences?.favoriteReadingDTOs?[section].category ?? ""
            case CellType.seat.rawValue:
                cell.titleLbl.text = myPerferences?.favoriteSeatDTOs?[section].category ?? ""
            case CellType.lifestyle.rawValue:
                break
            default:
                break
            }
            cell.index = index
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 47.0
    }
}
