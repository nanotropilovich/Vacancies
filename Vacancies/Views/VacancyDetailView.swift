import SwiftUI
import MapKit
import YandexMapsMobile

struct VacancyDetailView: View {
    let vacancy: Vacancy
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: SearchViewModel
    @StateObject private var detailViewModel = VacancyDetailViewModel()
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image("Back")
                    }
                    Spacer()
                    Image("Eye")
                    Image("Share")
                    Button(action: {
                        viewModel.toggleFavorite(vacancyId: vacancy.id)
                    }) {
                        Image(vacancy.isFavorite ? "Heart.fill2" : "Heart")
                    }
                    .padding(.trailing)
                }
                .padding(.horizontal)
                .padding(.top, 18)
                .padding(.bottom, 28)
                Text(vacancy.title)
                    .font(.system(size: 22))
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                    .foregroundColor(Color("White"))
                Text("\(vacancy.salary.full)")
                    .font(.system(size: 14))
                    .fontWeight(.regular)
                    .padding(.horizontal)
                    .foregroundColor(Color("White"))
                VStack(alignment: .leading, spacing: 4) {
                    Text("Требуемый опыт: \(vacancy.experience.text)")
                    Text(vacancy.schedules.map { $0.lowercased() }.joined(separator: ", ").capitalizingFirstLetter())
                }
                .font(.system(size: 14))
                .fontWeight(.regular)
                .padding(.horizontal)
                .foregroundColor(Color("White"))
                GeometryReader { geometry in
                    HStack(spacing:12) {
                        if let appliedNumber = vacancy.appliedNumber {
                            ZStack(alignment: .topTrailing) {
                                HStack {
                                    Text(viewModel.formatApplicationCount(appliedNumber))
                                        .font(.subheadline)
                                        .padding(.vertical, 5)
                                        .foregroundColor(Color.white)
                                        .padding(.horizontal)
                                    Spacer()
                                }
                                .frame(width:geometry.size.width/2 - 6)
                                .frame(height:50)
                                .background(Color("Dark green"))
                                .cornerRadius(8)
                                Image("Green profile")
                                    .padding(.all,5)
                            }
                        }
                        if let lookingNumber = vacancy.lookingNumber {
                            ZStack(alignment: .topTrailing) {
                                HStack {
                                    Text(viewModel.formatViewingCount(lookingNumber))
                                        .font(.subheadline)
                                    
                                        .padding(.vertical, 5)
                                        .foregroundColor(Color("White"))
                                        .padding(.horizontal)
                                    Spacer()
                                    
                                }
                                .frame(width:geometry.size.width/2 - 6)
                                .frame(height:50)
                                .background(Color("Dark green"))
                                .cornerRadius(8)
                                Image("Green eye")
                                    .padding(.all,5)
                            }
                        }
                        if vacancy.appliedNumber == nil || vacancy.lookingNumber == nil {
                            Spacer()
                        }
                    }
                    .frame(width:geometry.size.width,height:50)
                    
                }
                .padding(.horizontal)
                .padding(.bottom,50)
                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        Text(vacancy.company)
                            .font(.system(size: 16))
                            .fontWeight(.medium)
                            .foregroundColor(Color("White"))
                        
                        
                        Image("Check mark")
                        
                    }
                    .padding(.top)
                    if let coordinate = detailViewModel.coordinate {
                        YandexMapView(coordinate: coordinate)
                            .frame(height: 50)
                            .cornerRadius(8)
                        
                    }
                    Text("\(vacancy.address.town), \(vacancy.address.street), \(vacancy.address.house)")
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("White"))
                        .padding(.bottom)
                }
                .padding(.horizontal)
                .background(Color("Grey 1"))
                .cornerRadius(8)
                .padding(.horizontal)
                if let description = vacancy.description {
                    Text(description)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .padding(.horizontal)
                        .padding(.bottom,16)
                        .foregroundColor(Color("White"))
                }
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ваши задачи")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                        .foregroundColor(Color("White"))
                    Text(vacancy.responsibilities)
                        .font(.system(size: 14))
                        .fontWeight(.regular)
                        .foregroundColor(Color("White"))
                    
                }
                .padding(.horizontal)
                .padding(.bottom,28)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Задайте вопрос работодателю")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color("White"))
                    
                    Text("Он получит его с откликом на вакансию")
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .foregroundColor(Color("Grey 3"))
                    
                }
                .padding(.horizontal)
                .padding(.bottom,16)
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(vacancy.questions, id: \.self) { question in
                        Text(question)
                        
                            .font(.system(size: 14))
                            .fontWeight(.medium)
                            .padding(8)
                            .foregroundColor(Color("White"))
                            .background(Color("Grey 2"))
                            .cornerRadius(50)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom,20)
                Button("Откликнуться") {}
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("Green"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
            }
            
        }
        .onAppear {
            detailViewModel.getCoordinates(for: "\(vacancy.address.town), \(vacancy.address.street), \(vacancy.address.house)")
        }
        .navigationTitle("Vacancy Details")
        .navigationBarHidden(true)
        .background(Color("Black"))
    }
    
    
}


