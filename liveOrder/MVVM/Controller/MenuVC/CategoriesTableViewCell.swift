//
//  CategoriesTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 25/08/21.
//


import UIKit
import Alamofire


protocol catHeightDelegate{
    func catHeight(heightCat: CGFloat)
    func didselectCode(itemCode:String,name:String)
}
class CategoriesTableViewCell: UITableViewCell {
    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var leftImage: UIImageView!
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var categoriesLbl: UILabel!
    @IBOutlet weak var categoriesTableView: UITableView!
    @IBOutlet weak var lineViewTop: UIView!
    @IBOutlet weak var lineViewBottom: UIView!
    @IBOutlet weak var topLineHeight: NSLayoutConstraint!
   
    @IBOutlet weak var tableHeightConstrain: NSLayoutConstraint!
    
    @IBOutlet weak var allProductBtn: UIButton!
    
    var delegate : catHeightDelegate?
    
    var categoryListmodelc: CategoryListModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        categoriesTableView.dataSource = self
        categoriesTableView.delegate = self
       // categoryListapi()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
    }
    override func layoutSubviews() {
        self.categoriesTableView.reloadData()
        print(self.categoriesTableView.contentSize.height)
        self.tableHeightConstrain.constant = categoriesTableView.contentSize.height
        self.categoriesTableView.layoutSubviews()
       
      
    }

    
}
extension CategoriesTableViewCell : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryListmodelc?.payloadJson?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        categoriesTableView.register(UINib(nibName: "CategoriesListCell", bundle: nil), forCellReuseIdentifier: "CategoriesListCell")

            let listCell = tableView.dequeueReusableCell(withIdentifier: "CategoriesListCell", for: indexPath)as! CategoriesListCell
            listCell.listLbl.text = categoryListmodelc?.payloadJson?.data?[indexPath.row].cName
        delegate?.catHeight(heightCat: CGFloat(categoriesTableView.contentSize.height))
            return listCell
            
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didselectCode(itemCode: categoryListmodelc?.payloadJson?.data?[indexPath.row].cCode ?? "", name: categoryListmodelc?.payloadJson?.data?[indexPath.row].cName ?? "" )
    }
    
    
}

