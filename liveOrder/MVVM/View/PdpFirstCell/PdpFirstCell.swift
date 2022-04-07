//
//  PdpFirstCell.swift
//  liveOrder
//
//  Created by Data Prime on 04/09/21.
//

import UIKit

class PdpFirstCell: UITableViewCell, UIScrollViewDelegate {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var productNameLbl: UILabel!
    @IBOutlet weak var mfgLbl: UILabel!
    @IBOutlet weak var containsLbl: UILabel!
    @IBOutlet weak var hsnCodeLbl: UILabel!
    @IBOutlet weak var microLabLbl: UILabel!
    @IBOutlet weak var containNameLbl: UILabel!
    @IBOutlet weak var shareBtn: UIButton!
    @IBOutlet weak var scrollView: UIView!
    @IBOutlet weak var shortBookBtn: UIButton!
    @IBOutlet weak var wishListBtn: UIButton!
    @IBOutlet weak var mrpLbl: UILabel!
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var packagingLbl: UILabel!
    @IBOutlet weak var selectSizeLbl: UILabel!
    @IBOutlet weak var selectSizeAnsLbl: UILabel!
    @IBOutlet weak var mlOneBtn: UIButton!
    @IBOutlet weak var mlTwoBtn: UIButton!
    
    @IBOutlet weak var pakageTxtLbl: UILabel!
    @IBOutlet weak var gstNumberLbl: UILabel!
    @IBOutlet weak var mrpNumberLbl: UILabel!
    @IBOutlet weak var hsnNumber: UILabel!
    let scrlView = UIScrollView(frame: CGRect(x:0, y:20, width:350,height: 200))
    var colors:[UIColor] = [UIColor.red, UIColor.blue, UIColor.green, UIColor.yellow]
    var imgframe: CGRect = CGRect(x:0, y:0, width:0, height:0)
    var pageControl : UIPageControl = UIPageControl(frame: CGRect(x:55,y: 220, width:200, height:50))
    
    let immarr = ["dolo","introimg","introsecimg"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        shortBookBtn.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        shortBookBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        shortBookBtn.layer.shadowOpacity = 1.0
        shortBookBtn.layer.shadowRadius = 0.0
        shortBookBtn.layer.masksToBounds = false
        shortBookBtn.layer.cornerRadius = shortBookBtn.frame.width / 2
        scrollView.backgroundColor = .white
        wishListBtn.layer.shadowColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        //(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        wishListBtn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        wishListBtn.layer.shadowOpacity = 1.0
        wishListBtn.layer.shadowRadius = 0.0
        wishListBtn.layer.masksToBounds = false
        wishListBtn.layer.cornerRadius = wishListBtn.frame.width / 2
        
        
        scrollView.backgroundColor = .white
        scrlView.delegate = self
        scrlView.isPagingEnabled = true
        scrlView.showsHorizontalScrollIndicator = false
    
        self.scrollView.addSubview(scrlView)
        
        configurePageControl()
        for index in 0..<immarr.count {

            frame.origin.x = self.scrlView.frame.size.width * CGFloat(index)
            frame.size =  self.scrlView.frame.size

            let subView = UIImageView(frame: frame)
            subView.contentMode = .scaleAspectFit
            subView.image = UIImage(named: immarr[index])
            self.scrlView .addSubview(subView)
        }
        self.scrlView.contentSize = CGSize(width:self.scrlView.frame.size.width * 4,height: self.scrlView.frame.size.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = immarr.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        self.scrollView.addSubview(pageControl)

    }

    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrlView.frame.size.width
        scrlView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {

        let pageNumber = round(scrlView.contentOffset.x / scrlView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    @IBAction func mlTwoBtnAct(_ sender: Any) {
    }
    @IBAction func mlOneBtnAct(_ sender: Any) {
    }
    @IBAction func wishListBtnAct(_ sender: Any) {
    }
    @IBAction func shortBookBtnAct(_ sender: Any) {
    }
    @IBAction func shareBtnAct(_ sender: Any) {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
