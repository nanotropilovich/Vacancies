import Foundation
import SwiftUI

struct VacancyView: View {
    let vacancy: Vacancy
    @EnvironmentObject var viewModel: SearchViewModel
    @State private var selectedVacancy: Vacancy?
    @State var isLinkActive = false
    var body: some View {
        ZStack(alignment: .topLeading) {
            VStack(alignment: .leading) {
                if let lookingNumber = vacancy.lookingNumber {
                    Text("Сейчас просматривает \(viewModel.formatPeopleCount(lookingNumber))")
                        .font(.system(size:14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Green"))
                        .padding(.bottom,4)
                }
                
                Text(vacancy.title)
                    .font(.system(size:16))
                    .fontWeight(.medium)
                    .foregroundColor(Color("White"))
                    .padding(.bottom,4)
                Text(vacancy.address.town)
                HStack {
                    Text(vacancy.company)
                    Image("Check mark")
                    Spacer()
                }
                .padding(.bottom,4)
                HStack {
                    Image("Experience")
                    Text(vacancy.experience.previewText)
                    Spacer()
                }
                .padding(.bottom,4)
                Text("Опубликовано \(viewModel.formatDate(vacancy.publishedDate))")
                    .foregroundColor(Color("Grey 4"))
                    .padding(.bottom,4)
                Button("Откликнуться") {}
                    .frame(maxWidth: .infinity)
                    .frame(height: 5)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color("Green"))
                    .cornerRadius(50)
            }
            .padding()
            .font(.system(size:14))
            .fontWeight(.regular)
            .foregroundColor(Color("White"))
            .padding(.bottom,8)
            .background(Color("Grey 1"))
            .cornerRadius(10)
            .onTapGesture {
                self.isLinkActive = true
            }
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        viewModel.toggleFavorite(vacancyId: vacancy.id)
                    }) {
                        Image(vacancy.isFavorite ? "Heart.fill2" : "Heart")
                            .foregroundColor(vacancy.isFavorite ? .red : .gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .padding(.all, 10)
                    .contentShape(Rectangle())
                }
                Spacer()
            }
            .padding(.top, 10)
            NavigationLink(destination: VacancyDetailView(vacancy: vacancy).environmentObject(viewModel), isActive: $isLinkActive) { EmptyView() }
        }
    }
    
}
