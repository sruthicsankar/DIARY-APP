//
//  DiaryCell.swift
//  DIARY APP
//
//  Created by sruthi on 20/12/21.
//

import UIKit

class DiaryCell: UITableViewCell {

    @IBOutlet weak var vwTimeTop: UIView!
    @IBOutlet weak var vwContentContainer: UIView!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblTime1: UILabel!
    @IBOutlet weak var lblTime2: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func addShadow() {
        let col = 225.0/255.0
        self.vwContentContainer.layer.shadowColor = UIColor.init(red: col, green: col, blue: col, alpha: 1.0).cgColor
        self.vwContentContainer.layer.shadowOpacity = 1
        self.vwContentContainer.layer.shadowOffset = .zero
        self.vwContentContainer.layer.shadowRadius = 5
        self.vwContentContainer.layer.cornerRadius = 3.0

    }
    
    func assignDiaryModel(_ diary: DiaryModel) {
        self.lblTitle.text = diary.title?.uppercased()
        self.lblContent.text = diary.content
        self.lblTime2.text = diary.getTime()
        
    }
    
}
