//
//  Array.swift
//  CommonExtensions
//
//  Created by Jérôme Danthinne on 20/01/18.
//

extension MutableCollection {
    
    /// Shuffles the contents of this collection.
    public mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
    
}

extension Sequence {
    
    /// Returns an array with the contents of this sequence, shuffled.
    public func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
    
}
