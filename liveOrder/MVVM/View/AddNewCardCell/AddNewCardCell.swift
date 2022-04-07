//
//  AddNewCardCell.swift
//  liveOrder
//
//  Created by Data Prime on 03/09/21.
//

import UIKit

class AddNewCardCell: UITableViewCell {
    @IBOutlet weak var txtfield: UITextField!
    let datePicker = UIDatePicker()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        showDatePicker()
    }
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date

       //ToolBar
       let toolbar = UIToolbar();
       toolbar.sizeToFit()
       let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
      let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

     toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

        txtfield.inputAccessoryView = toolbar
        txtfield.inputView = datePicker

     }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM"
        txtfield.text = formatter.string(from: datePicker.date)
      self.contentView.endEditing(true)
    }
    @objc func cancelDatePicker(){
        self.contentView.endEditing(true)
      }
    }

