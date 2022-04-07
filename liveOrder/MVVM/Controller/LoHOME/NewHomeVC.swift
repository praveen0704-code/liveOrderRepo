//
//  NewHomeVC.swift
//  liveOrder
//
//  Created by Data Prime on 04/08/21.
//

import UIKit

class NewHomeVC: UIViewController ,searchDelegate{
    func onPizzaReady(type: String) {
        print(type)
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SearchWithListFeatureProductVC") as? SearchWithListFeatureProductVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
//        self.present(vc!, animated: true, completion: nil)
        
    }
    @IBOutlet weak var topBlueView: UIView!
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var shortBookBtn: UIButton!
    @IBOutlet weak var cartBtn: UIButton!
    @IBOutlet weak var profileBtn: UIButton!
    //SEARCH VIEW OUTLET
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchImgBtn: UIButton!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var scanBtn: UIButton!
    @IBOutlet weak var mikeBtn: UIButton!
    @IBOutlet weak var searchTxtFiled: UITextField!
    
    // SCROLLVIEW OUTLET
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollOverView: UIView!
    // TOP OFFER COLL VIEW
    @IBOutlet weak var topOfferCollView: UICollectionView!
    @IBOutlet weak var topOfferBannerimgview: UIImageView!
    
    //MOST ORDER VIEW
    @IBOutlet weak var mostOrderedView: UIView!
    @IBOutlet weak var mostOrderedLbl: UILabel!
    @IBOutlet weak var mostOrderCityLbl: UILabel!
    @IBOutlet weak var mostOrderCollView: UICollectionView!
    @IBOutlet weak var mostOrderViewAllBtn: UIButton!
    
    // NEW LAUNCHES VIEW
    @IBOutlet weak var newLanchesView: UIView!
    @IBOutlet weak var newLanchesLbl: UILabel!
    @IBOutlet weak var newLanchesCityLbl: UILabel!
    @IBOutlet weak var newLanchesCollView: UICollectionView!
    @IBOutlet weak var newLanchesViewAllBtn: UIButton!
    
    // SHOP BY MANIFACTURE VIEW
    @IBOutlet weak var shopByManifactureView: UIView!
    @IBOutlet weak var shopByManifactureLbl: UILabel!
    @IBOutlet weak var bestManifactureLbl: UILabel!
    @IBOutlet weak var shopByManifactureCollView: UICollectionView!
    @IBOutlet weak var ShopByManifactureViewAllBtn: UIButton!
    
    //LIMITED PERIOD OFFER VIEW
    @IBOutlet weak var limitedPeriodOfferView: UIView!
    @IBOutlet weak var limitedperiodLbl: UILabel!
    @IBOutlet weak var pickTheBestOfferLbl: UILabel!
    @IBOutlet weak var limitedPeriodOfferCollView: UICollectionView!
    @IBOutlet weak var limitedPeriodViewAllBtn: UIButton!
    // c-SQUERE HELPS YOU VIEW
    
    @IBOutlet weak var csquareHelpView: UIView!
    @IBOutlet weak var cSquareHelpLbl: UILabel!
    @IBOutlet weak var cSquarepickBestOfferLbl: UILabel!
    @IBOutlet weak var cSquareViewAllBtn: UIButton!
    @IBOutlet weak var cSquareCollView: UICollectionView!
   
    let searchViewpopup = UINib(nibName: "SearchPopView", bundle:
                        nil).instantiate(withOwner: nil, options: nil)[0] as? SearchPopView
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchViewpopup?.delegate = self
        searchViewpopup!.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        self.view.addSubview(searchViewpopup!)
        setup()
    }
    
    func setup(){
        
        topBlueView.clipsToBounds = true
        topBlueView.layer.cornerRadius = 30
        topBlueView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]

        topOfferCollView.delegate = self
        topOfferCollView.dataSource = self
        
        mostOrderCollView.delegate = self
        mostOrderCollView.dataSource = self
        
        newLanchesCollView.delegate = self
        newLanchesCollView.dataSource = self
        
        shopByManifactureCollView.delegate = self
        shopByManifactureCollView.dataSource = self
        
        limitedPeriodOfferCollView.delegate = self
        limitedPeriodOfferCollView.dataSource =  self
        
        cSquareCollView.delegate = self
        cSquareCollView.dataSource = self


        searchTxtFiled.delegate = self
        

        searchView.layer.cornerRadius = 5
        topBlueView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection =  .horizontal//.vertical
