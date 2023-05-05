//
//  NetworkManager.swift
//  Eventery
//
//  Created by Uma Pulugurtha on 5/3/23.
//
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    

    var url = URL(string: "http://35.194.86.169/api/events/")!
    
    func getAllEvents(completion: @escaping ([Event]) -> Void) {
        //TODO: Get all Events
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let task = URLSession.shared.dataTask(with: request){ data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()

                    //print(String(data: data, encoding: .utf8)!)
                    let response = try decoder.decode(EventResponse.self, from: data)
                    //print(response)
                    print(response.events)
                    completion(response.events)
                }catch (let error){
                    print(error.localizedDescription)
                   
                }
            }
            
        }
        task.resume()
        
    }
    
    
    func getAllEventsByDay(date: String, completion: @escaping ([Event]) -> Void) {
        //TODO: Get all Events
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue(date, forHTTPHeaderField: "day")
        
        request.url?.append(queryItems: [
            URLQueryItem(name: "day", value: date)
        ])
        //note may 3rd 2023
        

        let task = URLSession.shared.dataTask(with: request){ data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    //print(String(data: data, encoding: .utf8)!)
                    let response = try decoder.decode(EventResponse.self, from: data)
                    //print(response)
                    print(response.events)
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
    
    func createEvent(id: Int ,title: String, address: String,start: String, end: String, user: String, userEmail: String, description: String, free: Bool, category: String, completion: @escaping (Event) -> Void) {
        var request = URLRequest(url: url)
        
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //set body
        var body: [String : Any] = [
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
    
    
    func createUser(username: String, password: String, email: String,name: String, completion: @escaping (User) -> Void) {
        let userURL = URL(string: "http://35.194.86.169/api/users/")!
        var request = URLRequest(url: userURL)
        
      request.httpMethod = "POST"
      request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //set body
        let body: [String : Any] = [
            "username": username,
            "password": password,
            "email": email,
            "name": name
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    print(data)
                    let response = try decoder.decode(User.self, from: data)
                    completion(response)
                }catch (let error){
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
        
    }
    
    func postLogin(username: String, password: String, completion: @escaping (Error) -> Void){
        
        let userURL = URL(string: "http://35.194.86.169/login/")!
        var request = URLRequest(url: userURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
          
          //set body
        let body: [String : Any] = [
              "email": username,
              "password": password
          ]
          
          request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
          
          let task = URLSession.shared.dataTask(with: request) { data, response, err in
              
              if let data = data {
                  do {
                      let decoder = JSONDecoder()
                      print(data)
                      let response = try decoder.decode(Error.self, from: data)
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
        
        print("delete request sent")
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //set header
        request.setValue("\(id)", forHTTPHeaderField: "event_id")
        
        //set body
//        let body: [String: Any] = [
//            "id": id
//        ]
        
        //request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        //request.value(forHTTPHeaderField: "udp3")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Event.self, from: data)

                    //completion(response)

                }catch (let error){
                    print(error.localizedDescription)
                }
            }
            
        }
        task.resume()
        
    }
    
    func getAllUsers(completion: @escaping ([User]) -> Void) {
        
        let userURL = URL(string: "http://35.194.86.169/api/users/")!
        var request = URLRequest(url: userURL)
        
        request.httpMethod = "GET"
        
        
        let task = URLSession.shared.dataTask(with: request){ data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    print(String(data: data, encoding: .utf8)!)
                    let response = try decoder.decode(UserResponse.self, from: data)
                    completion(response.users)
                }catch (let error){
                    print(error.localizedDescription)
                   
                }
            }
            
        }
        task.resume()
        
    }
    
    func getUser(email: String, completion: @escaping (User) -> Void) {
        
        let newString = email.replacingOccurrences(of: "@", with: "-", options: .literal, range: nil)
        let userURL = URL(string: "http://35.194.86.169/api/users/email/\(email)")!
        var request = URLRequest(url: userURL)
        
        request.httpMethod = "GET"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        
        //set header
        request.setValue(newString, forHTTPHeaderField: "email")
        
        let task = URLSession.shared.dataTask(with: request){ data, response, err in
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    print(String(data: data, encoding: .utf8)!)
                    let response = try decoder.decode(User.self, from: data)
                    completion(response)
                }catch (let error){
                    print(error.localizedDescription)
                   
                }
            }
            
        }
        task.resume()
        
    }
    
    

}
