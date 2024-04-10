import SwiftUI
import Combine

class VerificationViewModel: ObservableObject {
    var email: String
    @Published var code: [String] = Array(repeating: "", count: 4)
    @Published var isCodeComplete: Bool = false
    @Published var isUserLoggedIn: Bool = false
    private var appState: AppState
    private var cancellables = Set<AnyCancellable>()
    
    init(email: String, appState: AppState) {
        self.email = email
        self.appState = appState
        setupBindings()
    }
    
    private func setupBindings() {
        $code
            .map { $0.joined() }
            .map { $0.count == self.code.count }
            .assign(to: &$isCodeComplete)
    }
    
    func confirmCode() {
        if isCodeComplete {
            appState.isUserLoggedIn = true
        }
    }
}
