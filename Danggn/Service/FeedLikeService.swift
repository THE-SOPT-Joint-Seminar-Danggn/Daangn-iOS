//
//  FeedLikeService.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/01.
//

import Foundation
import Alamofire

class FeedLikeService {
    static let shared = FeedLikeService()
    private init() {}
    
    func feedLike(feedId: String, completion: @escaping (NetworkResult<Any>) -> Void)
    {
    // completion 클로저를 @escaping 클로저로 정의합니다.
        
        // API 명세서 작성
        let url = APIConstants.likeFeedURL + "\(feedId)"
        let header: HTTPHeaders = ["Content-Type" : "application/json"]
        
        // 요청서 작성
        let dataRequest = AF.request(url,
                                     method: .put,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // 요청서 호출
        // 데이터 통신의 결과가 response에 담긴다
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkResult = self.judgeStatus(by: statusCode, value)
                completion(networkResult)
            
            case .failure:
                completion(.networkFail)
            }
        }
    }
    
    // 서버 통신 자체는 성공일지라도 응답 실패로 원하는 데이터를 받지 못하였을 때 분기처리해 주는 메서드
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isVaildData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
    
    // 통신이 성공하고 원하는 데이터가 들어왔을 때 데이터를 처리해 주는 함수
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(FeedLikeModel.self, from: data) else { return .pathErr }
        
        return .success(decodeData)
    }
}
