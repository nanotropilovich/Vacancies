
import Foundation

class SearchViewModel: ObservableObject {
    var favoritesCount: Int {
        return favorites.count
    }
    @Published var welcomeData: Welcome?
    @Published var favorites = Set<String>()
    @Published var selectedVacancy: Vacancy?
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "vacancies", withExtension: "json") else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            var loadedData = try decoder.decode(Welcome.self, from: data)
            self.welcomeData = loadedData
            self.favorites = Set(welcomeData?.vacancies.filter{$0.isFavorite}.map{$0.id} ?? [])
        } catch {
            print("Failed to decode JSON: \(error)")
        }
    }

    func toggleFavorite(vacancyId: String) {
        if let index = welcomeData?.vacancies.firstIndex(where: { $0.id == vacancyId }) {
            welcomeData?.vacancies[index].isFavorite.toggle()
            if welcomeData?.vacancies[index].isFavorite == true {
                favorites.insert(vacancyId)
            } else {
                favorites.remove(vacancyId)
            }
        }
    }
    
    func formatVacanciesCount(_ count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        if lastDigit == 1 && lastTwoDigits != 11 {
            return "\(count) вакансия"
        } else if lastDigit >= 2 && lastDigit <= 4 && (lastTwoDigits < 10 || lastTwoDigits >= 20) {
            return "\(count) вакансии"
        } else {
            return "\(count) вакансий"
        }
    }

    func formatApplicationCount(_ count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        if lastDigit == 1 && lastTwoDigits != 11 {
            return "\(count) человек уже откликнулся"
        } else if lastDigit >= 2 && lastDigit <= 4 && (lastTwoDigits < 10 || lastTwoDigits >= 20) {
            return "\(count) человека уже откликнулись"
        } else {
            return "\(count) человек уже откликнулось"
        }
    }
    
    func formatViewingCount(_ count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        if lastDigit == 1 && lastTwoDigits != 11 {
            return "\(count) человек сейчас смотрит"
        } else if lastDigit >= 2 && lastDigit <= 4 && (lastTwoDigits < 10 || lastTwoDigits >= 20) {
            return "\(count) человека сейчас смотрят"
        } else {
            return "\(count) человек сейчас смотрят"
        }
    }
    
    func formatPeopleCount(_ count: Int) -> String {
        let lastDigit = count % 10
        let lastTwoDigits = count % 100
        if lastDigit == 1 && lastTwoDigits != 11 {
            return "\(count) человек"
        } else if (lastDigit == 2 && lastTwoDigits != 12) || (lastDigit == 3 && lastTwoDigits != 13) || (lastDigit == 4 && lastTwoDigits != 14) {
            return "\(count) человека"
        } else {
            return "\(count) человек"
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        inputFormatter.locale = Locale(identifier: "en_US_POSIX")
        
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "d MMMM"
        outputFormatter.locale = Locale(identifier: "ru_RU")
        
        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return "дата неизвестна"
        }
    }

}
