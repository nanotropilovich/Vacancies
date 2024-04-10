import SwiftUI
import Foundation

struct VerificationView: View {
    @ObservedObject var viewModel: VerificationViewModel
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var appState: AppState
    @FocusState private var focusedField: Int?
    
    var body: some View {
        VStack(alignment: .leading,spacing: 20) {
            
            Text("Отправили код на \(viewModel.email)")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal)
                .padding(.top,129)
            
            Text("Напишите его, чтобы подтвердить, что это вы, а не кто-то другой входит в личный кабинет")
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundColor(.white)
                .padding(.horizontal)
                .fixedSize(horizontal: false, vertical: true)
            
            HStack {
                ForEach(0..<viewModel.code.count, id: \.self) { index in
                    PinCodeField(index: index, code: $viewModel.code, isCodeComplete: $viewModel.isCodeComplete, focusedField: _focusedField,width:50,height:50)
                }
            }
            .padding(.horizontal)
            
            Button(action: {
                viewModel.confirmCode()
            }) {
                Text("Подтвердить")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(viewModel.isCodeComplete ? Color("Blue") : Color("Dark blue"))
                    .cornerRadius(10)
            }
            .disabled(!viewModel.isCodeComplete)
            .padding(.horizontal)
            .padding(.bottom,428)
            
        }
        .background(Color.black)
        .navigationTitle("Подтверждение")
        .navigationBarBackButtonHidden(true)
        .onAppear {
            focusedField = 0
        }
    }
}

struct PinCodeField: View {
    var index: Int
    @Binding var code: [String]
    @Binding var isCodeComplete: Bool
    @FocusState var focusedField: Int?
    var width: CGFloat
    var height: CGFloat
    
    var body: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("Grey 2"))
            
            if code[index].isEmpty && focusedField != index {
                Text("*")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .foregroundColor(Color("Grey 3"))
                    .offset(y: height/16)
                    .frame(width: width, height: height, alignment: .center)
            }
            TextField("", text: $code[index], onEditingChanged: { editingChanged in
                if editingChanged {
                    focusedField = index
                }
            })
            .keyboardType(.numberPad)
            .multilineTextAlignment(.center)
            .font(.title)
            .foregroundColor(Color.white)
            .frame(width: width, height: height)
            .cornerRadius(8)
            .focused($focusedField, equals: index)
            .autocorrectionDisabled()
            .onChange(of: code[index]) { newValue in
                processInput(newValue)
            }
        }
        .frame(width: width, height: height)
        .onTapGesture {
            self.focusedField = index
        }
    }
    
    private func processInput(_ newValue: String) {
        let filtered = newValue.filter { "0123456789".contains($0) }
        if !filtered.isEmpty {
            if filtered.count == 1 {
                if !code[index].isEmpty || index == code.count - 1 {
                    code[index] = String(filtered.prefix(1))
                    if index < code.count - 1 {
                        focusedField = index + 1
                    }
                } else {
                    code[index] = String(filtered)
                    if index < code.count - 1 {
                        focusedField = index + 1
                    }
                }
            } else if filtered.count > 1 {
                var additionalIndex = 0
                for char in filtered {
                    if index + additionalIndex < code.count {
                        code[index + additionalIndex] = String(char)
                        additionalIndex += 1
                    } else {
                        break
                    }
                }
                focusedField = min(index + additionalIndex, code.count - 1)
            }
        } else if newValue.isEmpty && index > 0 {
            focusedField = index - 1
        }
        
        checkCodeCompletion()
    }
    
    private func checkCodeCompletion() {
        isCodeComplete = code.allSatisfy { !$0.isEmpty }
    }
}

