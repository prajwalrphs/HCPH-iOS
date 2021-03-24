
import UIKit

class ResizingDemo: UIViewController, Demoable {
     
    @IBOutlet var zipcodetext: UILabel!
    @IBOutlet var txtnote: UILabel!
    
    var navigationClass:webviewViewController!

    static var name: String { "Resize buttons" }
    
    let Titleget = UserDefaults.standard.string(forKey: AppConstant.TITLE)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Zipcode = UserDefaults.standard.string(forKey: AppConstant.ZIPCODE)
        zipcodetext.text = Zipcode
        
        print("Zipcode==>\(Zipcode ?? "")")
    }
    
    var code:String!
    var TitleText:String!
    
    static func openDemo(from parent: UIViewController, in view: UIView?, Name:String, title: String) {
        let useInlineMode = view != nil
        
        let controller = UIStoryboard(name: "ResizingDemo", bundle: nil).instantiateInitialViewController()!
        
        let sheet = SheetViewController(
            controller: controller,
            sizes: [.fixed(300), .fixed(300), .fixed(450), .marginFromTop(50)],
            options: SheetOptions(useInlineMode: useInlineMode))
        
        ResizingDemo.addSheetEventLogging(to: sheet)
        
        
        if let view = view {
            sheet.animateIn(to: view, in: parent)
        } else {
            parent.present(sheet, animated: true, completion: nil)
        }
    }
    
    @IBAction func SprayActivity(_ sender: UIButton) {
//        guard let url = URL(string: "https://publichealth.harriscountytx.gov/Resources/Mosquito-Vector-Borne-Illnesses") else { return }
//        UIApplication.shared.open(url)
    }
    
    @IBAction func DiseaseActivity(_ sender: UIButton) {
//        guard let url = URL(string: "https://publichealth.harriscountytx.gov/Resources/Mosquito-Vector-Borne-Illnesses") else { return }
//        UIApplication.shared.open(url)
    }
    
    @IBAction func information(_ sender: UIButton) {
      
        guard let url = URL(string: "https://publichealth.harriscountytx.gov/Resources/Mosquito-Vector-Borne-Illnesses") else { return }
        UIApplication.shared.open(url)
    }
    
    func naviGetTo(url:String, title:String){
        
        let navigate = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "webviewViewController") as! webviewViewController
    
        navigate.strUrl = url
        navigate.strTitle = title
        
        self.navigationController?.pushViewController(navigate, animated: true)
            
    }
    
    func GetTextorZip(Code:String, Text:String){
      
        
    }
}
