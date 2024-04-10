import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel
    @EnvironmentObject var appState: AppState
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading,spacing:0) {
                Text("Вход в личный кабинет")
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.top,37)
                    .padding(.bottom,140)
                
                VStack(alignment: .leading,spacing: 16) {
                    Text("Поиск работы")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.top,24)
                    
                    VStack(alignment: .leading, spacing: 5) {
                        CustomTextField(
                            placeholder: "Электронная почта или телефон",
                            text: $viewModel.email,
                            width: 296,
                            height: 40,
                            isEmailValid: viewModel.isEmailValid,
                            attemptedToContinue: viewModel.attemptedToContinue
                        )
                        
                        Text("Неверный формат электронной почты")
                            .font(.system(size: 12))
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                            .frame(height: 5)
                            .opacity(viewModel.isEmailValid == false ? 1 : 0)
                    }
                    
                    HStack(spacing: 24) {
                        CustomButton(text: "Продолжить", action: {
                            viewModel.continuePressed()
                        }, color: viewModel.email.isEmpty ? Color("Dark blue") : Color("Blue"), textColor: Color("White"),width:167,height:40, radius: 8)
                        .disabled(viewModel.email.isEmpty)
                           
                        Spacer()
                        CustomButton(text: "Войти с паролем", action: {
                            
                        }, color: Color.clear, textColor: Color("Blue"),width:116 ,height:40,radius: 8)
                        .disabled(true)
                        
                    }
                    .padding(.bottom,24)
                }
                .padding(.horizontal)
                .background(Color("Grey 1"))
                .cornerRadius(8)
                .padding(.bottom,22)
                
                VStack(alignment: .leading,spacing:0) {
                    Text("Поиск сотрудников")
                        .font(.system(size: 16))
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .padding(.top,24)
                        .padding(.bottom,8)
                    
                    Text("Размещение вакансий и доступ к базе резюме")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                        .padding(.bottom,16)
                    
                    Button( "Я ищу сотрудников") {}
                        .frame(maxWidth:.infinity)
                        .frame(height:32)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .background(Color("Green"))
                        .foregroundColor(Color("White"))
                        .cornerRadius(50)
                        .padding(.bottom,24)
                }
                .frame(maxWidth:.infinity)
                .padding(.horizontal,24)
                .background(Color("Grey 1"))
                .cornerRadius(8)
                
                NavigationLink(destination: VerificationView(viewModel: VerificationViewModel(email: viewModel.email, appState: appState))
                    .environmentObject(appState), isActive: $viewModel.isPresentingVerificationScreen) {
                        EmptyView()
                    }
                    .hidden()
                Spacer()
            }
            .padding(.horizontal,16)
        }
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var icon: String = "Vector"
    var clearIcon: String = "Union"
    var width: CGFloat
    var height: CGFloat
    var isEmailValid: Bool?
    var attemptedToContinue: Bool
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Image(icon)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)
            }
            if text.isEmpty {
                Text(placeholder)
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .foregroundColor(Color("White"))
                    .padding(.leading, 40)
            }
            TextField("", text: $text)
                .font(.system(size: 14))
                .frame(height: height)
                .cornerRadius(8)
                .foregroundColor(.white)
                .autocorrectionDisabled()

            
            HStack {
                Spacer()
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(clearIcon)
                            .foregroundColor(.gray)
                    }
                    .padding(.trailing, 10)
                }
            }
        }
        .background(Color("Grey 2"))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke((isEmailValid == false && attemptedToContinue) ? Color.red : Color.clear, lineWidth: 1)
        )
    }
}



struct CustomButton: View {
    let text: String
    let action: () -> Void
    let color: Color
    var textColor: Color
    var showBorder: Bool = false
    var width: CGFloat
    var height: CGFloat
    var radius: CGFloat
    var body: some View {
        Button(action: action) {
            Text(text)
                .frame(width: width, height: height)
                .font(.system(size: 14))
                .fontWeight(.regular)
                .foregroundColor(textColor)
                .background(color)
                .cornerRadius(radius)
            
        }
        
    }
}
