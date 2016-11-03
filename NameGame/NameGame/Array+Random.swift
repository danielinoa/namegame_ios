
import Foundation

extension Array {
    
    /**
     Returns a randon element in the array.
     - Note: The array may not be empty.
     */
    func random() -> Element {
        let randomIndex = Int(arc4random_uniform(UInt32(count)))
        return self[randomIndex]
    }
    
    /**
     Returns a subset of random elements of the specified size.
     - Note: The sample size may not exceed the number of elements in the array.
     */
    func random(sampleSize: Int) -> [Element] {
        assert(sampleSize <= count)
        var copy = self
        var sampleArray: [Element] = []
        for _ in 0..<sampleSize {
            let randomIndex = Int(arc4random_uniform(UInt32(copy.count)))
            let removedElement = copy.remove(at: randomIndex)
            sampleArray.append(removedElement)
        }
        return sampleArray
    }
    
}
