//
//  ViewController.swift
//  onboarding-fashion-app
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
    
    private var imageViews: [UIImageView] = []
    
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
        setupImageViews()
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
    
    private func setupImageViews() {
        items.forEach {
            let imageView = UIImageView(image: UIImage(named: $0.imageName))
            imageView.contentMode = .scaleAspectFill
            imageView.alpha = 0.0
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.clipsToBounds = true
            containerView.addSubview(imageView)
            
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
                imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
                imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
            
            self.imageViews.append(imageView)
        }
        imageViews.first?.alpha = 1.0
        containerView.bringSubviewToFront(collectionView)
    }
    
    private func showMainScreen() {
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: MainViewController.storyboardId) as? MainViewController,
              let window = self.view.window
        else {
            fatalError("Failed to initialize MainViewController from Storyboard and this should not fail.")
        }
        
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
        UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
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
        
        let isLastIndex = indexPath.row == items.count-1
        cell.showExploreButton(shouldShow: isLastIndex)
        if isLastIndex { cell.delegate = self }
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let willDisplayLastIndex = indexPath.row == items.count-1
        nextButton.isUserInteractionEnabled = !willDisplayLastIndex
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let isShowingLastIndex = currentIndex == items.count - 1
        UIView.animate(withDuration: 0.4, delay: 0, options: .transitionCrossDissolve) {
            self.nextButton.alpha = isShowingLastIndex ? 0 : 1
        }
    }
}

// MARK: - Scroll View Delegate

extension OnboardingViewController {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePageControl(with: currentIndex)
    }
    
    var collectionViewWidth: CGFloat { collectionView.frame.size.width }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let fadeInAlpha = (x - collectionViewWidth * CGFloat(currentIndex)) / collectionViewWidth
        let fadeOutAlpha = CGFloat(1 - fadeInAlpha)
        
        let hasNextOrPreviousItem = (currentIndex < items.count - 1)
        
        if hasNextOrPreviousItem {
            imageViews[currentIndex].alpha = fadeOutAlpha
            imageViews[currentIndex + 1].alpha = fadeInAlpha
        }
        
    }
}

// MARK: - Quote Collection View Cell Delegate

extension OnboardingViewController: QuoteCollectionViewCellDelegate {
    func quoteCollectionViewCell(_ cell: QuoteCollectionViewCell, didTapExploreButton button: UIButton) {
        showMainScreen()
    }
}
