//
//  FlagsViewController.swift
//  DiffableCollectionViews
//
//  Created by Spencer Curtis on 8/13/20.
//  Copyright © 2020 Lambda School. All rights reserved.
//

import UIKit

class FlagsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    typealias FlagsDataSource = UICollectionViewDiffableDataSource<Int, String>
    typealias FlagsSnapShot = NSDiffableDataSourceSnapshot<Int, String>
    
    // The item type is a string bc the "model" of the app is just a state's string. In a real app this might be a model object such as a Restaurant.
    lazy var dataSource: FlagsDataSource = {
        let dataSource = FlagsDataSource(collectionView: collectionView) {
            // can put model object in place of state, this closure is doing what it wants us to do in cell for row at index path
            (collectionView, indexPath, state) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FlagCell", for: indexPath) as? FlagCollectionViewCell else { return nil }
            
            let flagImage = UIImage(named: state)
            cell.imageView.image = flagImage
            
            return cell
        }
        
        return dataSource
    }()
    
    var states = States.all
    
    override func viewDidLoad() {
        collectionView.dataSource = dataSource
        sortDataSource()
    }
    
    @IBAction func changeSorting(_ sender: Any) {
        sortDataSource()
    }
    
    private func sortDataSource() {
        var snapshot = FlagsSnapShot()
        
        var states = self.states
        
        switch sortSegmentedControl.selectedSegmentIndex {
            // A - Z
        case 0:
            break
            // Z - A
        case 1:
            states.reverse()
            // Random
        case 2:
            states.shuffle()
        default:
            break
        }
        
        // Determine how the collection view should be structured. How many sections do I want, how many cells do I want? What should the information in those cells be?
        
        // This is where you put your sections, for this example the dection identifiers are numbers, for your own app it will most likely be your model objects
        
        // Create a single section
        snapshot.appendSections([0])
        // Create a cell for each state in this array
        snapshot.appendItems(states)
        
        dataSource.apply(snapshot)
    }
}
