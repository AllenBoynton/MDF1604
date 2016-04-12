//
//  AlertViewController.swift
//  UITableViews_Continued
//
//  Created by Allen Boynton on 4/10/16.
//  Copyright © 2016 Full Sail. All rights reserved.
//

import UIKit
@objc protocol CellDelegate {
    
    func deleteCell(cell:CustomCommentCell)
}

class CustomCommentCell: UITableViewCell {
    
    @IBOutlet weak var deleteButton: UIButton!  //a delete button
    weak var delegate:CellDelegate?   //declare a delegate
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?)
    {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)!
    }
    
    @IBAction func button_clicked(sender: AnyObject) {
        self.delegate?.deleteCell(self) //call the delegat method
}
