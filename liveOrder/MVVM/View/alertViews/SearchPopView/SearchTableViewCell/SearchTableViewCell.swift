//
//  SearchTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 23/07/21.
//

import UIKit



class SearchTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var searchLabel: UILabel!
    @IBOutlet weak var searchTxtField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.searchTxtField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func textFielddt() {
        searchTxtField.resignFirstResponder()
    }
    
    
    
}
extension SearchTableViewCell:UITextFieldDelegate{
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cell: UITableViewCell = textField.superview?.superview as! SearchTableViewCell
        let table: UITableView = cell.superview as! UITableView
        let textFieldIndexPath = table.indexPath(for: cell)
        multiSearchArray[textFieldIndexPath!.row] = textField.text ?? ""
        print(multiSearchArray)
     //   if textFieldIndexPath!.row == 0{
            multiSearchArray[textFieldIndexPath!.row] = textField.text ?? ""
            print(multiSearchArray)
            
        //}
        
        
    }
}


