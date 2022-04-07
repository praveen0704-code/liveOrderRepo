
import Foundation
import UIKit

extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard
            let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
            else { fatalError("missing expected nib named: \(name)") }
        guard
            /// we're using `first` here because compact map chokes compiler on
            /// optimized release, so you can't use two views in one nib if you wanted to
            /// and are now looking at this
            let view = nib.first as? Self
            else { fatalError("view of type \(Self.self) not found in \(nib)") }
        return view
    }
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor(hexString: "dbdbdb", alpha: 0.50).cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    
    func updateConstraint(attribute: NSLayoutConstraint.Attribute, constant: CGFloat) -> Void {
        if let constraint = (self.constraints.filter{$0.firstAttribute == attribute}.first) {
            constraint.constant = constant
            self.layoutIfNeeded()
        }
    }
    // Example use: myView.addBorder(toSide: .Left, withColor: UIColor.redColor().CGColor, andThickness: 1.0)
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        
        layer.addSublayer(border)
    }
    @discardableResult
        func applyGradient(colours: [UIColor]) -> CAGradientLayer {
            return self.applyGradient(colours: colours, locations: nil)
        }

        @discardableResult
        func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
//            gradient.locations = locations
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            self.layer.insertSublayer(gradient, at: 0)
            return gradient
        }
    
    @discardableResult
        func applyTopGradient(colours: [UIColor]) -> CAGradientLayer {
            return self.applyGradient(colours: colours, locations: nil)
        }

        @discardableResult
        func applyTopGradient(colours: [UIColor], locations: [NSNumber]?) -> CAGradientLayer {
            let gradient: CAGradientLayer = CAGradientLayer()
            gradient.frame = self.bounds
            gradient.colors = colours.map { $0.cgColor }
//            gradient.locations = locations
            gradient.startPoint = CGPoint(x: 0.5, y: 0)
                        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
            self.layer.insertSublayer(gradient, at: 0)
            return gradient
        }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
         let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
         let mask = CAShapeLayer()
         mask.path = path.cgPath
         layer.mask = mask
          }
     

     func dropShadowColor(shadowColor:UIColor) {
            layer.masksToBounds = false
            layer.shadowColor = shadowColor.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowOffset = CGSize(width: -1, height: 1)
            layer.shadowRadius = 1
            layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
                  layer.shouldRasterize = true
            layer.rasterizationScale = UIScreen.main.scale
    }
    
    func showToast(message : String, view: UIView) {
        let toastLabel = UILabel(frame: CGRect(x: 8, y: view.frame.size.height-125, width: view.frame.size.width - 16, height: 60))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "SF-UI-Display-Bold", size: 11)
        toastLabel.text = message
        toastLabel.numberOfLines = 2
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 5;
        toastLabel.clipsToBounds  =  true
        view.addSubview(toastLabel)
        UIView.animate(withDuration: 5.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    
    }
    func showBlurLoader() {
        let blurLoader = BlurLoader(frame: frame)
        self.addSubview(blurLoader)
    }
     
    func removeBluerLoader() {
        if let blurLoader = subviews.first(where: { $0 is BlurLoader }) {
            blurLoader.removeFromSuperview()
        }
    }
}
//MARK: - UIView
@IBDesignable
class DashedLineView : UIView {
    @IBInspectable var perDashLength: CGFloat = 6.0
    @IBInspectable var spaceBetweenDash: CGFloat = 3.0
    @IBInspectable var dashColor: UIColor = UIColor.init(hexString: "93a4b8", alpha: 0.20)


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let  path = UIBezierPath()
        if height > width {
            let  p0 = CGPoint(x: self.bounds.midX, y: self.bounds.minY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.midX, y: self.bounds.maxY)
            path.addLine(to: p1)
            path.lineWidth = width

        } else {
            let  p0 = CGPoint(x: self.bounds.minX, y: self.bounds.midY)
            path.move(to: p0)

            let  p1 = CGPoint(x: self.bounds.maxX, y: self.bounds.midY)
            path.addLine(to: p1)
            path.lineWidth = height
        }

        let  dashes: [ CGFloat ] = [ perDashLength, spaceBetweenDash ]
        path.setLineDash(dashes, count: dashes.count, phase: 0.0)

        path.lineCapStyle = .butt
        dashColor.set()
        path.stroke()
    }

    private var width : CGFloat {
        return self.bounds.width
    }

    private var height : CGFloat {
        return self.bounds.height
    }
}
@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}



//MARK: - TextField Properties

extension UITextField{
    @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    override var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    override var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
}
//MARK: - Button Properties

