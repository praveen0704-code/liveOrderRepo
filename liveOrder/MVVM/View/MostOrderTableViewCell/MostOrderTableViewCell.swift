//
//  MostOrderTableViewCell.swift
//  liveOrder
//
//  Created by Data Prime on 23/08/21.
//

import UIKit
protocol mostOrder {
    func share(date: String)
}
class MostOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var mostOverView: UIView!
    @IBOutlet weak var topOrderbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var topOrderCollView: UICollectionView!
    var delegate: mostOrder!
    
    var listValue : [MostOrderList] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        topOrderCollView.delegate = self
        topOrderCollView.dataSource = self
        topOrderCollView.register(UINib(nibName: "MostOrderedProductCollCell", bundle: Bundle.main), forCellWithReuseIdentifier:"MostOrderedProductCollCell")

    }
    @IBAction func viewAllBtnAct(_ sender: Any) {
        delegate.share(date: "hi")
    }
    func order(data : [MostOrderList]){
        listValue = data
        
        topOrderCollView.reloadData()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension MostOrderTableViewCell : UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listValue.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let mostOrderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MostOrderedProductCollCell", for: indexPath) as! MostOrderedProductCollCell
        mostOrderCell.overallView.layer.cornerRadius = 8
        mostOrderCell.productName.text = listValue[indexPath.row].c_contain_name
        mostOrderCell.PakageSize.text = listValue[indexPath.row].c_pack_name
        mostOrderCell.containsName.text = listValue[indexPath.row].c_item_name
        mostOrderCell.mrpLbl.text =  listValue[indexPath.row].n_max_mrp
        let url = URL(string: listValue[indexPath.row].ac_thumbnail_images!)
      //  let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
    //    mostOrderCell.productImgView.image = UIImage(data: data!)
        
        return mostOrderCell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        return CGSize(width: 159, height: 260)
        
        
    }

}
