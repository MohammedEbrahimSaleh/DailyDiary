//
//  memoriesTableViewCell.swift
//  new
//
//  Created by IOS on 3/21/19.
//  Copyright © 2019 IOS. All rights reserved.
//

import UIKit


// delegate for deleteing and editting
protocol DataCollection {
    func editCell(index:Int)
    func deleteCell(index:Int)
}

class memoriesTableViewCell: UITableViewCell {

    
    
     // outlets
    @IBOutlet weak var memoryTitle: UILabel!
    @IBOutlet weak var memoryDate: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
