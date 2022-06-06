//
//  FeedOnSale.swift
//  Danggn
//
//  Created by 황찬미 on 2022/06/01.
//

import Foundation
import Alamofire

class FeedOnSaleService {
    static let shared = FeedOnSaleService()
    
    private init() {}
    
    func feedOnSale(feedId: String,
                    onSale: String,
                    completion: @escaping (NetworkResult<Any>) -> Void) {
        // API 명세서 작성
        let url = APIConstants.feedOnSale
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        let body: Parameters = [
            "id": feedId,
            "onSale": onSale
        ]
        
        // 요청서를 만들자
        let dataRequest = AF.request(url,
                                     method: .put,
                                     parameters: body,
                                     encoding: JSONEncoding.default,
                                     headers: header)
        
        // 요청서로 데이터 통신이 시작딘다.
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
        
        // 분기 처리해 주는 함수
        private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
            switch statusCode {
            case 200: return isVaildData(data: data)
            case 400: return .pathErr
            case 500: return .serverErr
            default: return .networkFail
            }
        }
        
        // 서버에서 준 json 데이터를 decode 해 주는 함수 그리고 그 데이터를 networkresult success로 보내준다.
    private func isVaildData(data: Data) -> NetworkResult<Any> {
            let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(FeedOnSaleModel.self, from: data) else { return .pathErr }
            
            return .success(decodeData)
    }
}
