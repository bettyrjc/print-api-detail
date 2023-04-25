//
//  DataManager.swift
//  starWars_project
//
//  Created by BETTY JIMENEZ on 24/4/23.
//

import Foundation

protocol DataManagerDelegate {
    func didUpdateData(nameValue: String)
    func didFailWithError(error: Error)
}
struct DataManager {
    let dataURL = "https://swapi.dev/api/people/"
    var delegate: DataManagerDelegate?

    func getPerson(number:String){
        //1 Create URL
        let urlString = "\(dataURL)/\(number)"
        
        if let url = URL(string: urlString){
            //2 Create a URLSession
            let session = URLSession(configuration: .default)
            
            //3 Give the sesion a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                
                if let safeData = data {
                    if let fewData = self.parseJSON(safeData){
                        self.delegate?.didUpdateData(nameValue: fewData)
                    }
                }
            }
            
            //4 Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> String? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(PersonData.self, from: data)
            let person = decodedData.name
            return person
        } catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
