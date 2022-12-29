//
//  HomeVC.swift
//  NewTask
//
//  Created by mohsen on 27/12/2022.
//

import UIKit
import ProgressHUD

class HomeVC: UIViewController , UISearchBarDelegate{
    let searchController = UISearchController(searchResultsController: nil)
    var NewsArr : [Articles] = []
    
    
   var NewsPerPages = 10
   var limit = 10
    var paginationNewsArr : [Articles] = []
    
    
    let homeAPI = "https://newsapi.org/v2/top-headlines?country=us&apiKey=66dab58a179b40908ed070593d7664fb"
    let searchString = "https://newsapi.org/v2/everything?apiKey=66dab58a179b40908ed070593d7664fb&q="
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        registerCell()
        fetchData()
        createSearchBar()
    }
    
    
    //createSearchBar
    func createSearchBar(){
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    private func registerCell(){
        tableView.register(UINib(nibName: HomeTableViewCell.id, bundle: nil), forCellReuseIdentifier: HomeTableViewCell.id)
        
    }
    
    
    //fetch data from api
    func fetchData() {
        NetworkManager.fetchDataRequest( urlString: homeAPI,  type: NewsModel.self) { [self] result in
            switch result{
            case .success(let data):
                print("sssss\(data)")
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    self.NewsArr = data.articles ?? []
                    self.limit = self.NewsArr.count
                    for i in 0..<10{
                        self.paginationNewsArr.append(self.NewsArr[i])
                    }
                    
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("rrr\(error)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
    }
    
    
    
    //set Pagenation News
    func serPagenationNews(NewsPerPages : Int){
        if NewsPerPages >= limit{
            return
        }
        else if NewsPerPages >= limit - 10{
            for i in NewsPerPages..<limit{
                paginationNewsArr.append(NewsArr[i])
            }
            self.NewsPerPages += 10
        }
        else{
            for i in NewsPerPages..<NewsPerPages + 10{
                paginationNewsArr.append(NewsArr[i])
            }
            self.NewsPerPages += 10
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}









extension HomeVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paginationNewsArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.id, for: indexPath) as! HomeTableViewCell
         cell.setUp(NewsList: paginationNewsArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "NewsDetails") as! NewsDetails
        vc.newsDetails = paginationNewsArr[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else{
            return
        }
        
        NetworkManager.searchDataRequest(query : text , urlString: searchString,  type: NewsModel.self) { [self] result in
            switch result{
            case .success(let data):
                print("sssss\(data)")
                DispatchQueue.main.async {
                   
                    self.NewsArr = data.articles ?? []
                    self.tableView.reloadData()
                 }
            case .failure(let error):
                print("rrr\(error)")
            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == tableView{
            if(scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
                serPagenationNews(NewsPerPages: NewsPerPages)
                
            }
        }
    }
    
    
}

