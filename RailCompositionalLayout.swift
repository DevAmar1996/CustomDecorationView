//
//  RailCompositionalLayout.swift
//  TenTime
//
//  Created by Qamar Al Amassi on 15/07/2024.
//

import UIKit

class RailCompositionalLayout: UICollectionViewCompositionalLayout {
    var sectionBackgroundColors: [Int: UIColor] = [:]
    var sectionBackgroundImages: [Int: String] = [:]
    private var isPrepared = false
    var backgroundLayoutAttributes: [IndexPath: RailBackgroundDecorationViewAttributes] = [:]

    
    override class var layoutAttributesClass: AnyClass {
        return RailBackgroundDecorationViewAttributes.self
    }
    
    override func prepare() {
        super.prepare()
        
        guard !isPrepared, let collectionView = collectionView else { return }

        backgroundLayoutAttributes.removeAll()
        
        let numberOfSections = collectionView.numberOfSections
        for section in 0..<numberOfSections {
            let indexPath = IndexPath(item: 0, section: section)
            
            if section > 0, // Skip the first section (carousel)
               let backgroundAttributes = layoutAttributesForDecorationView(ofKind: ReuseIdentifiers.backgroundDecorationView, at: indexPath) as? RailBackgroundDecorationViewAttributes {
                backgroundAttributes.backgroundColor = sectionBackgroundColors[section - 1]
                backgroundAttributes.backgroundImage = sectionBackgroundImages[section - 1]
                backgroundAttributes.identifier = "section-\(section)"
                
                // Create a mutable copy of the attributes
                backgroundLayoutAttributes[indexPath] = backgroundAttributes
                print("Preparing background attributes for section \(section):")
            }
        }
        isPrepared = true
    }
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = super.layoutAttributesForElements(in: rect) ?? []
        
        
        // Add background attributes
        for (_, attribute) in backgroundLayoutAttributes {
            attributes.append(attribute)
        }
        
        
        return attributes
    }
    
    
    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        super.invalidateLayout(with: context)
        // Only reset preparation if necessary
            if context.invalidateEverything || context.invalidateDataSourceCounts {
                isPrepared = false
            }
            
            if let invalidatedItems = context.invalidatedItemIndexPaths {
                for indexPath in invalidatedItems {
                    backgroundLayoutAttributes.removeValue(forKey: indexPath)
                }
            }  
    }
}
