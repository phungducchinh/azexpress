
import UIKit;


extension UITableView {
    func indexPathForRow(atCenterOfView view: UIView) -> IndexPath? {
        var point = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2);
        point = self.convert(point, from: view);
        let indexPath = self.indexPathForRow(at: point);
        return indexPath;
    }
}

extension UICollectionView {
    func indexPathForItem(atCenterOfView view: UIView) -> IndexPath? {
        var point = CGPoint(x: view.bounds.size.width/2, y: view.bounds.size.height/2);
        point = self.convert(point, from: view);
        let indexPath = self.indexPathForItem(at: point);
        return indexPath;
    }
}
