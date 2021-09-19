//
//  ViewController.swift
//  Demo_InitialD_Multiple_Session
//
//  Created by 蔡忠翊 on 2021/9/19.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.collectionViewLayout = generateLayout()
    }
    
    // 多個 section
//    func generateLayout() -> UICollectionViewLayout {
//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(300))
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 10
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 30, trailing: 0)
//        section.orthogonalScrollingBehavior = .groupPaging
//        return UICollectionViewCompositionalLayout(section: section)
//    }
    
    // Demo2第一個 section 一次顯示一張圖，第二個 section 一次顯示兩張圖
//    func generateLayout() -> UICollectionViewLayout {
//            UICollectionViewCompositionalLayout { sectionIndex, environment in
//
//                let itemCountInGroup = sectionIndex == 0 ? 1 : 2
//                let ratio = 1 / Double(itemCountInGroup)
//                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(ratio), heightDimension: .fractionalWidth(ratio))
//                let item = NSCollectionLayoutItem(layoutSize: itemSize)
//                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
//                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
//                let section = NSCollectionLayoutSection(group: group)
//                section.interGroupSpacing = 10
//                section.orthogonalScrollingBehavior = .groupPaging
//                return section
//            }
//    }
    
    // Demo 3 整個頁面垂直捲動，頁面裡有水平捲動的區塊
    var firstSection: NSCollectionLayoutSection {
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(300), heightDimension: .absolute(300))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 10
            section.orthogonalScrollingBehavior = .groupPaging
            return section
    }
    
    var secondSection: NSCollectionLayoutSection {
            let padding: Double = 10
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalWidth(1/2))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: padding, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = padding
            section.contentInsets = NSDirectionalEdgeInsets(top: padding, leading: 0, bottom: padding, trailing: padding)
            return section
    }
    
    func generateLayout() -> UICollectionViewLayout {
        // 定義回傳 NSCollectionLayoutSection 的 computed property seiyaSection & spiderManSection。值得注意的，在產生 UICollectionViewCompositionalLayout 時必須加上 capture list [unowned self]，不然會產生 reference cycle 的記憶體問題
        
            UICollectionViewCompositionalLayout { [unowned self] sectionIndex, environment in
                if sectionIndex == 0 {
                    return self.firstSection
                } else {
                    return self.secondSection
                }
            }
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 9
        } else {
            return 8
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as! CollectionViewCell
        if indexPath.section == 0 {
            cell.imageView.image = UIImage(named: "Image\(indexPath.item + 1)")
        } else {
            cell.imageView.image = UIImage(named: "Product\(indexPath.item + 1)")
        }
        return cell
    }
}