//        layout.minimumLineSpacing = 20
//        layout.minimumInteritemSpacing = 20
   
        topOfferCollView.register(UINib(nibName: "PrductBannerCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"PrductBannerCollectionViewCell")
        

        mostOrderCollView.register(UINib(nibName: MostOrderedProductColllectionCell, bundle: Bundle.main), forCellWithReuseIdentifier:MostOrderedProductColllectionCell)
        
        newLanchesCollView.register(UINib(nibName: productlistVariantscelidentifreStr, bundle: Bundle.main), forCellWithReuseIdentifier:productlistVariantscelidentifreStr)
        
        shopByManifactureCollView.register(UINib(nibName: "ImgCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"ImgCollectionViewCell")
        

        limitedPeriodOfferCollView.register(UINib(nibName: "LimitedPeriodCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"LimitedPeriodCollectionViewCell")
        cSquareCollView.register(UINib(nibName: "CsquareCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier:"CsquareCollectionViewCell")
        
       
    }
        
        

}
extension NewHomeVC : UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topOfferCollView{
            let ShapeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrductBannerCollectionViewCell", for: indexPath) as! PrductBannerCollectionViewCell
            
            
            return ShapeCell
        }
        else if collectionView == mostOrderCollView {
            let topcell = collectionView.dequeueReusableCell(withReuseIdentifier: MostOrderedProductColllectionCell, for: indexPath) as! MostOrderedProductCollCell
         
            
            return topcell

        }
       
        
        else if collectionView == newLanchesCollView {
            let newLaunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: productlistVariantscelidentifreStr, for: indexPath) as! ProductsListofvariantsaftersearchCollCell
    
           
            newLaunchCell.offerBtn.isHidden = true
            
            return newLaunchCell
        }
        else if collectionView == shopByManifactureCollView {
            
            let shopCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImgCollectionViewCell", for: indexPath) as! ImgCollectionViewCell
            shopCell.imgGView.image = UIImage(named: "1280_px_abbott_laboratories_svg")

            shopCell.layer.borderColor = hexStringToUIColor(hex: "#c3cde4").cgColor

            shopCell.layer.borderWidth = 0.5

            shopCell.layer.cornerRadius = 5
            
            return shopCell

        }
        else if collectionView == limitedPeriodOfferCollView {
            let newLaunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LimitedPeriodCollectionViewCell", for: indexPath) as! LimitedPeriodCollectionViewCell
       
           
           
            
            return newLaunchCell
        }
        else if collectionView == cSquareCollView{
            let pBCollnCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CsquareCollectionViewCell", for: indexPath) as! CsquareCollectionViewCell
        
            pBCollnCell.layer.cornerRadius = 10
            
            pBCollnCell.layer.masksToBounds = true
            
         
           
            return pBCollnCell
        }
       

        
        else{
            let ShapeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrductBannerCollectionViewCell", for: indexPath) as! PrductBannerCollectionViewCell
            
            ShapeCell.DiscountLabel.text = "Manage your store inventory,Stock & Sales, Billing, Rack Management etc..."
            ShapeCell.offerVAlidatyLabel.isHidden = true
            ShapeCell.offerLabel.isHidden = true
            return ShapeCell
        }
        
    }
 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)//here your custom value for spacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing

        return CGSize(width:widthPerItem, height:250)
    }
    
    }
    
extension NewHomeVC : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {    //delegate method
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LcMainSearchVC") as? LcMainSearchVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
       
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {//delegate method
        textField.resignFirstResponder()
        if textField.text?.count == 0 {
          
            
        }
        return false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
      textField.resignFirstResponder()

        return true
    }
}

