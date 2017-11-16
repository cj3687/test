//
//  SearchCityViewController.swift
//  OpenWeather
//
//  Created by Mikhail Rostov on 29.06.17.
//  Copyright © 2017 Dorada App Software Ltd. All rights reserved.
//

import Foundation
import UIKit

var confirmSearch:Bool = false

struct SearchItem {
    let name: String
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchDisplayDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleCell: UILabel!
    
    var friendsArr: [SearchItem] = []
    var filteredFriendsArr: [SearchItem] = []
    var networkController : WeatherAPIRequests = NetworkController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(backAction))
        initData()
    }
    
    func backAction(){
        UserDefaults.standard.set("", forKey: "currentCityName")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "weatherViewController") as UIViewController
        present(vc, animated: true, completion: nil)
    }
    
    func initData(){
        tableView.reloadData()
        var searchResult:String = ""
        if (UserDefaults.standard.string(forKey: "searchCityName") != nil) && (UserDefaults.standard.string(forKey: "searchCountryName") != nil){
        searchResult = UserDefaults.standard.string(forKey: "searchCityName")! + " (" + UserDefaults.standard.string(forKey: "searchCountryName")! + ")"
            UserDefaults.standard.string(forKey: "searchCountryName")!}
        self.friendsArr.append(SearchItem(name: searchResult))

        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       // searchBar.resignFirstResponder()
        confirmSearch = true
        let categoryMatch = true
        let transliterateString = TransliterationText()
        print("@@@@@@@@@@ FILTER")
       // let stringMatch = friend.name.range(of: searchText)
        DispatchQueue.main.async {
            if searchBar.text != ""{
                let transliterateText = transliterateString.transliterate(s: searchBar.text!)
                let clearString = transliterateText.replacingOccurrences(of: "[\\[\\]^+_ <>]", with: "", options: .literal, range: nil)
                let parsedCityName: String = clearString.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                UserDefaults.standard.set(parsedCityName, forKey: "currentCityName")
                let forecastController = ForecastController(networkController: (self.networkController))
                forecastController.getForecast { [weak self] (networkforcast, error) in
                    let cityName:String = (networkforcast?.city?.name)!
                    let countryName:String = (networkforcast?.city?.country)!
                    //guard let `self` = self else { return }
                    print("@@@@@@@@@@ NETWORK CONTROLLER")
                    print("@@@@@@@@@@ NETWORK CONTROLLER CITY " + cityName)
                    print("@@@@@@@@@@ NETWORK CONTROLLER COUNTRY" + countryName)
                    UserDefaults.standard.set(cityName, forKey: "searchCityName")
                    UserDefaults.standard.set(countryName, forKey: "searchCountryName")
                    self?.initData()
                }
                }

            
        }
        print("@@@@@@@@@@@@@_SEARCH " + searchBar.text!)
        tableView.reloadData()
        //return categoryMatch && (stringMatch != nil)
        
    }
    
    // MARK: - tableVIew
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            return self.filteredFriendsArr.count
        }else {
            
            return self.friendsArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        var friend: SearchItem
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            friend = self.filteredFriendsArr[indexPath.row]
        }else {
            
            friend = self.friendsArr[indexPath.row]
        }
        
        cell.textLabel?.text = friend.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var friend: SearchItem
        
        if tableView == self.searchDisplayController?.searchResultsTableView {
            
            friend = self.filteredFriendsArr[indexPath.row]
        }else {
            friend = self.friendsArr[indexPath.row]
        }
        let clearString = UserDefaults.standard.string(forKey: "searchCityName")?.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        var dictionary: [String:String] = [
            "one" : clearString!,
            "two" : UserDefaults.standard.string(forKey: "searchCountryName")!
        ]
        let db = SQLiteDB.shared
        db.openDB()
        let result = db.execute(sql:"INSERT INTO city (title,country,image) VALUES ('" + dictionary["one"]! + " ', '" + dictionary["two"]! + "', 'Inspiration-12');")
        
        print(friend.name)
        print("@@@@@@@@@@ " , result)
        
        let parsedCityName: String = dictionary["one"]!.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        UserDefaults.standard.set(parsedCityName, forKey: "currentCityName")
        print("add city: -" + parsedCityName + "-")
        backAction()
    }
    
    // MARK: - search
    
    func filterContentForSearchText(searchText: String, scope: String = "Title")    {
        
        self.filteredFriendsArr = self.friendsArr.filter({(friend: SearchItem) -> Bool in
            let categoryMatch = (scope == "Title")
            let transliterateString = TransliterationText()
            let stringMatch = friend.name.range(of: searchText)
                if searchText != ""{
                    let transliterateText = transliterateString.transliterate(s: searchText)
                    let clearString = transliterateText.replacingOccurrences(of: "[\\[\\]^+_ <>]", with: "", options: .literal, range: nil)
                    let parsedCityName: String = clearString.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    UserDefaults.standard.set(parsedCityName, forKey: "currentCityName")
                    let forecastController = ForecastController(networkController: (networkController))
                    forecastController.getForecast { [weak self] (networkforcast, error) in
                        let cityName = networkforcast?.city?.name
                        let countryName = networkforcast?.city?.country
                        //guard let `self` = self else { return }
                        print("@@@@@@@@@@ NETWORK CONTROLLER")
                        
                            UserDefaults.standard.set(cityName!, forKey: "searchCityName")
                            UserDefaults.standard.set(countryName!, forKey: "searchCountryName")

                    }
                }

            self.initData()
            confirmSearch = false
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearch searchString: String?) -> Bool {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
                self?.filterContentForSearchText(searchText: (self?.searchBar.text!)!, scope: "Title")
        })
        return true

    }
    
    func searchDisplayController(_ controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: { [weak self] in
              self?.filterContentForSearchText(searchText: (self?.searchDisplayController?.searchBar.text)!, scope: "Title")
        })
        return true
        
    }
    
    
    
    
    
}
