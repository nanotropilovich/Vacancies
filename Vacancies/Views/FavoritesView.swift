import Foundation
import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var viewModel: SearchViewModel
   
    var body: some View {
        VStack(alignment: .leading) {
                    Text("Избранное")
                        .font(.system(size:20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("White"))
                        .padding(.top,32)
                    
                    Text(viewModel.formatVacanciesCount(viewModel.favorites.count))
                        .font(.system(size:14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("Grey 3"))
                        .padding(.top)
                        .padding(.bottom,45)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            ForEach(viewModel.welcomeData?.vacancies.filter { $0.isFavorite } ?? [], id: \.id) { vacancy in
                                VacancyView(vacancy: vacancy)
                                    .environmentObject(viewModel)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
        
    
}
