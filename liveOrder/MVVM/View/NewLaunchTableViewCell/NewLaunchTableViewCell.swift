//
//  NewLaunchTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 23/08/21.
//

import UIKit

class NewLaunchTableViewCell: UITableViewCell {
    @IBOutlet weak var newOverView: UIView!
    @IBOutlet weak var newlaunchLbl: UILabel!
    @IBOutlet weak var allOverCityLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var NewLaunchCollVIew: UICollectionView!
    
    var listValue : [NewLaunchlist] = []
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        NewLaunchCollVIew.delegate = self
        NewLaunchCollVIew.dataSource = self
        NewLaunchCollVIew.register(UINib(nibName: "ProductsListofvariantsaftersearchCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"ProductsListofvariantsaftersearchCollCell")
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func order(data : [NewLaunchlist]){
        listValue = data
        
        NewLaunchCollVIew.reloadData()
    }
}
extension NewLaunchTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mostOrderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsListofvariantsaftersearchCollCell", for: indexPath) as! ProductsListofvariantsaftersearchCollCell
    
        mostOrderCell.overAllView.layer.cornerRadius = 8
        
        
        mostOrderCell.madicineNameLbl.text = listValue[indexPath.row].c_contain_name
        mostOrderCell.packSizeLbl.text = listValue[indexPath.row].c_pack_name
        mostOrderCell.containsLbl.text = listValue[indexPath.row].c_item_name
        mostOrderCell.mrpLbl.text =  listValue[indexPath.row].n_max_mrp
        let url = URL(string: listValue[indexPath.row].ac_thumbnail_images!)
     //   let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
       // mostOrderCell.productImgView.image = UIImage(data: data!)
        return mostOrderCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 159, height: 235)
        
        
    }

}
