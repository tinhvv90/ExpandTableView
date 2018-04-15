//
//  HeaderCell.swift
//  VNA
//
//  Created by Tinh Vu on 4/14/18.
//  Copyright © 2018 Tinh Vu. All rights reserved.
//

import UIKit

class HeaderCell: UITableViewHeaderFooterView {

    @IBOutlet weak var titleLbl: UILabel!
    var index: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupColorCell(index: index)
    }
    
    func setupColorCell(index: Int) {
        if index % 2 == 0 {
            backgroundView = UIView()
            backgroundView?.backgroundColor = .white
        } else {
            backgroundView = UIView()
            backgroundView?.backgroundColor = UIColor.init(red: 224/255, green: 242/255, blue: 246/255, alpha: 1.0)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLbl.text = ""
    }
}
