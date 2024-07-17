//
//  RailBackgroundDecorationViewAttributes.swift
//  TenTime
//
//  Created by Qamar Al Amassi on 15/07/2024.
//

import UIKit

class RailBackgroundDecorationViewAttributes: UICollectionViewLayoutAttributes, NSMutableCopying {
    
    
    var backgroundImage: String?
    var backgroundColor: UIColor?
    var identifier: String?
    
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone) as! RailBackgroundDecorationViewAttributes
        copy.backgroundColor = self.backgroundColor
        copy.backgroundImage = self.backgroundImage
        copy.identifier = self.identifier
        print("ATTR 3 ",   copy.identifier)
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? RailBackgroundDecorationViewAttributes else {
            return false
        }
        
        let areIdentifiersEqual = (self.identifier == other.identifier)
        let areBackgroundColorsEqual = (self.backgroundColor == other.backgroundColor)
        let areBackgroundImagesEqual = (self.backgroundImage == other.backgroundImage)
        
        return areIdentifiersEqual && areBackgroundColorsEqual && areBackgroundImagesEqual && super.isEqual(object)
    }
    
    
    
}
