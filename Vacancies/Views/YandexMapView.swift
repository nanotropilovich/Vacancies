import SwiftUI
import MapKit
import YandexMapsMobile

struct YandexMapView: UIViewRepresentable {
    var coordinate: YMKPoint
    
    func makeUIView(context: Context) -> YMKMapView {
        YMKMapView()
    }
    
    func updateUIView(_ uiView: YMKMapView, context: Context) {
        let mapView = uiView
        mapView.mapWindow.map.move(
            with: YMKCameraPosition(target: coordinate, zoom: 14, azimuth: 0, tilt: 0),
            animation: YMKAnimation(type: YMKAnimationType.smooth, duration: 0.5),
            cameraCallback: nil
        )
        
        let placemark = mapView.mapWindow.map.mapObjects.addPlacemark(with: coordinate)
        if let image = UIImage(systemName: "mappin.circle.fill") {
            placemark.setIconWith(image, style: YMKIconStyle())
        }
        mapView.mapWindow.map.isScrollGesturesEnabled = false
        mapView.mapWindow.map.isZoomGesturesEnabled = false
    }
}
