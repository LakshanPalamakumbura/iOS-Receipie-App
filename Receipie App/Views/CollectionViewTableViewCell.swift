//
//  CollectionViewTableViewCell.swift
//  Receipie App
//
//  Created by Lakshan Palamakumbura on 2022-12-14.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {

    static let identifier = "CollectionViewTableViewCell"
    
    private var responses: [Response] = [Response]()

//    private var responses: [Response] = []()
    
    private let collectionView: UICollectionView = {

        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 140, height: 200)
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ResponseCollectionViewCell.self, forCellWithReuseIdentifier: ResponseCollectionViewCell.identifier)
        return collectionView
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder){
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = contentView.bounds
    }
    
    public func configure(with responses: [Response]) {
        self.responses = responses
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }

}

extension CollectionViewTableViewCell:  UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        //        cell.backgroundColor = .green
        //        return cell
                
        

                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ResponseCollectionViewCell.identifier, for: indexPath) as? ResponseCollectionViewCell else {
                    return UICollectionViewCell()
                }
        
        guard let model = responses[indexPath.row].image else {
                    return UICollectionViewCell()
           }
//
   
//        print(responses[indexPath.row].name)
//        cell.configure(with: responses[indexPath.row].name)
//        cell.configure(with: "")
        cell.configure(with: model)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return responses.count
    }



}
