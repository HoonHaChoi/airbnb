//
//  MapViewController.swift
//  airBnb
//
//  Created by HOONHA CHOI on 2021/05/30.
//

import UIKit
import MapKit
import Combine

class MapViewController: UIViewController {
    
    @IBOutlet weak var cardCollectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    
    // 더미 가격 리스트
    let prices = ["₩82,953", "₩52,953", "₩32,953", "₩112,953", "₩900,953"]
    let locations = [
        CLLocationCoordinate2D(latitude: 37.55769, longitude: 126.92450),
        CLLocationCoordinate2D(latitude: 37.56769, longitude: 126.92450),
        CLLocationCoordinate2D(latitude: 37.57769, longitude: 126.92450),
        CLLocationCoordinate2D(latitude: 37.58769, longitude: 126.92450),
        CLLocationCoordinate2D(latitude: 37.59769, longitude: 126.92450)]
    
    private var searchResultViewModel: SearchResultViewModel?
    private var searchResult: [Room] = []
    private var cancellable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        mapView.delegate = self
        bind()
    }
    
    private func configureCollectionView() {
        cardCollectionView.delegate = self
        cardCollectionView.dataSource = self
        cardCollectionView.register(CardCell.nib, forCellWithReuseIdentifier: CardCell.identifier)
        
        let cellWidth = floor(cardCollectionView.frame.width * 0.85)
        let insetX = (view.bounds.width - cellWidth) / 2.0
        
        cardCollectionView.contentInset = UIEdgeInsets(top: 0, left: insetX, bottom: 0, right: insetX)
        cardCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }
    
    func injectViewModel(atViewModel searchResult: SearchResultViewModel) {
        self.searchResultViewModel = searchResult
    }
    
    private func bind() {
        searchResultViewModel?.fetchSearchResultRooms().sink { [weak self] room in
            self?.searchResult = room
            self?.cardCollectionView.reloadData()
            room.forEach { info in
                print(info.id)
                self?.mapView.addAnnotation(Marker(title: info.rentalFeePerNight.convertWon(),
                                             coordinate: CLLocationCoordinate2D(latitude: info.latitude,
                                                                                longitude: info.longitude)))
            }
        }.store(in: &cancellable)
    }
    
    @IBAction func closeButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MapViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.identifier, for: indexPath) as? CardCell else {
            return .init()
        }
        cell.configure(from: searchResult[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * 0.85, height: 120)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let cellWidthSpacing = cardCollectionView.frame.width * 0.85 + 20
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthSpacing - scrollView.contentInset.left,
                         y: scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
    
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "")
        
        let annotationLabel = BadgeLabel()
        annotationLabel.configure(text: annotation.title ?? "")
        annotationLabel.sizeToFit()
        annotationLabel.updateFrame()
        annotationView.addSubview(annotationLabel)
        annotationView.canShowCallout = true
        return annotationView
    }
}

class Marker: NSObject, MKAnnotation {
    let title: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        super.init()
    }
}
