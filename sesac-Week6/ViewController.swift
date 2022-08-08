//
//  ViewController.swift
//  sesac-Week6
//
//  Created by 나지운 on 2022/08/08.
//

import UIKit

import Alamofire
import Kingfisher
import SwiftyJSON

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var blogList = [String]()
    var cafeList = [String]()
    
    var isExpanded = false // false 2줄, true 0으로

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBlog()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension // 모든 섹션의 셀에 대해서 유동적!
    }
    
    @IBAction func cliecked(_ sender: Any) {
        isExpanded = !isExpanded
        tableView.reloadData()
    }
    
    
    func searchBlog() {
        KakaoBlogSearchAPIManger.shared.callRequest(type: EndPoint.blog ,search: "https://brunch.co.kr/@tourism") { json in

            for item in json["documents"].arrayValue {
                self.blogList.append(item["contents"].stringValue.description.replacingOccurrences(of: "<b>", with: ""))
            }
            self.searchCafe()
        }
    }
    
    func searchCafe() {
        KakaoBlogSearchAPIManger.shared.callRequest(type: EndPoint.cafe ,search: "뉴진스") { json in
            for item in json["documents"].arrayValue {
                self.cafeList.append(item["contents"].stringValue.description.replacingOccurrences(of: "<b>", with: ""))
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "블로그 검색" : "카페 검색"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? blogList.count : cafeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "kakaoCell", for: indexPath) as? kakaoCell else { return UITableViewCell()}
        
        cell.resultLabel.numberOfLines = isExpanded ? 0 : 2
        cell.resultLabel.text = indexPath.row == 0 ? blogList[indexPath.row] : cafeList[indexPath.row]
        
        return cell
    }
    
}

class kakaoCell: UITableViewCell {
    
    @IBOutlet weak var resultLabel: UILabel!
}
