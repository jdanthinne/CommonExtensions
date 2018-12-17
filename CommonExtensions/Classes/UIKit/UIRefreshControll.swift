//
//  UIRefreshControll.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 17/12/2018.
//

extension UIRefreshControl {
    
    public func beginRefreshingProgrammaticaly() {
        if let scrollView = superview as? UIScrollView {
            scrollView.setContentOffset(CGPoint(x: 0, y: scrollView.contentOffset.y - frame.height), animated: true)
        }
        beginRefreshing()
    }
    
}
