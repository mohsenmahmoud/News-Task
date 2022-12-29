//
//  HeadlineVC.swift
//  NewTask
//
//  Created by mohsen on 28/12/2022.
//

import UIKit
import SafariServices
import ProgressHUD
class HeadlineVC: UIViewController {
    
    let HeadlineAPI = "https://newsapi.org/v2/top-headlines?country=us&apiKey=66dab58a179b40908ed070593d7664fb"
    
    var HeadlineItem : [Articles] = []
    
    var HeadlinePerPages = 10
    var limit = 10
     var paginationHeadlineItem : [Articles] = []

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ProgressHUD.show()
        registerCells()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    //register Cells
    private func registerCells(){
        collectionView.register(UINib(nibName: HeadlineCell.id, bundle: nil), forCellWithReuseIdentifier: HeadlineCell.id)
    
    }
    
    
    
    //fetch data from api
    func fetchData() {
        NetworkManager.fetchDataRequest(urlString: HeadlineAPI,  type: NewsModel.self) { [self] result in
            switch result{
            case .success(let data):
                print("sssss\(data)")
                DispatchQueue.main.async {
                    ProgressHUD.dismiss()
                    self.HeadlineItem = data.articles ?? []
                    
                    self.limit = self.HeadlineItem.count
                    for i in 0..<10{
                        self.paginationHeadlineItem.append(self.HeadlineItem[i])
                    }
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("rrr\(error)")
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
    }
    
    
    
    
    
    //pagination
    func serPagenationNews(HeadlinePerPages : Int){
        if HeadlinePerPages >= limit{
            return
        }
        else if HeadlinePerPages >= limit - 10{
            for i in HeadlinePerPages..<limit{
                paginationHeadlineItem.append(HeadlineItem[i])
            }
            self.HeadlinePerPages += 10
        }
        else{
            for i in HeadlinePerPages..<HeadlinePerPages + 10{
                paginationHeadlineItem.append(HeadlineItem[i])
            }
            self.HeadlinePerPages += 10
        }
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    

}








extension HeadlineVC : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paginationHeadlineItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCell.id, for: indexPath) as! HeadlineCell
        
        cell.setup(HeadlineList: paginationHeadlineItem[indexPath.row])
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let headlin = paginationHeadlineItem[indexPath.row]
        guard let url = URL(string: headlin.url ?? "") else{
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width/1, height: collectionView.frame.size.height/2.5)
     }
    
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == collectionView{
            if(scrollView.contentOffset.y + scrollView.frame.size.height) >= (scrollView.contentSize.height){
               // setpaginsionProductPage(productPerPage: productPerPage)
                serPagenationNews(HeadlinePerPages: HeadlinePerPages)
                
            }
        }
    }
    
    
    
    
    
}
