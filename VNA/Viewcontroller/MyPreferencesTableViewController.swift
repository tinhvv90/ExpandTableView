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

let NotificationIndexOfCellType = "NotificationIndexOfCellType"

struct SegueIdentifier {
    static let embedFood            = "food"
    static let embedBevegate        = "bevagate"
    static let embedNewspaper       = "newspaper"
    static let embedSeat            = "seat"
    static let embedLifeStyle       = "lifeStyle"
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
            if isExpandFood {
                self.isExpandBevegate = false
                self.isExpandNewspaper = false
                self.isExpandSeat = false
                self.isExpandLifestyle = false
            }
        }
    }
    
    var isExpandBevegate = false {
        didSet {
            subCellHeight = isExpandBevegate ? subBevegateleActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandBevegate.index], with: isExpandBevegate ? .bottom : .top)
            if isExpandBevegate {
                self.isExpandFood = false
                self.isExpandLifestyle = false
                self.isExpandNewspaper = false
                self.isExpandSeat = false
            }
        }
    }
    
    var isExpandNewspaper = false {
        didSet {
            subCellHeight = isExpandNewspaper ? subNewspaperActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandSeat.index], with: isExpandNewspaper ? .bottom : .top)
            if isExpandNewspaper {
                self.isExpandSeat = false
                self.isExpandBevegate = false
                self.isExpandFood = false
                self.isExpandLifestyle = false
            }
        }
    }
    
    var isExpandSeat = false {
        didSet {
            subCellHeight = isExpandSeat ? subSeatActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandSeat.index], with: isExpandSeat ? .bottom : .top)
            if isExpandSeat {
                self.isExpandFood = false
                self.isExpandBevegate = false
                self.isExpandLifestyle = false
                self.isExpandNewspaper = false
            }
        }
    }
    
    var isExpandLifestyle = false {
        didSet {
            subCellHeight = isExpandLifestyle ? subLifestyleActiveCellHeight : 0
            tableView.reloadRows(at: [CellType.expandLifestyle.index], with: isExpandLifestyle ? .bottom : .top)
            if isExpandLifestyle {
                self.isExpandFood = false
                self.isExpandBevegate = false
                self.isExpandNewspaper = false
                self.isExpandSeat = false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setupTableView() {
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
        self.isExpandFood = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        self.setupTableView()
        super.prepare(for: segue, sender: sender)
        let checkboxVC = segue.destination as? CheckboxViewController
        checkboxVC?.myPerferences = myPerferences
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case CellType.food.rawValue:
            isExpandFood = !isExpandFood
        case CellType.bevegate.rawValue:
            isExpandBevegate = !isExpandBevegate
        case CellType.newspaper.rawValue:
            isExpandNewspaper = !isExpandNewspaper
        case CellType.seat.rawValue:
            isExpandSeat = !isExpandSeat
        case CellType.lifestyle.rawValue:
            isExpandLifestyle = !isExpandLifestyle
        default:
            break
        }
        NotificationCenter.default.post(name: NSNotification.Name.init(NotificationIndexOfCellType), object: indexPath.row)
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
        case CellType.expandBevegate.rawValue:
            if isExpandBevegate {
                var count = myPerferences?.favoriteBeverageDTOs?.count ?? 0
                for item in (myPerferences?.favoriteBeverageDTOs)! {
                    count += (item.beverageDTO.flatMap({$0})?.count)!
                }
                subBevegateleActiveCellHeight = CGFloat(count * 44)
                return subBevegateleActiveCellHeight
            } else {
                return 0
            }
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
        case CellType.expandLifestyle.rawValue:
            return 0
        default:
            return 55
        }
    }
}

