//
//  TopTenViewController.swift
//  Cards Match
//
//  Created by user196683 on 5/23/21.
//

import UIKit
import MapKit

class TopTenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    
    @IBOutlet weak var rList: UITableView!
    
    @IBOutlet weak var mapView: MKMapView!
    struct Player {
        var name : String
        var time : String
        var moves : String
        
        init(name: String, time: String, moves: String) {
            self.name = name
            self.time = time
            self.moves = moves
        }
    }
    var topTen : [Player] = []
    var testName = "testy"
    var testTime1 = "17.5"
    var testTime2 = "15.6"
    var testTries = "5"
    

    @IBOutlet weak var myTableView: UITableView!
    
        override func viewDidLoad() {
            super.viewDidLoad()
            myTableView.dataSource = self
            myTableView.delegate = self
            
            topTen.append(Player(name: testName,time: testTime1, moves: testTries))
            if topTen.isEmpty{
                topTen.append(Player(name: testName,time: testTime1, moves: testTries))
                print(topTen)
            }else{
                for i in 0...topTen.count - 1{
    
                    if topTen[i].time > testTime2{
                        let x = topTen[i].name
                        let y = topTen[i].time
                        let z = topTen[i].moves
                        topTen[i].name = testName
                        topTen[i].time = testTime2
                        topTen[i].moves = testTries
                        var temp : [Player] = []
                        temp.append(Player(name: x,time: y, moves: z))
                        topTen.insert(contentsOf: temp, at: i+1)
                        print(topTen)
                    }
                    
                }
            }
           
        }
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section:Int) -> Int{
        return topTen.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath)
        
        cell.textLabel!.text = "Name: " + topTen[indexPath.row].name + "  Time: "  + topTen[indexPath.row].time + "  Moves: " + topTen[indexPath.row].moves
        
        
        return cell
    }
}
