//
//  UIView+Image.swift
//  test
//
//  Created by Merouane Bellaha on 12/06/2020.
//  Copyright © 2020 Merouane Bellaha. All rights reserved.
//

import UIKit

extension UIView {
    /// transform an UIView to an UImage
    var image: UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.bounds.size)
        let image = renderer.image { _ in
            self.drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        }
        return image
    }
}
