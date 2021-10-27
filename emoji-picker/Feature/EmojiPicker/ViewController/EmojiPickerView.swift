//
//  EmojiPickerView.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import UIKit

final class EmojiPickerView: View {

    let searchBarTextSubject = PassthroughSubject<String, Never>()
    let selectedIndexSubject = PassthroughSubject<IndexPath, Never>()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: EmojiPickerView.layout)
    private let searchBar = UISearchBar()

    init() {
        super.init(frame: .zero)
        setup()
        makeConstraints()
    }
}

private extension EmojiPickerView {

    func setup() {
        backgroundColor = .white

        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self

        collectionView.delegate = self
        collectionView.backgroundColor = .white
        collectionView.register(EmojiCollectionViewCell.self)
        collectionView.registerHeader(EmojiCategoryCollectionViewHeader.self)

        addSubview(collectionView)
        addSubview(searchBar)
    }

    func makeConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15.0)
            make.trailing.leading.equalToSuperview().inset(5.0)
        }

        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(5.0)
            make.trailing.leading.bottom.equalToSuperview().inset(10.0)
        }
    }
}

extension EmojiPickerView: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBarTextSubject.send(searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
}

extension EmojiPickerView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndexSubject.send(indexPath)
    }
}

private extension EmojiPickerView {

    static var layout: UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(60.0),
                                              heightDimension: .absolute(60.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .estimated(60.0))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 8)
        let section = NSCollectionLayoutSection(group: group)
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                heightDimension: .absolute(25.0))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                        elementKind: UICollectionView.elementKindSectionHeader,
                                                                        alignment: .top)
        section.boundarySupplementaryItems = [sectionHeader]
        return UICollectionViewCompositionalLayout(section: section)
    }
}
