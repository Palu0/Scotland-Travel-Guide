import Foundation


class Search{
    
    let locationNames = MapView().locations.map {$0.name}

    func search(input: String, in array: [String]) -> [String] {
        let lowercasedInput = input.lowercased()
        
        return array.filter { word in
            let lowercasedWord = word.lowercased()
            return lowercasedInput.allSatisfy { word in lowercasedWord.contains(word) } //returns all words that contain the user input
        }
    }
    
}
