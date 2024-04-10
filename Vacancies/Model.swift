import Foundation
// MARK: - Welcome
struct Welcome: Codable {
    let offers: [Offer]
    var vacancies: [Vacancy]
}
// MARK: - Offer
struct Offer: Codable {
    let id: String?
    let title: String
    let link: String
    let button: ButtonData?
}
// MARK: - Button
struct ButtonData: Codable {
    let text: String
}
// MARK: - Vacancy
struct Vacancy: Codable,Hashable {
    let id: String
    let lookingNumber: Int?
    let title: String
    let address: Address
    let company: String
    let experience: Experience
    let publishedDate: String
    var isFavorite: Bool
    let salary: Salary
    let schedules: [String]
    let appliedNumber: Int?
    let description: String?
    let responsibilities: String
    let questions: [String]
}
// MARK: - Address
struct Address: Codable,Hashable {
    let town, street, house: String
}

// MARK: - Experience
struct Experience: Codable,Hashable {
    let previewText, text: String
}
// MARK: - Salary
struct Salary: Codable,Hashable {
    let full: String
    let short: String?
}
