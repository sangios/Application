//
//  HotKeywordsViewController.swift
//  Application
//
//  Created by Sang Nguyen on 3/16/19.
//  Copyright © 2019 Sang Nguyen. All rights reserved.
//

import UIKit

class HotKeywordsViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel = HotKeywordsListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupCollectionView() {
        collectionView.register(HotKeywordCell.nib, forCellWithReuseIdentifier: HotKeywordCell.identifier)
        
        viewModel.updateKeywordsAction = { [weak self] (viewModel, error) in
            if error != nil || viewModel.count == 0 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    self?.viewModel.loadKeywords()
                })
            }
            self?.hideLoadingView()
            self?.collectionView.reloadData()
        }
        
        self.showLoadingView()
        viewModel.loadKeywords()
    }
}

extension HotKeywordsViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HotKeywordCell.identifier, for: indexPath) as! HotKeywordCell
        
        let colorIndex = indexPath.row % HotKeywordCell.ContentColor.count
        let hexColor = HotKeywordCell.ContentColor[colorIndex]
        let color = UIColor.colorWithHexString(hex: hexColor)
        cell.bind(viewModel: viewModel[indexPath], color: color)
        
        return cell
    }
}

extension HotKeywordsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: Do action for the selected keyword
        logger.info("Select: \(viewModel[indexPath].text)")
    }
}

extension HotKeywordsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let vm = viewModel[indexPath]
        if vm.calculatedSize == nil {
            vm.calculatedSize = HotKeywordCell.getSizeForText(vm.text)
        }
        return vm.calculatedSize!
    }
}
