import Foundation
import SwiftUI

struct SearchView: View {
    @EnvironmentObject var viewModel: SearchViewModel
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    HStack {
                        Image("Search")
                        Text("Должность, ключевые слова")
                            .font(.system(size: 14))
                            .fontWeight(.regular)
                            .foregroundColor(Color("Grey 4"))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .frame(height:40)
                    .background(Color("Grey 2"))
                    .cornerRadius(10)
                    
                    Image("Filter")
                        .foregroundColor(.white)
                        .padding()
                        .frame(height:40)
                        .background(Color("Grey 2"))
                        .cornerRadius(10)
                }
                .padding(.top)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        FeatureButton(iconName: "Location", text: "Вакансии рядом с вами", width: 132,height: 120)
                        FeatureButton(iconName: "Star", text: "Поднять резюме в поиске", width: 132,height: 120)
                        FeatureButton(iconName: "List", text: "Временная работа и подработка", width: 132,height: 120)
                    }
                }
                .padding(.top)
                HStack {
                    Text("Вакансии для вас")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("White"))
                    Spacer()
                }
                .padding(.bottom)
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 20) {
                        ForEach(Array(viewModel.welcomeData?.vacancies.prefix(3) ?? []), id: \.id) { vacancy in
                            VacancyView(vacancy: vacancy)
                                .environmentObject(viewModel)
                        }
                        
                        if let totalVacancies = viewModel.welcomeData?.vacancies.count, totalVacancies > 3 {
                            Button("Еще \(totalVacancies - 3) вакансии") {}
                                .frame(maxWidth: .infinity)
                                .font(.system(size: 16))
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.blue)
                                .cornerRadius(8)
                                .padding(.top, 10)
                        }
                    }
                }
                
            }
            .padding(.horizontal)
            .background(Color("Black"))
        }
    }
    
}

struct FeatureButton: View {
    var iconName: String
    var text: String
    var width: CGFloat
    var height: CGFloat
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Image(iconName)
                    .padding(.top)
                Spacer()
                Text(text)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundColor(.white)
                if  text == "Поднять резюме в поиске" {
                    Text("Поднять")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Green"))
                      
                }
                Spacer()
            }
            .padding(.leading,8)
            Spacer()
        }
        .frame(width:width,height: height)
        .background(Color("Grey 1"))
        .cornerRadius(15)
        
    }
}



