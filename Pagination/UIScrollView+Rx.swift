import UIKit
import RxSwift

extension Reactive where Base: UIScrollView {
    var reachedBottom: Observable<Void> {
        return contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                return scrollView.isReachedBottom ? Observable.just() : Observable.empty()
            }
    }
}

extension UIScrollView {
    fileprivate var isReachedBottom: Bool {
        let visibleHeight
            = frame.height
            - contentInset.top
            - contentInset.bottom
        let y = contentOffset.y + contentInset.top
        let threshold = max(0.0, contentSize.height - visibleHeight)
        return threshold < y
    }
}
