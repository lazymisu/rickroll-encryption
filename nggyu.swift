import Cocoa

// Based in Vigenère cipher

let abc = ["AFKPUZ/", "BGLQV", "CHMRW", "DINSX", "EJOTY"]

let matrix = [
    "NEVER" : ["NEVER", "GONNA", "GIVE", "YOU", "UP"],
    "GONNA" : ["GONNA", "GIVE", "YOU", "UP", "NEVER"],
    "GIVE"  : ["GIVE", "YOU", "UP", "NEVER", "GONNA"],
    "YOU"   : ["YOU", "UP", "NEVER", "GONNA", "GIVE"],
    "UP"    : ["UP", "NEVER", "GONNA", "GIVE", "YOU"]
]

func buildCipher(with length: Int) -> [String] {
    
    var cipher = [String]()
    
    for index in 0...length - 1 {
        
        let val = ["NEVER", "GONNA", "GIVE", "YOU", "UP"][index % 5]
        cipher.append(val)
    }
    
    return cipher
}

func encrypt(_ message: String) -> String {

    let sanitize = message.replacingOccurrences(of: " ", with: "/")
    
    let cipher = buildCipher(with: sanitize.count)
    
    var result = [String]()
    
    sanitize.enumerated().forEach { row, char in

        for col in 0...4 {

            for (index, letter) in abc[col].enumerated() {

                if letter.uppercased() == char.uppercased() {
                    
                    let val = matrix[cipher[row]]!

                    result.append("\(val[col])\(index)")
                }
            }
        }
    }

    return result.map({ $0.lowercased() }).joined(separator: "-")
}

func decrypt(_ message: String) -> String {

    let splitMessage = message.split(separator: "-")
    
    let cipher = buildCipher(with: splitMessage.count)
    
    var result = [String]()
    
    splitMessage.enumerated().forEach { row, char in

        var string = String(char)
        let repeats = Int(String(string.removeLast()))!
        
        for (col, val) in matrix[cipher[row]]!.enumerated() {
            
            if val.uppercased() == string.uppercased() {
                
                for (index, letter) in abc[col].enumerated() {
                    
                    if index == repeats {
                        
                        result.append(letter.lowercased())
                        break
                    }
                }
            }
        }
    }

    return result.joined(separator: "").replacingOccurrences(of: "/", with: " ")
}

let foo = encrypt("rickroll")
print(foo)

let bar = decrypt(foo)
print(bar)
