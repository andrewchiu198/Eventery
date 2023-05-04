//
//  NetworkManager.swift
//  Eventery
//
//  Created by Uma Pulugurtha on 5/3/23.
//
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var url = URL(string: "http://34.85.177.184/events")!
    
    func getAllEvents(completion: @escaping ([Event]) -> Void) {
        //TODO: Get all Events
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request){ data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    print(String(data: data, encoding: .utf8)!)
                    let response = try decoder.decode(EventResponse.self, from: data)
                    //print(response)
                    completion(response.events)
                }catch (let error){
                    print(error.localizedDescription)
                   
                }
            }
            
        }
        task.resume()
        
    }
    
    func getAllSentEvents(sender: String, completion: @escaping ([Event]) -> Void) {
        //TODO: Get all Events
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        //set header
        request.setValue(sender, forHTTPHeaderField: "sender")
        

        let task = URLSession.shared.dataTask(with: request){ data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    print(String(data: data, encoding: .utf8)!)
                    let response = try decoder.decode(EventResponse.self, from: data)
                    //print(response)
                    completion(response.events)
                }catch (let error){
                    print(error.localizedDescription)
                   
                }
            }
            
        }
        task.resume()
        
    }
    
    func createEvent(id: Int? ,title: String, address: String,start: String, end: String, user: String, userEmail: String, description: String, free: Bool, category: String, completion: @escaping (Event) -> Void) {
        var request = URLRequest(url: url)
        
      request.httpMethod = "POST"
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //set body
        var body: [String: Any] = [:]
        
        //if the id already exists
        if let iDholder = id{
            body = [
                "id": iDholder,
                "title": title,
                "address": address,
                "start": start,
                 "end": end,
                "description": description,
                 "host": user,
                 "host_email": userEmail,
                 "free": free,
                 "category": category
            ]
        //if it doesn't, we want to create a new id
        }else{
            body = [
                "title": title,
                "address": address,
                "start": start,
                 "end": end,
                "description": description,
                 "host": user,
                 "host_email": userEmail,
                 "free": free,
                 "category": category
            ]
        }
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    print(data)
                    let response = try decoder.decode(Event.self, from: data)
                    completion(response)
                }catch (let error){
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
        
    }
    
    
    
    func deleteEvent(id: Int) {
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //set header
        //request.setValue("udp3", forHTTPHeaderField: "netid")
        
        //set body
        let body: [String: Any] = [
            "id": id
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        //request.value(forHTTPHeaderField: "udp3")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Event.self, from: data)
                   // completion(response)
                }catch (let error){
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
        
    }
    
}