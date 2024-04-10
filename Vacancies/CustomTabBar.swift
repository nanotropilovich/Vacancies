import Foundation
import SwiftUI

struct CustomTabBar: View {
    @EnvironmentObject var appState: AppState
    @State var selectedTab: CustomTabBar.Tab
    @StateObject var viewModel = SearchViewModel()
    
    enum Tab {
        case search, favorites, applications, messages, profile
    }
    
    var body: some View {
        VStack(spacing:0) {
            if !appState.isUserLoggedIn {
                NavigationView {
                    LoginView(viewModel: LoginViewModel())
                        .environmentObject(appState)
                }
            }
            else {
                switch selectedTab {
                case .search:
                    SearchView()
                        .environmentObject(viewModel)
                case .favorites:
                        FavoritesView()
                            .environmentObject(viewModel)
                case .applications:
                    ApplicationsView()
                case .messages:
                    MessagesView()
                case .profile:
                    ProfileView()
                }
            }
            HStack {
                TabBarButton(icon: "Search", label: "Поиск", isSelected: selectedTab == .search) {
                    self.selectedTab = .search
                }
                Spacer()
                TabBarButton(icon: "Heart", label: "Избранное", isSelected: selectedTab == .favorites, badgeCount: viewModel.favoritesCount) {
                    self.selectedTab = .favorites
                }
                Spacer()
                TabBarButton(icon: "Message", label: "Отклики", isSelected: selectedTab == .applications) {
                    self.selectedTab = .applications
                }
                Spacer()
                TabBarButton(icon: "Vector", label: "Сообщения", isSelected: selectedTab == .messages) {
                    self.selectedTab = .messages
                }
                Spacer()
                TabBarButton(icon: "Profile", label: "Профиль", isSelected: selectedTab == .profile) {
                    self.selectedTab = .profile
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .foregroundColor(.white)
            .padding(.bottom)
        }
        .background(Color("Black"))
    }
}

struct TabBarButton: View {
    let icon: String
    let label: String
    var isSelected: Bool
    let action: () -> Void
    var badgeCount: Int = 0
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack(alignment: .topTrailing) {
                    Image(isSelected ? icon+".fill" : icon)
                    
                    if badgeCount > 0 {
                        Text("\(badgeCount)")
                            .font(.caption2)
                            .foregroundColor(.white)
                            .frame(minWidth: 14, minHeight: 14)
                            .padding(1)
                            .background(Color.red)
                            .clipShape(Circle())
                            .offset(x: 7, y: -3.5)
                    }
                }
                
                Text(label)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(isSelected ? Color("Blue") : Color("White"))
            }
        }
    }
}
