//
//  ContentViewModel.swift
//  CoordinatorPRJ
//
//  Created by HESSEGG on 2023/09/20.
//

import UIKit

final class ContentViewModel: ObservableObject {
    @Published var text: String = "asdasd" {
        didSet {
            isError()
            isCorrecta()
        }
    }
    @Published var text2: String = ""
    @Published var isBool: Bool = false
    @Published var error: Bool = false
    @Published var errorText: String = ""
    
    @Published var isCorrect: Bool = false
    @Published var isCorrectText: String = ""
    
    @Published var correctString: String = "abcdefg"
    
    @Published var isFocused: Bool = false
    @Published var borderColor: UIColor = .black
    
    func isError() {
        print(isCorrect)
        if text == "abc" {
            error = true
            errorText = "abc는 안됩니다"
            borderColor = .red
        } else {
            error = false
            errorText = ""
            
            borderColor = .black
        }
    }
    
    func isCorrecta() {
        if text == correctString {
            isCorrect = true
            isCorrectText = "abcdegf 정답입니다."
            borderColor = .green
        } else {
            isCorrect = false
            isCorrectText = ""
            borderColor = .black
        }
    }
    
}
