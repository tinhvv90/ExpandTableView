//
//  MyPreferencesTableViewController.swift
//  VNA
//
//  Created by Tinh Vu on 4/14/18.
//  Copyright © 2018 Tinh Vu. All rights reserved.
//

import UIKit

enum CellType: Int {
    case food = 0
    case expandFood
    case bevegate
    case expandBevegate
    case newspaper
    case expandNewspaper
    case seat
    case expandSeat
    case lifestyle
    case expandLifestyle
    
    var index: IndexPath {
        return IndexPath(row: self.rawValue, section: 0)
    }
}

class MyPreferencesTableViewController: UITableViewController {

    var myPerferences : MyPreferencesResponse?
    
    var subCellHeight: CGFloat = 0
    var subFoodActiveCellHeight: CGFloat = 100 {
        didSet {
            tableView.reloadRows(at: [CellType.expandFood.index], with: .none)
        }
    }
    
    var subSeatActiveCellHeight: CGFloat = 100 {
        didSet {
            tableView.reloadRows(at: [CellType.expandSeat.index], with: .none)
        }
    }
    
    var subNewspaperActiveCellHeight: CGFloat = 100 {
        didSet {
            tableView.reloadRows(at: [CellType.expandNewspaper.index], with: .none)
        }
    }
    
    var subLifestyleActiveCellHeight: CGFloat = 100 {
        didSet {
            tableView.reloadRows(at: [CellType.expandLifestyle.index], with: .none)
        }
    }
    
    var subBevegateleActiveCellHeight: CGFloat = 100 {
        didSet {
            tableView.reloadRows(at: [CellType.expandBevegate.index], with: .none)
        }
    }
    
    var isExpandFood = false {
        didSet {
            subCellHeight = isExpandFood ? subFoodActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandFood.index], with: isExpandFood ? .bottom : .top)
        }
    }
    
    var isExpandSeat = false {
        didSet {
            subCellHeight = isExpandSeat ? subSeatActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandSeat.index], with: isExpandSeat ? .bottom : .top)
        }
    }
    
    var isExpandNewspaper = false {
        didSet {
            subCellHeight = isExpandNewspaper ? subNewspaperActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandSeat.index], with: isExpandNewspaper ? .bottom : .top)
        }
    }
    
    var isExpandLifestyle = false {
        didSet {
            subCellHeight = isExpandLifestyle ? subLifestyleActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandLifestyle.index], with: isExpandLifestyle ? .bottom : .top)
        }
    }
    
    var isExpandBevegate = false {
        didSet {
            subCellHeight = isExpandBevegate ? subBevegateleActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandBevegate.index], with: isExpandBevegate ? .bottom : .top)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let path = Bundle.main.path(forResource: "mypreferenceJson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let myPer = try decoder.decode(MyPreferencesResponse.self, from: data)
                myPerferences = myPer
            } catch {
                // handle error
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let checkboxVC = segue.destination as? CheckboxViewController
        checkboxVC?.myPerferences = myPerferences
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case CellType.food.rawValue:
            isExpandFood = !isExpandFood
            isExpandNewspaper = false
            isExpandLifestyle = false
            isExpandBevegate = false
            isExpandSeat = false
        case CellType.seat.rawValue:
            isExpandSeat = !isExpandSeat
            isExpandNewspaper = false
            isExpandLifestyle = false
            isExpandBevegate = false
            isExpandFood = false
        case CellType.bevegate.rawValue:
            isExpandBevegate = !isExpandBevegate
            isExpandNewspaper = false
            isExpandLifestyle = false
            isExpandSeat = false
            isExpandFood = false
        case CellType.lifestyle.rawValue:
            isExpandLifestyle = !isExpandLifestyle
            isExpandNewspaper = false
            isExpandBevegate = false
            isExpandSeat = false
            isExpandFood = false
        case CellType.newspaper.rawValue:
            isExpandNewspaper = !isExpandNewspaper
            isExpandLifestyle = false
            isExpandBevegate = false
            isExpandSeat = false
            isExpandFood = false
        default:
            break
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case CellType.expandFood.rawValue:
            if isExpandFood {
                var count = myPerferences?.favoriteFoodDTOs?.count ?? 0
                for item in (myPerferences?.favoriteFoodDTOs)! {
                    count += (item.foodDTO.flatMap({$0})?.count)!
                }
                return CGFloat(count * 44)
            } else {
                return 0
            }
        case CellType.expandSeat.rawValue:
            if isExpandSeat {
                var count = myPerferences?.favoriteSeatDTOs?.count ?? 0
                for item in (myPerferences?.favoriteSeatDTOs)! {
                    count += (item.airlinesDTO.flatMap({$0})?.count)!
                }
                return CGFloat(count * 44)
            } else {
                return 0
            }
        case CellType.expandBevegate.rawValue:
            if isExpandBevegate {
                var count = myPerferences?.favoriteBeverageDTOs?.count ?? 0
                for item in (myPerferences?.favoriteBeverageDTOs)! {
                    count += (item.beverageDTO.flatMap({$0})?.count)!
                }
                return CGFloat(count * 44)
            } else {
                return 0
            }
        case CellType.expandLifestyle.rawValue:
            return 0
        case CellType.expandNewspaper.rawValue:
            if isExpandNewspaper {
                var count = myPerferences?.favoriteReadingDTOs?.count ?? 0
                for item in (myPerferences?.favoriteReadingDTOs)! {
                    count += (item.readingDTO.flatMap({$0})?.count)!
                }
                return CGFloat(count * 44)
            } else {
                return 0
            }
        default:
            return 55
        }
    }
    
}