extension UIButton{
     @IBInspectable
    override var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    override var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    override var borderColor: UIColor? {
        get {
            let color = UIColor.init(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = 0.4
            layer.shadowRadius = shadowRadius
        }
    }
}

@IBDesignable
class DesignableUITextField: UITextField {
    override class func appearance() -> Self {
        UITextField.appearance().tintColor = UIColor(hexString: "5b636a")
        return appearance()
    }
    private var kAssociationKeyMaxLength: Int = 0
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
    // Provides left padding for images
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            
                  let imgSearchs =  UIImageView()
            var viewss = UIView()
            var emptyView = UIView()
            imgSearchs.frame = CGRect(x:24  , y: 16, width:  12, height: 16)
            imgSearchs.contentMode = .scaleAspectFill
            viewss = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 52))
            emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 52))

            imgSearchs.image = image
            emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
            
            emptyView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.9725490196, blue: 0.9921568627, alpha: 1)
            emptyView.addSubview(imgSearchs)
           
            viewss.addSubview(emptyView)
            

           
            //imgSearchs.tintColor = color
            leftView = viewss
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
//        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    var change : Bool = false {
        didSet {
            textColor = change ? UIColor.black : UIColor.black
           // backgroundColor = change ? .blue : .white
        }
    }
}

@IBDesignable
class DesignableUITextFieldWithoutColor: UITextField {
    private var kAssociationKeyMaxLength: Int = 0
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
    // Provides left padding for images
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            
                  let imgSearchs =  UIImageView()
            var viewss = UIView()
            var emptyView = UIView()
            imgSearchs.frame = CGRect(x:24  , y: 16, width:  12, height: 16)
            imgSearchs.contentMode = .scaleAspectFill
            viewss = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 52))
            emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 52))

            imgSearchs.image = image
            emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
            
            emptyView.backgroundColor = color
            emptyView.addSubview(imgSearchs)

            viewss.addSubview(emptyView)
            

           
            //imgSearchs.tintColor = color
            leftView = viewss
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
 
    }
    var change : Bool = false {
        didSet {
            textColor = change ? UIColor.black : UIColor.black
           // backgroundColor = change ? .blue : .white
        }
    }
    
}




import UIKit
extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    class func setGreyBorderColor()->UIColor
    {
        return UIColor(red: 218/255.0, green: 223/255.0, blue: 230/255.0, alpha: 1.0)
    }

}
//MARK: - label Attribute Change


func fontchangeAttribtre(bFontNameStr:String,bFontColorStr:UIColor,bFontSizeFloat:Float,bStr:String,rFontNameStr:String,rFontColorStr:UIColor,rFontSizeFloat:Float,rStr:String) -> NSAttributedString{
    let boldAttribute = [
        NSAttributedString.Key.font: UIFont(name: bFontNameStr, size: CGFloat(bFontSizeFloat))!,
          NSAttributedString.Key.foregroundColor:bFontColorStr
       ]
       let regularAttribute = [
        NSAttributedString.Key.font: UIFont(name: rFontNameStr, size: CGFloat(rFontSizeFloat))!
       ]
       let boldText = NSAttributedString(string: bStr, attributes: boldAttribute)
    
       let regularText = NSAttributedString(string: rStr, attributes: regularAttribute)
       let newString = NSMutableAttributedString()
        newString.append(regularText)
        newString.append(boldText)
    
    return newString
}

func fonntBoldAttribute(fullStr:String,boldStr:String,fullColor:UIColor,boldColor:UIColor,fullStringfSize:CGFloat,boldStrSize:CGFloat)->NSAttributedString{
    
    let longestWordRange = (fullStr as NSString).range(of: boldStr)

    let attributedString = NSMutableAttributedString(string: fullStr, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fullStringfSize)])

    attributedString.setAttributes([NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: boldStrSize), NSAttributedString.Key.foregroundColor : UIColor.red], range: longestWordRange)


 return attributedString
    
    
}

extension UITextField {

enum Direction {
    case Left
    case Right
}
   

// add image to textfield
func withImage(direction: Direction, image: UIImage, colorSeparator: UIColor, colorBorder: UIColor){
    let mainView = UIView(frame: CGRect(x: 5, y: 0, width: 40, height: 20))
    mainView.layer.cornerRadius = 5

    let view = UIView(frame: CGRect(x: 5, y: 0, width: 30, height: 20))
    view.backgroundColor = .white
//    view.clipsToBounds = true
//    view.layer.cornerRadius = 5
//    view.layer.borderWidth = CGFloat(0.5)
//    view.layer.borderColor = colorBorder.cgColor
    mainView.addSubview(view)

    let imageView = UIImageView(image: image)
    imageView.contentMode = .scaleAspectFit
    imageView.frame = CGRect(x: 5, y: 1.0, width: 24.0, height: 20.0)
    view.addSubview(imageView)

//    let seperatorView = UIView()
//    seperatorView.backgroundColor = colorSeparator
//    mainView.addSubview(seperatorView)

    if(Direction.Left == direction){ // image left
       // seperatorView.frame = CGRect(x: 45, y: 0, width: 5, height: 30)
        self.leftViewMode = .always
        self.leftView = mainView
    } else { // image right
        //seperatorView.frame = CGRect(x: 0, y: 0, width: 5, height: 30)
        self.rightViewMode = .always
        self.rightView = mainView
    }

//    self.layer.borderColor = colorBorder.cgColor
//    self.layer.borderWidth = CGFloat(0.5)
//    self.layer.cornerRadius = 5
}
    

}

