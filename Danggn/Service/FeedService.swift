//
//  FeedService.swift
//  Danggn
//
//  Created by 김담인 on 2022/05/27.
//

import Foundation
import Alamofire

class FeedService {
    static let shared = FeedService()
    private init() {}
}

extension FeedService {
    func getImage(completion: @escaping (NetworkResult<Any>) -> Void) {
    // completion 클로저를 @escaping closure로 정의
    let url = APIConstants.feedURL                                  // URL
    let header: HTTPHeaders = ["Content-Type": "application/json"]     // HTTP Headers
    
    // 요청서
    // Request 생성
    let dataRequest = AF.request(url,
                                method: .get,
                                encoding: JSONEncoding.default,
                                headers: header)
    
    // 서버 통신 시작 - Request 시작
    dataRequest.responseData { response in
        // 요청(Request)를 하고 넘겨받은 응답의 결과를 가지고 성공 또는 실패 분기 처리
        switch response.result {
        case .success:
            // 성공 시에는 상태코드(Status Code)와 값(Value)
            guard let statusCode = response.response?.statusCode else { return }
            guard let value = response.value else { return }
            
            // 해당 응답을 가지고 case 분기처리 (200, 400, 500인지 - 200: 성공을 해서 데이터를 잘 받았는지 확인
            let networkResult = self.judgeStatus(by: statusCode, value, FeedResponse.self)
            completion(networkResult)
        
        // 실패 시에는 바로 networkFail(통신 실패)라는 신호
        case .failure:
            completion(.networkFail)
        }
    }
}
    
    // 상태 코드와 값(value, data, response)를 가지고 통신의 결과를 핸들링하는 함수입니다.
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, _ response: T.Type) -> NetworkResult<Any> {
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        guard let decodedData = try? decoder.decode(response.self, from: data)
        else {
            return .pathErr
        }
        
        switch statusCode {
        // 성공 시에는 넘겨받은 데이터를 decode(해독)하는 함수를 호출합니다.
        case 200: return .success(decodedData)
        case 400..<500: return .requestErr(decodedData)
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
