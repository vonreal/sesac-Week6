//
//  MapViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/11.
//

import UIKit
import MapKit

/*
    MapView
    - 지도와 위치 권한은 상관 x
    - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해주어야 함
    - 중심, 범위 지정
 */


class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setRegionAndAnnotation()
    }
}

func setRegionAndAnnotation() {
    // 지도 중심 설정: 애플맵 활용해 좌표 복사
    let center = CLLocationCoordinate2D(latitude: 34.811635, longitude: 126.425222)
    
    // 지도 중심 기반으로 보여질 범위 설정
    let region = MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
    
    mapView.setRegion(region, animated: true)
    
    
    // 지도에 핀 추가
    let annotation =  MKPointAnnotation()
    
    annotation.coordinate = center
    annotation.title = "가야 할 곳"
    
    mapView.addAnnotation(annotation)
}

extension MapViewController: MKMapViewDelegate {
    
    // 지도에 커스텀 핀 추가 -> kakao taxi, naver map 버스 등의 표시
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//        <#code#>
//    }
    
//    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
//        <#code#>
//    }
}
