//
//  ContentView.swift
//  CoordinatorPRJ
//
//  Created by HESSEGG on 2023/09/20.
//

import SwiftUI

import iOSViewModule

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    @State private var text = ""
        @State private var textColor = UIColor.black

        var body: some View {
            VStack {
                Text(viewModel.isFocused ? "선택중" : "선택 안하는중")
                UITextFieldRepresentable(text: $viewModel.text, placeholder: "asdflasdfl", isFocused: $viewModel.isFocused, isError: $viewModel.error, isCorrect: $viewModel.isCorrect, textColor: .black, borderColor: $viewModel.borderColor)
                    .frame(height: 50)
                    .padding(.horizontal, 16)
                
                if viewModel.error {
                    Text(viewModel.errorText)
                        .foregroundColor(.red)
                        .font(.title)
                }
                
                if viewModel.isCorrect {
                    Text(viewModel.isCorrectText)
                        .foregroundColor(.green)
                        .font(.title)
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
