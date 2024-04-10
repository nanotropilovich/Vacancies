import SwiftUI
import MapKit
import YandexMapsMobile

class VacancyDetailViewModel: ObservableObject {
    @Published var coordinate: YMKPoint?
    var searchSession: YMKSearchSession?
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
    
    private func geocodeAddress(_ addressString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { [ self] placemarks, error in
            guard let location = placemarks?.first?.location else {
                print("Ошибка геокодирования: \(String(describing: error))")
                return
            }
            
            DispatchQueue.main.async {
                self.region = MKCoordinateRegion(
                    center: location.coordinate,
                    latitudinalMeters: 500,
                    longitudinalMeters: 500
                )
            }
        }
    }
    
    func getCoordinates(for address: String) {
        let searchManager = YMKSearch.sharedInstance().createSearchManager(with: .combined)
        
        let boundingBox = YMKBoundingBox(
            southWest: YMKPoint(latitude: 55.55, longitude: 37.42),
            northEast: YMKPoint(latitude: 55.95, longitude: 37.82)
        )
        
        let responseHandler = { [weak self] (searchResponse: YMKSearchResponse?, error: Error?) -> Void in
            guard let searchResponse = searchResponse, error == nil else {
                print("Ошибка геокодирования: \(String(describing: error))")
                return
            }
            
            if let firstResult = searchResponse.collection.children.first,
               let point = firstResult.obj?.geometry.first?.point {
                DispatchQueue.main.async {
                    self?.coordinate = point
                }
            } else {
                print("Не удалось найти координаты для адреса: \(address)")
            }
        }
        searchSession = searchManager.submit(
            withText: address,
            geometry: YMKGeometry(boundingBox: boundingBox),
            searchOptions: YMKSearchOptions(),
            responseHandler: responseHandler
        )
    }
}

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
