//
//  ViewController.swift
//  What's The Weather?
//
//  Created by Matthew J. Perkins on 6/1/17.
//  Copyright © 2017 Matthew J. Perkins. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    
    @IBOutlet var weatherForecast: UILabel!
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        
        
        
        if let url = URL(string: "http://www.weather-forecast.com/locations/" + textField.text!.replacingOccurrences(of: " ", with: "-") + "/forecasts/latest"){
            
            let request = NSMutableURLRequest(url: url)
            
            let task = URLSession.shared.dataTask(with: request as URLRequest) {
                
                data,response,error in
                
                var message = ""
                
                if error != nil {
                    
                    self.weatherForecast.text = "The weather data could not be retrieved"
                    
                } else {
                    
                    if let unwrappedData = data {
                        
                        let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                        
                        //print(dataString)
                        
                        var stringSeparator = "3 Day Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                        
                        if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                            
                            if contentArray.count > 1 {
                                
                                stringSeparator = "</span>"
                                
                                let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                
                                    if newContentArray.count > 0 {
                                        
                                    message = newContentArray[0].replacingOccurrences(of: "&deg;", with: "°")
                                        
                                        print(message)
                                        
                                        
                                    
                                   
                                }
                            
                            }
                            
            
                        }
                    }
                }
                
                if message == "" {
                
                    message = "Weather forecast could not be retrieved. Please try again."
                }
                
                DispatchQueue.main.sync(execute: {
                    
                    self.weatherForecast.text = message
                })
                
            }
            
            task.resume()
            
            
            
        } else {
        
        
        }
        
        
        textField.text = ""
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        return true
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }


}

