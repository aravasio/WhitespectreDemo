//
//  ViewController.swift
//  WhiteSpectreDemo
//
//  Created by Alejandro Ravasio on 06/06/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //How far down the pagination we're. It starts at 0 and can go up to N where N is Int.max.
    internal var currentPage = 0
    
    //A constant to determine when to fetch the results; anytime the difference between current displayed cell and your total results fall below this number you want to fetch the results and reload the table
    internal let fetchThreshold = 3
    
    // a boolean to determine whether API has more results or not
    private var canFetchMoreResults = true
    
    // The gif data.
    fileprivate var gifs: [GIFObject] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextField()
        configureCollectionView()
        getData()
    }
    
    fileprivate func configureTextField() {
        searchField.addTarget(self, action: #selector(searchFieldChanged), for: .editingChanged)
    }
    
    @objc private func searchFieldChanged() {
        currentPage = 0
        getData()
    }
    
    // Sends a request for more data to the API.
    fileprivate func getData() {
        if let text = searchField.text, !text.isEmpty {
            if currentPage == 0 {
                gifs = []
            }
            API.getGifs(for: text, page: currentPage) { [weak self] results in
                self?.canFetchMoreResults = !results.isEmpty
                self?.gifs.append(contentsOf: results)
            }
        }
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: GifCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: GifCell.identifier)
    }
    
}

extension ViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GifCell.identifier, for: indexPath) as! GifCell
        cell.imageView.sd_cancelCurrentImageLoad()
        
        let data = gifs[indexPath.row]
        if let urlString = data.url {
            let url = URL(string: urlString)
            cell.imageView.sd_setImage(with: url, completed: nil)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  20
        let collectionViewSize = collectionView.frame.size.width - padding
        
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
    
    /*
     This is the method that makes it all happen. With this method you can determine if a cell is going to show up in the TableView.
     You can use this to your advantage by firing off a request when use is almost about to reach to the end of table
     */
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (gifs.count - indexPath.row) == fetchThreshold && canFetchMoreResults {
            currentPage += 1
            getData()
        }
    }
}
