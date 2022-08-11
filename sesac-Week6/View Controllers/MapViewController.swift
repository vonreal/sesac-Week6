//
//  MapViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

/*
    MapView
    - 지도와 위치 권한은 상관 x
    - 만약 지도에 현재 위치 등을 표현하고 싶다면 위치 권한을 등록해주어야 함
    - 중심, 범위 지정
    - 핀(어노테이션)
 */

/*
    권한: 반영이 조금씩 느릴 수 있음. 지웠다가 실행한다고 하더라도. 한 번 허용을 해야 앱의 흐름을 확인할 수 있다.
 */

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    // Location2. 위치에 대한 대부분을 담당
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Loaction3. 프로토콜 연결
        locationManager.delegate = self
        
        checkUserDeviceLocationServiceAuthorization()
        setRegionAndAnnotation()
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
}

// 위치 관련된 User Defined 메서드
extension MapViewController {
    
    // Location7. iOS 버전에 따른 분기 처리 및 iOS 위치 서비스 활성화 여부 확인
    // 위치 서비스가 켜져 있다면 권한을 요청하고, 꺼져 있다면 커스텀 얼럿으로 상황 알려주기
    // CLAuthorizationStatus
    // - denied: 허용 안함 / 설정에서 추후에 거부 / 위치 서비스 중지 / 비행기 모드
    // - restricted: 앱 권한 자체 없는 경우 / 자녀 보호 기능 같은걸로 아예 제한
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            // 프로퍼티를 통해 locationManager가 가지고 있는 상태를 가져옴
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        // iOS 위치 서비스 활성화 여부 체크: locationServicesEnabled()
        if CLLocationManager.locationServicesEnabled() {
            // 위치 서비스가 활성화 되어 있으므로, 위치 권한 요청 가능해서 위치 권한을 요청함
            checkUserCurrentLocationAuthorization(authorizationStatus)
            
        } else {
            print("위치 서비스가 꺼져 있어 권한 요청을 못합니다.") // alert 처리
        }
    }
    
    // Location8. 사용자의 위치 권한 상태 확인
    // 사용자가 위치를 허용했는지, 거부했는지, 아직 선택하지 않았는지 등을 확인 (단, 사전에 iOS 위치 서비스 활성화 꼭 확인)
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT Determinded")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization() // 앱을 사용하는 동안에 대한 위치 권한 요청
            
            // plist wheninuse -> request 메서드 OK
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            print("Denied, 아이폰 설정으로 유도")
        case .authorizedWhenInUse:
            print("When In Use")
            // 사용자가 위치를 허용해둔 상태라면, startUpdatingLocation을 통해 didUpdateLocations 메서드가 실행
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")
//        case .authorizedAlways: 항상 실행되므로 default로 처리
//        case .authorized:
        }
    }
}

// Location4. 프로토콜 선언
extension MapViewController: CLLocationManagerDelegate {
    
    // Location5. 사용자의 위치를 성공적으로 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(#function, locations)
    }
    
    // Location6. 사용자의 위치를 못 가지고 온 경우
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function)
    }
    
    // Location9. 사용자의 권한 상태가 바뀔 때를 알려줌
    // 거부했다가 설정에서 변경했거나, 혹은 notDetermined에서 허용을 했거나 등
    // 허용 했어서 위치를 가지고오는 중에 , 설정에서 거부하고 돌아온다면/? -> 흔치 않는 경우 (인데 내가 이런 사용잨ㅋ)
    // iOS 14 이상: 사용자의 권한이 상태가 변경이 될 때, 위치 관리자가 생성할 때 호출됨
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print(#function)
        checkUserDeviceLocationServiceAuthorization()
    }
    
    // iOS 14 미만
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    }
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
