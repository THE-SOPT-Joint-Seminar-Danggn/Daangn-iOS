//
//  FeedDetailService.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/02.
//

import Foundation
import Alamofire

class FeedDetailService {
    static let shared = FeedDetailService()
    
    private init() {}
    
    func feedDetail(feedId: String,
                    completion: @escaping (NetworkResult<Any>) -> Void) {
        let url = APIConstants.detailFeedURL + "\(feedId)"
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        // 요청서
        let dataRequest = AF.request(url,
                                     method: .get,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // 요청서를 가지고 데이터 통신을 시작한다
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
    
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        switch statusCode {
        case 200: return isVaildData(data: data)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail

        }
    }
    
    private func isVaildData(data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(FeedDetailModel.self, from: data) else { return .pathErr }
        
        return .success(decodeData)
    }
}