extension UIScrollView {
   func scrollToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}
class TextField: UITextField {

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension String
{
    func trim() -> String
    {
        return self
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm a") -> Date {
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = format
        var datefor : Date = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        if let date = dateFormatter.date(from: self) {
            datefor = date
        }
        
        return datefor
    }
   
    func isValidPassword(password: String) -> Bool {
        // least one uppercase,
          // least one digit
          // least one lowercase
          // least one symbol
          //  min 8 characters total
          let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{4,}$"
          let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
          return passwordCheck.evaluate(with: password)
        
    }
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    func isValidPhone(testStr:String) -> Bool {
        let phoneRegEx =  "^[6-9]\\d{9}$"
        let phoneNumber = NSPredicate(format:"SELF MATCHES %@", phoneRegEx)
        return phoneNumber.evaluate(with: testStr)
    }
    func checkDataType(text: String)-> Bool {
        if Int(text) != nil {
            return true
        
        } else {
           return false
       }
    }
    func gstValid(gstNum:String) -> Bool{
        let gstRegex = "^([0][1-9]|[1-2][0-9]|[3][0-7])([A-Z]{5})([0-9]{4})([A-Z]{1}[1-9A-Z]{1})([Z]{1})([0-9A-Z]{1})+$"
        let gstNumber = NSPredicate(format:"SELF MATCHES %@", gstRegex)
        return gstNumber.evaluate(with: gstNum)
    }

}


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return UIColor.gray
    }

    var rgbValue:UInt32 = 0
    Scanner(string: cString).scanHexInt32(&rgbValue)

    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension UILabel{


    func setSubTextColor(pSubString : String, pColor : UIColor){
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: self.text!);
        let range = attributedString.mutableString.range(of: pSubString, options:NSString.CompareOptions.caseInsensitive)
        if range.location != NSNotFound {
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: pColor, range: range);
        }
        self.attributedText = attributedString

    }
}


class BlurLoader: UIView {

    var blurEffectView: UIVisualEffectView?

    override init(frame: CGRect) {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = frame
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.blurEffectView = blurEffectView
        super.init(frame: frame)
        addSubview(blurEffectView)
        addLoader()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addLoader() {
        guard let blurEffectView = blurEffectView else { return }
        let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        blurEffectView.contentView.addSubview(activityIndicator)
        activityIndicator.center = blurEffectView.contentView.center
        activityIndicator.startAnimating()
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static func by(r: Int, g: Int, b: Int, a: CGFloat = 1) -> UIColor {
        let d = CGFloat(255)
        return UIColor(red: CGFloat(r) / d, green: CGFloat(g) / d, blue: CGFloat(b) / d, alpha: a)
    }
    
    static let darkDefault = UIColor(white: 45.0/255.0, alpha: 1)
    static let grayText = UIColor(white: 160.0/255.0, alpha: 1)
    static let facebookDarkBlue = UIColor.by(r: 59, g: 89, b: 152)
    static let dimmedLightBackground = UIColor(white: 100.0/255.0, alpha: 0.3)
    static let dimmedDarkBackground = UIColor(white: 50.0/255.0, alpha: 0.3)
    static let pinky = UIColor(rgb: 0xE91E63)
    static let amber = UIColor(rgb: 0xFFC107)
    static let satCyan = UIColor(rgb: 0x00BCD4)
    static let darkText = UIColor(rgb: 0x212121)
    static let redish = UIColor(rgb: 0xFF5252)
    static let darkSubText = UIColor(rgb: 0x757575)
    static let greenGrass = UIColor(rgb: 0x4CAF50)
    static let darkChatMessage = UIColor(red: 48, green: 47, blue: 48)
    static let appprimary = UIColor(rgb: 0x531F6C)
    static let appsecondary = UIColor(rgb: 0x9342B3)
    static let circlecolor = UIColor(rgb: 0x10008be3)
    
    func lighter(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: abs(percentage) )
    }
    
    func darker(by percentage: CGFloat = 30.0) -> UIColor? {
        return self.adjust(by: -1 * abs(percentage) )
    }
    
    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: min(red + percentage/100, 1.0),
                           green: min(green + percentage/100, 1.0),
                           blue: min(blue + percentage/100, 1.0),
                           alpha: alpha)
        } else {
            return nil
        }
    }
}
extension SSBadgeButton{
    func
    badgeButtonProperty(){
        self.badgeBackgroundColor = UIColor(hexString: "00D3B4")
        self.badgeTextColor = .white
        self.badgeBorderColor = .white
        self.badgeFont = UIFont(name: "Quicksand-Medium", size: 11)!
    }

}
extension UIView {
    
