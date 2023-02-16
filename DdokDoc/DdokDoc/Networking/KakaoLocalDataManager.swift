//
//  KakaoLocalDataManager.swift
//  DdokDoc
//
//  Created by Roy 2023/08/05.
//

import Foundation
import Alamofire

class KakaoLocalDataManager {
    
    static let shared = KakaoLocalDataManager()
    
    func fetchHospitals(x: String, y: String, page: Int, delegate: SearchViewController, searchTerm: String) {
        //쿼리 생성
        let parameters: [String: [String]] = [
            "x": ["\(x)"],
            "y": ["\(y)"],
            "query": ["\(searchTerm)"],
            "page": ["\(page)"]
        ]
        print("\(page)")
        AF.request(Constant.KAKAO_LOCAL_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Keys.kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoLocalResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.didRetrieveLocal(response: response)
                    delegate.collectionView.reloadData()

                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다.")
                }
            }
    }
    
    func fetchCurrentLocation(x: String, y: String, completion: @escaping (String) -> Void) {
        let parameters: [String: [String]] = [
            "x": ["\(x)"],
            "y": ["\(y)"]
        ]
        
        AF.request(Constant.KAKAO_GEO_URL, method: .get, parameters: parameters, encoder: URLEncodedFormParameterEncoder.default, headers: Keys.kakaoHeaders)
            .validate()
            .responseDecodable(of: KakaoGeoResponse.self) { response in
                switch response.result {
                case .success:
                    print("위치정보 받아오기 성공")
                    
                    if let locationString = response.value?.documents[0].region_2depth_name {
                        completion(locationString)
                    } else {
                        completion("현재 지역 정보 불러오기 실패")
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }

    }
    
}
