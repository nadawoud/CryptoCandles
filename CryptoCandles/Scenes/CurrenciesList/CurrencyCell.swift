//
//  CurrencyCell.swift
//  CryptoCandles
//
//  Created by Nada Yehia Dawoud on 29/10/2022.
//

import UIKit

class CurrencyCell: UITableViewCell {
    
    static let identifier =  String(describing: CurrencyCell.self)
    
    @IBOutlet var currencyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
}