    func dropShadow() {
        
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: -18)
        if #available(iOS 13.0, *) {
            self.layer.shadowColor = UIColor.systemGray5.cgColor
        } else {
            // Fallback on earlier versions
        }
    }
    func dropShadowPosition(heightInt:Int,colorName:UIColor) {
        
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.6
        self.layer.shadowOffset = CGSize(width: 0, height: heightInt)
        if #available(iOS 13.0, *) {
            self.layer.shadowColor = colorName.cgColor
        } else {
            // Fallback on earlier versions
        }
    }
    
}

//func badgeButtonProperty(buttonName:SSBadgeButton){
//    buttonName.badgeBackgroundColor = UIColor(hexString: "00D3B4")
//    buttonName.badgeTextColor = .white
//    buttonName.badgeBorderColor = .white
//    buttonName.badgeFont = UIFont(name: "Quicksand-Medium", size: 11)!
//}


@IBDesignable
class WhiteUITextField: UITextField {
    private var kAssociationKeyMaxLength: Int = 0
    
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
    // Provides left padding for images
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.white {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            
                  let imgSearchs =  UIImageView()
            var viewss = UIView()
            var emptyView = UIView()
            imgSearchs.frame = CGRect(x:24  , y: 16, width:  12, height: 16)
            imgSearchs.contentMode = .scaleAspectFill
            viewss = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 70, height: 48))
            emptyView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 48))

            imgSearchs.image = image
            emptyView.addBorder(toSide: .Right, withColor: UIColor(hexString: "c3cde4").cgColor, andThickness: 1.0)
            
            emptyView.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            emptyView.addSubview(imgSearchs)
           
            viewss.addSubview(emptyView)
            

           
            //imgSearchs.tintColor = color
            leftView = viewss
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
//        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
    var change : Bool = false {
        didSet {
            textColor = change ? UIColor.black : UIColor.black
           // backgroundColor = change ? .blue : .white
        }
    }
}

func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd" // "dd-MM-yyyy " //HH:mm:ss"

        return dateFormatter.string(from: Date())

    }
  
}
extension String {
    
    func maxLength(length: Int) -> String {
         var str = self
         let nsString = str as NSString
         if nsString.length >= length {
             str = nsString.substring(with:
                 NSRange(
                  location: 0,
                  length: nsString.length > length ? length : nsString.length)
             )
         }
         return  str
     }
   func first(char:Int) -> String {
        return String(self.prefix(char))
    }

    func last(char:Int) -> String
    {
        return String(self.suffix(char))
    }

    func excludingFirst(char:Int) -> String {
        return String(self.suffix(self.count - char))
    }

    func excludingLast(char:Int) -> String
    {
         return String(self.prefix(self.count - char))
    }
 }
extension String
{
    public func getAcronyms(separator: String = "") -> String
    {
        let acronyms = self.components(separatedBy: " ").map({ String($0.first(char: 1)) }).joined(separator: separator);
        return acronyms;
    }
}

extension UITableView {
    func reloadData(completion:@escaping ()->()) {
        UIView.animate(withDuration: 0, animations: reloadData)
            { _ in completion() }
    }
}
func validZipCode(postalCode:String)->Bool{
        let postalcodeRegex = "^[1-9]{1}[0-9]{2}\\s{0,1}[0-9]{3}$"
        let pinPredicate = NSPredicate(format: "SELF MATCHES %@", postalcodeRegex)
        let bool = pinPredicate.evaluate(with: postalCode) as Bool
        return bool
    }

func formattedDateFromString(dateString: String, withFormat format: String) -> String? {

    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "dd-MM-yyyy"
    

    if let date = inputFormatter.date(from: dateString) {

        let outputFormatter = DateFormatter()
      outputFormatter.dateFormat = format

        return outputFormatter.string(from: date)
    }

    return nil
}
func datePickerDateFormat(date:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter.string(from:date)
}
extension Date {

    public var removeTimeStamp : Date? {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) else {
         return nil
        }
        return date
    }
}
