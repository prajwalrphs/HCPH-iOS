
import UIKit

private class FittedSheets { }
enum Localize: String {
    case dismissPresentation
    case changeSizeOfPresentation
    
    var localized: String {
        return NSLocalizedString(self.rawValue, tableName: nil, bundle: Bundle(for: FittedSheets.self), value: "", comment: "")
    }
    
}
