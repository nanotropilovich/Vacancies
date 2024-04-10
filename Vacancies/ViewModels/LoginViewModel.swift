import Foundation
import Combine

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var isEmailValid: Bool? = nil
    @Published var isPresentingVerificationScreen: Bool = false
    @Published var attemptedToContinue: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        $email
            .map { email in
                self.attemptedToContinue = false
                return email
            }
            .map { email in
                let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
                return emailPred.evaluate(with: email)
            }
            .sink(receiveValue: { [weak self] isValid in
                guard let self = self else { return }
                self.isEmailValid = self.attemptedToContinue ? isValid : nil
            })
            .store(in: &cancellables)
    }
    
    func continuePressed() {
        attemptedToContinue = true
        validateEmail(email)
    }
    
    private func validateEmail(_ email: String) {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let isValid = emailPred.evaluate(with: email)
        isEmailValid = isValid
        if isValid {
            isPresentingVerificationScreen = true
        }
    }
}
