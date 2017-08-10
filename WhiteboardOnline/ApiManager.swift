//
//  ApiManager.swift
//  WhiteboardOnline
//
//  Created by hyrorre on 2017/08/09.
//  Copyright © 2017年 Moto Shinriki. All rights reserved.
//

import Alamofire
import SwiftyJSON

let url = "http://54.65.183.238:3000/api/v1"

var uid = ""
var client = ""
var accessToken = ""

var nowGroupId = 0

var lock = false

class ApiManager{
	static func getNowGroupId() -> Int {
		return nowGroupId
	}
	
	static func setNowGroupId(id: Int){
		nowGroupId = id
	}
	
	static func register(email: String, password: String, passwordConfirmation: String)-> Bool{
		lock = true
		let params: Parameters = [
			"email" : email,
			"password" : password,
			"password_confirmation" : passwordConfirmation
		]
		
		let req = Alamofire.request(url + "/auth", method: .post, parameters: params)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			lock = false
		}
		
		let runLoop = RunLoop.current
		while lock && runLoop.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {}
		return isSuccess
	}
	
	static func login(email: String, password: String)-> Bool{
		lock = true
		let params: Parameters = [
			"email" : email,
			"password" : password,
		]
		
		let req = Alamofire.request(url + "/auth/sign_in", method: .post, parameters: params)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			let header = response.response?.allHeaderFields
			client = header?["Client"] as! String
			accessToken = header?["Access-Token"] as! String
			uid = header?["Uid"] as! String
			lock = false
		}
		let runLoop = RunLoop.current
		while lock && runLoop.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {}
		return isSuccess
	}
	
	static func getGroups(groups: inout [Group]) -> Bool {
		lock = true
		let req = Alamofire.request(
			url + "/groups",
			headers: getHTTPHeaders()
		)
		var isSuccess = false
		var groups_ = groups
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			if(isSuccess){
				groups_.removeAll(keepingCapacity: true)
				let json = JSON(response.result.value)
				for i in 0..<json.arrayValue.count {
					let group = Group()
					let dict = json.arrayValue[i].dictionaryValue
					group.id = dict["id"]!.intValue
					group.name = dict["name"]!.stringValue
					groups_.append(group)
				}
			}
			lock = false
		}
		
		let runLoop = RunLoop.current
		while lock && runLoop.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {}
		groups = groups_
		return isSuccess
	}
	
	static func createGroup(name: String, comment: String? = nil) -> Bool {
		lock = true
		var parameters: Parameters = ["name": name]
		if(comment != nil){
			parameters["comment"] = comment!
		}
		let req = Alamofire.request(
			url + "/groups",
			method: .post,
			parameters: parameters,
			encoding: JSONEncoding.default,
			headers: getHTTPHeaders()
		)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			if(isSuccess){
				let json = JSON(response.result.value)
			}
			lock = false
		}
		
		let runLoop = RunLoop.current
		while lock && runLoop.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {}
		return isSuccess
	}
	
	static func getCards(groupId: Int, cards: inout [Card]) -> Bool{
		lock = true
		let req = Alamofire.request(
			url + "/cards",
			headers: getHTTPHeaders()
		)
		var isSuccess = false
		var cards_ = cards
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			if(isSuccess){
				cards_.removeAll(keepingCapacity: true)
				let json = JSON(response.result.value)
				for i in 0..<json.arrayValue.count {
					let card = Card()
					let dict = json.arrayValue[i].dictionaryValue
					card.commentFront = dict["commentFront"]!.stringValue
					card.commentBack = dict["commentBack"]!.stringValue
					card.isFront = dict["isFront"]!.boolValue
					cards_.append(card)
				}
			}
			lock = false
		}
		
		let runLoop = RunLoop.current
		while lock && runLoop.run(mode: .defaultRunLoopMode, before: Date(timeIntervalSinceNow: 0.1)) {}
		cards = cards_
		return isSuccess
	}
	
	static func createCard(groupId: Int, card: Card) {
		lock = true
		var parameters: Parameters = [
			"group_id": groupId,
			"x": card.x,
			"y": card.y,
			"width": card.width,
			"height": card.height,
			"isFront": card.isFront,
			"commentFront": card.commentFront,
			"commentBack": card.commentBack,
		]
		let req = Alamofire.request(
			url + "/cards",
			method: .post,
			parameters: parameters,
			encoding: JSONEncoding.default,
			headers: getHTTPHeaders()
		)
		var isSuccess = false
		req.responseJSON{ response in
			isSuccess = response.result.isSuccess
			if(isSuccess){
				let json = JSON(response.result.value)
			}
			lock = false
		}
	}
	
	internal static func getHTTPHeaders() -> HTTPHeaders {
		let headers: HTTPHeaders = [
			"uid" : uid,
			"client" : client,
			"access_token" : accessToken
		]
		return headers
	}
	
}
