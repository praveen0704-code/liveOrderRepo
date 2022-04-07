//
//  CreditDebitCardsVC.swift
//  liveOrder
//
//  Created by Data Prime on 02/09/21.
//

import UIKit

class CreditDebitCardsVC: UIViewController {
    @IBOutlet weak var creditTableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var creditLbl: UILabel!
    @IBOutlet weak var manageLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup(){
        topView.clipsToBounds = true
        topView.layer.cornerRadius = 30
        topView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        topView.applyGradient(colours: [UIColor(hexString: "#674CF3"),UIColor(hexString:"#8039DB")])
        
        creditTableView.dataSource = self
        creditTableView.delegate = self
    }
    @IBAction func backBtnAct(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(vc!, animated: true)
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
extension CreditDebitCardsVC:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            creditTableView.register(UINib(nibName: "AddNewCardTableCell", bundle: nil), forCellReuseIdentifier: "AddNewCardTableCell")

                let addCardCell = tableView.dequeueReusableCell(withIdentifier: "AddNewCardTableCell", for: indexPath)as! AddNewCardTableCell
           
           
                return addCardCell
                
            }
        if indexPath.row == 1 {
            creditTableView.register(UINib(nibName: "CardOneTableCelll", bundle: nil), forCellReuseIdentifier: "CardOneTableCelll")

                let cardOnecell = tableView.dequeueReusableCell(withIdentifier: "CardOneTableCelll", for: indexPath)as! CardOneTableCelll
           
            
           
                return cardOnecell
                
            }
        if indexPath.row == 2 {
            creditTableView.register(UINib(nibName: "CardTwoTableCell", bundle: nil), forCellReuseIdentifier: "CardTwoTableCell")

                let paycell = tableView.dequeueReusableCell(withIdentifier: "CardTwoTableCell", for: indexPath)as! CardTwoTableCell
           
            return paycell
           
    }
        if indexPath.row == 3 {
            creditTableView.register(UINib(nibName: "AddNewCardCell", bundle: nil), forCellReuseIdentifier: "AddNewCardCell")

                let paycell = tableView.dequeueReusableCell(withIdentifier: "AddNewCardCell", for: indexPath)as! AddNewCardCell
           
            return paycell
           
    }
        return UITableViewCell()
}


}
