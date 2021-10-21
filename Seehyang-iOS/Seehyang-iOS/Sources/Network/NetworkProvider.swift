//
//  NetworkProvider.swift
//  Seehyang-iOS
//
//  Created by Jinha Park on 2021/10/16.
//

import Foundation
import Moya

class NetworkProvider {
    static let shared = NetworkProvider()
    
    private let provider: MoyaProvider<NetworkService>
    
    private init(provider: MoyaProvider<NetworkService> = MoyaProvider<NetworkService>()) {
        self.provider = MoyaProvider<NetworkService>()
    }
    
    func requestPerfumeDeatil(perfumeID: Int, completion: @escaping (Result<PerfumeDetail, Error>) -> Void) {
        provider.request(.perfumeDetail(perfumeID: perfumeID)) { result in
            self.decodeData(result: result, completion: completion)
        }
    }
    
    func requestHomeToday(completion: @escaping (Result<GenericResponse<HomeToday>, Error>) -> Void) {
        provider.request(.homeToday) { result in
            self.decodeData(result: result, completion: completion)
        }
    }
    
    func requestHomeHotStory(completion: @escaping (Result<GenericResponse<HomeHotStory>, Error>) -> Void) {
        provider.request(.homeHotStory) { result in
            self.decodeData(result: result, completion: completion)
        }
    }
    
    func requestHomeWeeklyRanking(completion: @escaping (Result<GenericResponse<HomeWeeklyRanking>, Error>) -> Void) {
        provider.request(.homeWeeklyRanking) { result in
            self.decodeData(result: result, completion: completion)
        }
    }
}

extension NetworkProvider {
    func decodeData<T: Decodable>(result: Result<Response, MoyaError>, completion: (Result<T, Error>) -> Void) {
        switch result {
        case let .success(success):
            let responseData = success.data
            do {
                let data = try JSONDecoder().decode(T.self, from: responseData)
                completion(.success(data))
            } catch {
                completion(.failure(error))
            }
            
        case let .failure(error):
            completion(.failure(error))
        }
    }
}
