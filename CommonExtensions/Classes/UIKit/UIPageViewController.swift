//
//  UIPageViewController.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 21/01/18.
//

#if os(iOS)
    import UIKit

    extension UIPageViewController {
        public func setViewControllersSafely(_ viewControllers: [UIViewController]?,
                                             direction: UIPageViewController.NavigationDirection,
                                             animated: Bool,
                                             completion: ((Bool) -> Void)? = nil) {
            guard animated else {
                DispatchQueue.main.async {
                    self.setViewControllers(viewControllers, direction: direction, animated: false, completion: completion)
                }
                return
            }

            DispatchQueue.main.async {
                self.setViewControllers(viewControllers, direction: direction, animated: true) { finished in
                    if finished {
                        DispatchQueue.main.async {
                            self.setViewControllers(viewControllers,
                                                    direction: direction,
                                                    animated: false,
                                                    completion: completion)
                        }
                    } else if let completion = completion {
                        completion(finished)
                    }
                }
            }
        }
    }
#endif
