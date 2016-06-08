//
//  Flickr.h
//  flickrMastr
//
//  Created by Louis on 6/7/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Flickr : NSObject

+ (void) clearImages;

+ (int) getImageCount;

+ (UIImage *) getCachedThumbnailForIndex:(int)imageIndex;

+ (NSString *) getImageURLForIndex:(int)imageIndex;

+ (void) searchFlickrForKeywords:(NSString *)keywords;

+ (void) setCachedThumbnail:(UIImage *)image forIndex:(int)imageIndex;

@end
