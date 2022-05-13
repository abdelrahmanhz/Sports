//
//  NetworkService.swift
//  Sports
//
//  Created by abdelrahmanhz on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import Foundation
import Alamofire

protocol FetchSports {
     func getSports(complitionHandler : @escaping (AllSports?, Error?) -> Void)
}
protocol FetchLeagues {
    func getLeagues( strSport : String ,complitionHandler : @escaping (AllLegaues?, Error?) -> Void)

}

class NetworkSevice: FetchSports{
     func getSports(complitionHandler : @escaping (AllSports?, Error?) -> Void){
      
        AF.request(Constants.BASE_URL + Constants.GET_ALL_SPORTS).responseJSON(completionHandler: { (response) in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                
                do{
                    let result = try JSONDecoder().decode(AllSports.self, from: data)
                    print("from network : \(String(describing: result.sports?.first?.strSport))")
                    print("from network : \(String(describing: result.sports?.count))")
                    complitionHandler(result, nil)
                }
                catch{}
            case .failure(_):
                print("error")
            }
        })
    }
}
extension NetworkSevice : FetchLeagues{
    
    func getLeagues(strSport: String, complitionHandler: @escaping (AllLegaues?, Error?) -> Void) {
        
        print("getLeagues from network")
        print(strSport)
        let parameters = ["s" : strSport] as [String : String]
        AF.request(Constants.BASE_URL + Constants.GET_ALL_Leagues,parameters: parameters ).responseJSON(completionHandler: { (response) in
                   switch response.result{
                   case .success(_):
                       guard let data = response.data else {
                           return
                       }
                       
                       do{
                        let result = try JSONDecoder().decode(AllLegaues.self, from: data)
                        print("from Network: \(result.countries?.first?.strLeague)")
                        complitionHandler(result, nil)
                       }
                       catch{}
                   case .failure(_):
                       print("error")
                   }
               })
    }
    
    
}
