//
//  ThumbnailCollectionViewCell.m
//  flickrMastr
//
//  Created by Louis on 6/8/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import "ThumbnailCollectionViewCell.h"

@implementation ThumbnailCollectionViewCell

- (UIImageView *) imageView {
	if (_imageView == nil) {
		_imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
		
		_imageView.clipsToBounds = YES;
		_imageView.contentMode = UIViewContentModeScaleAspectFill;
		
		[self.contentView addSubview:_imageView];
	}
	
	return _imageView;
}

- (void)prepareForReuse {
	[super prepareForReuse];
	
	[_imageView removeFromSuperview];
	_imageView = nil;
}

@end
