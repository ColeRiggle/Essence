//
//  TodayCell.swift
//  Essence
//
//  Created by Cole Riggle on 11/24/20.
//

import UIKit

class EssenceCell: UITableViewCell {
    
    var delegate: EssenceCellDelegate?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Creates spacing between cells / border around each cell
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 12, left: 12, bottom: 0, right: 12))
        contentView.backgroundColor = UIColor.Application.General.foreground
        contentView.layer.cornerRadius = 6
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        delegate?.setSelected(cell: self)
    }
}

protocol EssenceCellDelegate {
    func setSelected(cell: EssenceCell)
}
