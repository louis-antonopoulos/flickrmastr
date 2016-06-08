//
//  MainViewController.h
//  flickrMastr
//
//  Created by Louis on 6/7/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UISearchBar *searchBar;

@end
