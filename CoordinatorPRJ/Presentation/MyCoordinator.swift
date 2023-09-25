import SwiftUI
import UIKit


struct UITextFieldRepresentable: UIViewRepresentable {
    @Binding var text: String
    var placeholder: String
    var isFirstResponder: Bool = false
    @Binding var isFocused: Bool
    @Binding var isError: Bool
    @Binding var isCorrect: Bool
    
    @State var textColor: UIColor // 새로운 텍스트 컬러 속성
    @Binding var borderColor: UIColor
    
    func makeUIView(context: UIViewRepresentableContext<UITextFieldRepresentable>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.delegate = context.coordinator
        textField.placeholder = self.placeholder
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 12
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: UIViewRepresentableContext<UITextFieldRepresentable>) {
        uiView.text = self.text
        uiView.textColor = self.textColor // 텍스트 컬러 설정
        uiView.layer.borderColor = self.borderColor.cgColor
        
        if isFirstResponder && !context.coordinator.didFirstResponder {
            uiView.becomeFirstResponder()
            context.coordinator.didFirstResponder = true
        }
    }
    
    func makeCoordinator() -> UITextFieldRepresentable.Coordinator {
        Coordinator(text: self.$text, isFocused: self.$isFocused, isError: $isError, isCorrect: $isCorrect, textColor: self.$textColor, borderColor: $borderColor)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate, ObservableObject {
        @Binding var text: String
        @Binding var isFocused: Bool
        @Binding var isError: Bool
        @Binding var isCorrect: Bool
        @Binding var textColor: UIColor
        @Binding var borderColor: UIColor
        
        var didFirstResponder = false
        
        init(text: Binding<String>, isFocused: Binding<Bool>, isError: Binding<Bool>, isCorrect: Binding<Bool>, textColor: Binding<UIColor>, borderColor: Binding<UIColor>) {
            self._text = text
            self._isFocused = isFocused
            self._isError = isError
            self._isCorrect = isCorrect
            self._textColor = textColor
            self._borderColor = borderColor
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            
                print("호출됨: ", #function)
            
                self.text = textField.text ?? ""
            print("입력된 텍스트: " + (textField.text ?? ""))
            
            if self.isCorrect {
                self.textColor = .green
                self.borderColor = UIColor.green
            }
            
            
            return true
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            self.text = textField.text ?? ""
            
            if self.isError {
                self.textColor = .red
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultEditingErrorBorderColor
            } else if self.isError == false {
                if self.isCorrect {
                    self.textColor = .green
                    self.borderColor = UIColor.green
                } else {
                    self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                    self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
                }
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
            }
            
//            if self.isCorrect {
//                self.textColor = .green
//                self.borderColor = UIColor.green
//            } else {
//                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
//                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
//            }
        }
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            print("호출됨: ", #function)
            textField.resignFirstResponder()
            self.text = textField.text ?? ""
            
            if self.isError {
                self.textColor = .red
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultEditingErrorBorderColor
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
            }
            
            if self.isCorrect {
                self.textColor = .green
                self.borderColor = UIColor.green
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
            }
            
            return true
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            print("호출됨: ", #function)
            self.isFocused = true
            self.text = textField.text ?? ""
            
            if self.isError {
                self.textColor = .red
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultEditingErrorBorderColor
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultEditingBorderColor
            }
            
            if self.isCorrect {
                self.textColor = .green
                self.borderColor = UIColor.green
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            print("호출됨: ", #function)
            self.isFocused = false
            self.text = textField.text ?? ""
            
            if self.isError {
                self.textColor = .red
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultEditingErrorBorderColor
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
            }
            
            if self.isCorrect {
                self.textColor = .green
                self.borderColor = UIColor.green
            } else {
                self.textColor = UITextFieldRepresentableConfig.shared.defaultTextColor
                self.borderColor = UITextFieldRepresentableConfig.shared.defaultBorderColor
            }
        }
    }
}

final class UITextFieldRepresentableConfig {
    static var shared = UITextFieldRepresentableConfig()
    private init() { }
    
    var defaultBorderColor: UIColor = .black
    var defaultEditingBorderColor: UIColor = .green
    var defaultEditingErrorBorderColor: UIColor = .red
    var defaultEditingNoErrorBorderColor: UIColor = .blue
    
    var defaultTextColor: UIColor = .black
    var defaultEditingTextColor: UIColor = .black
    var defaultEditingErrorTextColor: UIColor = .red
    var defaultEditingNoErrorTextColor: UIColor = .green
}
