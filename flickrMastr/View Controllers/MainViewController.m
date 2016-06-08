//
//  MainViewController.m
//  flickrMastr
//
//  Created by Louis on 6/7/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import "MainViewController.h"

#import "Defines.h"
#import "Helpers.h"
#import "Flickr.h"
#import "ThumbnailCollectionViewCell.h"

#define CELL_ID @"cellID_MainViewController"

@interface MainViewController ()

@end

@implementation MainViewController

NSTimer *searchTimer;


#pragma mark -
#pragma mark iOS Methods

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self initView];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark View Initialization

- (void)initView {
	self.view.backgroundColor = BLUE;
	
	[self initSearchBar];
	[self initCollectionView];
	
	[_searchBar becomeFirstResponder];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadCollectionView) name:EVENT_RELOAD_THUMBNAILS object:nil];
}

- (void)initCollectionView {
	CGRect collectionViewFrame = CGRectMake(0, CGRectGetMaxY(_searchBar.frame), SCREEN_WIDTH, SCREEN_HEIGHT - CGRectGetMaxY(_searchBar.frame));
	
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

	layout.minimumInteritemSpacing = 0;
	layout.minimumLineSpacing = 0;

	_collectionView = [[UICollectionView alloc] initWithFrame:collectionViewFrame collectionViewLayout:layout];

	[_collectionView registerClass:[ThumbnailCollectionViewCell class] forCellWithReuseIdentifier:CELL_ID];
	_collectionView.backgroundColor = GRAY;
	_collectionView.dataSource = self;
	_collectionView.delegate = self;

	[self.view addSubview:_collectionView];
}

- (void)initSearchBar {
	CGRect searchBarFrame = CGRectMake(0, 22, SCREEN_WIDTH, 44);
	
	_searchBar = [[UISearchBar alloc] initWithFrame:searchBarFrame];
	
	_searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
	_searchBar.barTintColor = BLUE;
	_searchBar.delegate = self;

	_searchBar.placeholder = @"Search flickr";
	_searchBar.spellCheckingType = UITextSpellCheckingTypeNo;
	
	[self.view addSubview:_searchBar];
}


#pragma mark -
#pragma mark UICollectionView Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [Flickr getImageCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	ThumbnailCollectionViewCell *cell = (ThumbnailCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_ID forIndexPath:indexPath];
	
	NSInteger row = indexPath.row;
	
	cell.backgroundColor = WHITE;
	cell.imageView.image = [Helpers getPlaceholderPNG];
	
	if (row < [Flickr getImageCount]) {
		UIImage *cachedThumbnail = [Flickr getCachedThumbnailForIndex:(int)row];
		
		if (cachedThumbnail != nil) {
			[self setImage:cachedThumbnail forCell:cell animated:NO];
			
		} else {
			NSURL *imageURL = [NSURL URLWithString:[Flickr getImageURLForIndex:(int) indexPath.row]];
			
			[Helpers downloadImageWithURL:imageURL completionBlock:^(BOOL succeeded, UIImage *image) {
				if (succeeded) {
					[self setImage:image forCell:cell animated:YES];
					[Flickr setCachedThumbnail:image forIndex:(int) row];
				}
			}];
		}
	}
	
	return cell;
}

- (void) setImage:(UIImage *)image forCell:(ThumbnailCollectionViewCell *)cell animated:(BOOL)animated {
	if (cell != nil) {
		cell.imageView.alpha = 0;
		cell.imageView.image = image;

		if (animated) {
			[UIView beginAnimations:[NSString stringWithFormat:@"ANIMATION_%@", CELL_ID] context:nil];
			[UIView setAnimationDuration:1.5];
			[UIView setAnimationDelay:0];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		}
		
		cell.imageView.alpha = 1;
		
		if (animated) {
			[UIView commitAnimations];
		}
	}
}

- (CGSize)collectionView:(UICollectionView *)collectionView
				  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	float thumbnailLength = (float) SCREEN_WIDTH / 10;
	
	return CGSizeMake(thumbnailLength, thumbnailLength);
}

- (void) reloadCollectionView {
	[_collectionView reloadData];
	[Helpers hideProcessingView];
}


#pragma mark -
#pragma mark UISearchBar Methods

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	[searchTimer invalidate];
	searchTimer = nil;
	
	searchTimer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(runSearch) userInfo:nil repeats:NO];
}

- (void)runSearch {
	[searchTimer invalidate];
	
	NSString *searchText = _searchBar.text;
	
	if ([searchText length] > 0) {
		NSLog (@"Running search for %@", searchText);
	
		[Helpers showProcessingViewWithTitle:@"Searching flickr" onView:self.view];
		[Flickr searchFlickrForKeywords:searchText];
		[_searchBar resignFirstResponder];
		
	} else {
		[Flickr clearImages];
		[_collectionView reloadData];
	}
}

@end
