//
//  ApiManager.swift
//  WhiteboardOnline
//
//  Created by hyrorre on 2017/08/09.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import Alamofire
import SwiftyJSON

let url = "http://192.168.103.78/"

var uid = ""
var client = ""
var accessToken = ""

class ApiManager{
	static func register(email: String, password: String, passwordConfirmation: String)-> Bool{
		let params: Parameters = [
			"email" : email,
			"password" : password,
			"password_confirmation" : passwordConfirmation
		]
		
		let req = Alamofire.request(url, method: .post, parameters: params)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			let json = JSON(response.result.value)
			uid = json["uid"].string!
		}
		return isSuccess
	}
	
	static func login(email: String, password: String)-> Bool{
		let params: Parameters = [
			"email" : email,
			"password" : password,
		]
		
		let req = Alamofire.request(url + "sign_in", method: .post, parameters: params)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			let header = response.response?.allHeaderFields
			client = header?["client"] as! String
			client = header?["access_token"] as! String
			let json = JSON(response.result.value)
			uid = json["uid"].string!
		}
		return isSuccess
	}
	
	static func getGroups(groups: inout [Group]){
		//groups.removeAll(keepingCapacity: true)
		//let req = Alamofire.request(url, method: .get, parameters: Parameters(), encoding: JSONEncoding.default, headers: getHTTPHeaders())
		
	}
	
	func getCards(cards: inout [Card]){
		
	}
	
	internal func getHTTPHeaders() -> HTTPHeaders {
		let headers: HTTPHeaders = [
			"uid" : uid,
			"client" : client,
			"access_token" : accessToken
		]
		return headers
	}
	
}
