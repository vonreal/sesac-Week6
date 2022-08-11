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
        
        // 지도 중심 설정: 애플맵 활용해 좌표 복사
        let center = CLLocationCoordinate2D(latitude: 34.811635, longitude: 126.425222)
        
        // 지도 중심 기반으로 보여질 범위 설정
        MKCoordinateRegion(center: center, latitudinalMeters: 100, longitudinalMeters: 100)
    }
}
