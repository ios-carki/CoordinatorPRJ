import SwiftUI
import Combine

class TextColorViewModel: ObservableObject {
    @Published var textColor: UIColor = .black
    private var cancellables = Set<AnyCancellable>()

    // 텍스트 컬러 변경 로직은 뷰모델에 남겨둡니다.
    func changeTextColor() {
        Timer.publish(every: 2, on: .main, in: .default)
            .autoconnect()
            .sink { [weak self] _ in
                self?.textColor = self?.randomColor() ?? .black
            }
            .store(in: &cancellables)
    }

    private func randomColor() -> UIColor {
        let colors: [UIColor] = [.red, .blue, .green, .orange, .purple]
        return colors.randomElement() ?? .black
    }
}

struct UILabelView: UIViewRepresentable {
    @Binding var textColor: UIColor

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.textColor = textColor
        return label
    }

    func updateUIView(_ uiView: UILabel, context: Context) {
        // UILabel의 속성을 업데이트합니다.
        uiView.textColor = textColor
    }

    typealias UIViewType = UILabel
}
