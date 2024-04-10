import SwiftUI
import YandexMapsMobile

@main
struct VacanciesApp: App {
    @StateObject var appState = AppState()
    init() {
        YMKMapKit.setApiKey("77401950-8ca8-49dc-a341-26335c726f17")
        YMKMapKit.setLocale("ru_RU")
        YMKMapKit.sharedInstance()
    }
    var body: some Scene {
        WindowGroup {
            ZStack(alignment: .bottomLeading) {
                CustomTabBar( selectedTab: .search)
                    .environmentObject(appState)
            }
        }
    }
}

class AppState: ObservableObject {
    @Published var isUserLoggedIn = false
}
