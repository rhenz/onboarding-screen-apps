//
//  ViewController.swift
//  onboarding-fashing-app
//
//  Created by John Salvador on 8/28/22.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet var nextButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var containerView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    // MARK: - Properties
    private let items: [OnboardingItem] = OnboardingItem.createSampleData()
    
    var currentIndex: Int {
        Int(collectionView.contentOffset.x / collectionView.frame.width)
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupPageControl()
    }
}

// MARK: - Helper Methods

extension OnboardingViewController {
    private func showNextOnboardingScreen(at indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        updatePageControl(with: indexPath.item)
    }
    
    private func updatePageControl(with index: Int) {
        pageControl.currentPage = index
    }
}

// MARK: - Setup UI

extension OnboardingViewController {
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = items.count
    }
}


// MARK: - Actions

extension OnboardingViewController {
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        guard currentIndex < items.count-1 else { return }
        let nextRow = currentIndex + 1
        let nextIndexPath = IndexPath(row: nextRow, section: 0)
        
        showNextOnboardingScreen(at: nextIndexPath)
    }
}

// MARK: - Collection View Datasource

extension OnboardingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! QuoteCollectionViewCell
        let item = items[indexPath.row]
        cell.configure(with: item)
        return cell
    }
}

// MARK: - Collection View Delegate

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 0
    }
}

// MARK: - Scroll View Delegate

extension OnboardingViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl(with: currentIndex)
    }
}
