//
//  SmartOrderVC.swift
//  liveOrder
//
//  Created by Data Prime on 11/09/21.
//

import UIKit

class SmartOrderVC: UIViewController {
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var wishListImg: UIImageView!
    @IBOutlet weak var cartImg: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var frequenlyLbl: UILabel!
    @IBOutlet weak var allProductLbl: UILabel!
    @IBOutlet weak var itemLbl: UILabel!
    @IBOutlet weak var smartOrderLbl: UILabel!
    @IBOutlet weak var smartOrderCollView: UICollectionView!
    
    @IBOutlet weak var bottomView: UIView!
    
    
    var index : [Int] = []
    var prodctarry = ["1","2","3","4","5","6","7","8","9"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        let cellSize = CGSize(width:screenWidth/2 - 10 , height:285)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        smartOrderCollView.setCollectionViewLayout(layout, animated: true)
        
        smartOrderCollView.reloadData()
        setup()
        
    }
    func setup(){
        
        bottomView.backgroundColor = .white
        //        bottomView.layer.borderColor = .white
        //        bottomView.layer.borderWidth = 1
        bottomView.clipsToBounds = true
        bottomView.layer.cornerRadius = 30
        bottomView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        self.bottomView.dropShadow()
        
        smartOrderCollView.dataSource = self
        smartOrderCollView.delegate = self
        
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        smartOrderCollView.register(UINib(nibName: "SmartOrderCollCell", bundle: Bundle.main), forCellWithReuseIdentifier: "SmartOrderCollCell")
    }
    @IBAction func fillterBtn(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PLPFiltterVc") as? PLPFiltterVc
        vc!.smartorder = 1
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func wishLIstBtnAct(_ sender: Any) {
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoHomeViewController") as? LoHomeViewController
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func cartBtnAct(_ sender: Any) {
    }
    @IBAction func flitterBtnAct(_ sender: Any) {
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
extension SmartOrderVC : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prodctarry.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let productListCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SmartOrderCollCell", for: indexPath) as! SmartOrderCollCell
        
        productListCell.overView.layer.cornerRadius = 5
        productListCell.redBtn.isHidden = true
        
        
        return productListCell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }
    
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //            let padding: CGFloat =  50
    //            let collectionViewSize = collectionView.frame.size.width - padding
    //
    //            return CGSize(width: 100, height: 100)
    //        }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return  2
    }
    
    
    
    
}

