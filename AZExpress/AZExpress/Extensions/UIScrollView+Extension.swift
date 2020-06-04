
import UIKit

extension UIScrollView {
    
    func scrollToTop() {
        let desiredOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(desiredOffset, animated: true)
    }
    
    func scrollToBottom() {
        let desiredOffset = CGPoint(x: 0, y: contentInset.bottom)
        setContentOffset(desiredOffset, animated: true)
    }
}
