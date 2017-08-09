//
//  ApiManager.swift
//  WhiteboardOnline
//
//  Created by hyrorre on 2017/08/09.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import Alamofire
import SwiftyJSON

class ApiManager{
	let url = ""
	
	var uid = ""
	var client = ""
	var accessToken = ""
	
	func register(email: String, password: String, passwordConfirmation: String)-> Bool{
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
			self.uid = json["uid"].string!
		}
		return isSuccess
	}
	
	func login(email: String, password: String)-> Bool{
		let params: Parameters = [
			"email" : email,
			"password" : password,
		]
		
		let req = Alamofire.request(url, method: .post, parameters: params)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			let header = response.response?.allHeaderFields
			self.client = header?["client"] as! String
			self.client = header?["access_token"] as! String
			let json = JSON(response.result.value)
			self.uid = json["uid"].string!
		}
		return isSuccess
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
