//
//  ErrorpageVC.swift
//  liveOrder
//
//  Created by Data Prime on 03/07/21.
//

import UIKit

class ErrorpageVC: UIViewController {
    @IBOutlet weak var oopsTxtLbl: UILabel!
    @IBOutlet weak var errorTxtLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    
    func setup(){
        oopsTxtLbl.attributedText = fontchangeAttribtre(bFontNameStr: "Quicksand-Medium", bFontColorStr: UIColor(hexString: "#ff7b20"), bFontSizeFloat: 13.0, bStr:
                                                                "", rFontNameStr: "Quicksand-Medium", rFontColorStr: UIColor(hexString: "2e3e6a"), rFontSizeFloat: 20, rStr: "Oops!")
        
        
    }
    /*
    // MARK: - Navigation
     OpenSans-Regular
     The page You are looking for
     doesn't exist!
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
