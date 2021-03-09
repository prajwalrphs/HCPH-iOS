import UIKit

@objc public class IQPreviousNextView: UIView {

}

#if swift(>=5.1)
import SwiftUI

struct IQPreviousNextViewSwiftUI: UIViewRepresentable {
    func makeUIView(context: Context) -> IQPreviousNextView {
        IQPreviousNextView(frame: .zero)
    }

    func updateUIView(_ view: IQPreviousNextView, context: Context) {
    }
}

struct IQTextViewSwiftUI_Preview: PreviewProvider {
    static var previews: some View {
        IQPreviousNextViewSwiftUI()
    }
}

#endif

