//
//  TodayCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class TodayCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Creates spacing between cells
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
        contentView.backgroundColor = UIColor.Application.General.foreground
        contentView.layer.cornerRadius = 6
    }
}
