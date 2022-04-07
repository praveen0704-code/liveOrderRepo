//
//  ProfileTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 05/08/21.
//

import UIKit
protocol proInfoDelegate {
    func prodidselect(type: String)
    
}

class ProfileTableViewCell: UITableViewCell {
    
   
    
    @IBOutlet weak var overAllView: UIView!
    @IBOutlet weak var imageViewLeft: UIImageView!
    @IBOutlet weak var txtLbl: UILabel!
    @IBOutlet weak var imageViewRight: UIImageView!
    @IBOutlet weak var profileCellTableView: UITableView!
    
    
    var delegate:proInfoDelegate?
    var accountinfoList = [String]()
    var branchindex : Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        accountinfoList = ["Profile Information"]
        //accountinfoList = ["Profile Information","Add User","Add Branch","Change Password"]
        profileCellTableView.delegate = self
        profileCellTableView.dataSource = self
        profileCellTableView.register(UINib(nibName: "profileCellTableViewCell", bundle: nil), forCellReuseIdentifier: "profileCellTableViewCell")
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension ProfileTableViewCell : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
        return accountinfoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listcell = tableView.dequeueReusableCell(withIdentifier: "profileCellTableViewCell", for: indexPath)as! profileCellTableViewCell
        listcell.accInfoListLbl.text = accountinfoList[indexPath.row]
        return listcell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            delegate?.prodidselect(type: "0")
            
        }
        
    }
}
