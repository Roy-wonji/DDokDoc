//
//  SearchBeginViewController.swift
//  DdokDoc
//
//  Created by Roy 2023/08/05.
//

import UIKit

class SearchBeginViewController: UIViewController {


    // ๐ ์์น Results์ปจํธ๋กค๋ฌ โญ๏ธ
    let searchController = UISearchController(searchResultsController: UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController)

    var networkManager = KakaoLocalDataManager.shared

    //BUTTONS
    @IBOutlet weak var locbutton: UIButton!
    @IBOutlet weak var datebutton: UIButton!
    @IBOutlet weak var entbutton: UIButton!
    @IBOutlet weak var eyebutton: UIButton!
    
    
    // MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        configureUI()
    
        


    }
    
    // MARK: - NAV BAR CUSTOMIZE
    
    func configureNavBAR() {
        
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.backIndicatorImage = UIImage (named: "chevron.left")
    }
    
    // MARK: - BASIC UIs
    
    func configureUI(){
        locbutton.layer.cornerRadius = 5
        locbutton.clipsToBounds = true
        datebutton.layer.cornerRadius = 5
        datebutton.clipsToBounds = true
        
        entbutton.layer.cornerRadius = 10
        entbutton.clipsToBounds = true
        eyebutton.layer.cornerRadius = 10
        eyebutton.clipsToBounds = true
        
    }
    

    // MARK: - SEARCHBAR
    func setupSearchBar() {
        var bounds = UIScreen.main.bounds
        var width = bounds.size.width //ํ๋ฉด ๋๋น
        let searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width - 28, height: 0))
        searchBar.placeholder = "์ฆ์ ๋๋ ๋ณ์์ ๊ฒ์ํด๋ณด์ธ์."
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchBar)
        navigationItem.searchController = searchController



        // ๐ ์์น(๊ฒฐ๊ณผ)์ปจํธ๋กค๋ฌ์ ์ฌ์ฉ (๋ณต์กํ ๊ตฌํ ๊ฐ๋ฅ)
        //     ==> ๊ธ์๋ง๋ค ๊ฒ์ ๊ธฐ๋ฅ + ์๋ก์ด ํ๋ฉด์ ๋ณด์ฌ์ฃผ๋ ๊ฒ๋ ๊ฐ๋ฅ
        searchController.searchResultsUpdater = self

        // ์ฒซ๊ธ์ ๋๋ฌธ์ ์ค์? ์์?๊ธฐ
        searchController.searchBar.autocapitalizationType = .none
    }



}

extension SearchBeginViewController : UISearchResultsUpdating {
    // ์?์?๊ฐ ๊ธ์๋ฅผ ์๋?ฅํ๋ ์๊ฐ๋ง๋ค ํธ์ถ๋๋ ๋ฉ์๋ ===> ์ผ๋ฐ์?์ผ๋ก ๋ค๋ฅธ ํ๋ฉด์ ๋ณด์ฌ์ค๋ ๊ตฌํ
    func updateSearchResults(for searchController: UISearchController) {
        print("์์น๋ฐ์ ์๋?ฅ๋๋ ๋จ์ด", searchController.searchBar.text ?? "")
        // ๊ธ์๋ฅผ ์น๋ ์๊ฐ์ ๋ค๋ฅธ ํ๋ฉด์ ๋ณด์ฌ์ฃผ๊ณ? ์ถ๋ค๋ฉด (์ปฌ๋?์๋ทฐ๋ฅผ ๋ณด์ฌ์ค)
        let vc = searchController.searchResultsController as! SearchViewController
        // ์ปฌ๋?์๋ทฐ์ ์ฐพ์ผ๋?ค๋ ๋จ์ด ์?๋ฌ
        vc.searchTerm = searchController.searchBar.text ?? ""
    }
}
