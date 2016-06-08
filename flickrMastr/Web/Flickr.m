//
//  Flickr.m
//  flickrMastr
//
//  Created by Louis on 6/7/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import "Flickr.h"

#import "Defines.h"
#import "Helpers.h"

@implementation Flickr

#define API_KEY @"f97ec10bde148b23790c1d2a9f666841"

static NSMutableArray *cachedThumbnailArray;
static NSMutableArray *imageURLArray;

+ (void) clearImages {
	if (imageURLArray == nil) {
		imageURLArray = [[NSMutableArray alloc] init];
		
	} else {
		[imageURLArray removeAllObjects];
	}
	
	if (cachedThumbnailArray == nil) {
		cachedThumbnailArray = [[NSMutableArray alloc] init];
		
	} else {
		[cachedThumbnailArray removeAllObjects];
	}
}

+ (int) getImageCount {
	return (int) [imageURLArray count];
}


+ (UIImage *) getCachedThumbnailForIndex:(int)imageIndex {
	UIImage *retObj = nil;
	
	if (imageIndex < [cachedThumbnailArray count]) {
		NSObject *tempObject = [cachedThumbnailArray objectAtIndex:imageIndex];
		
		if (tempObject != [NSNull null]) {
			retObj = (UIImage *) tempObject;
		}
	}
	
	return retObj;
}

+ (NSString *) getImageURLForIndex:(int)imageIndex {
	NSString *retVal = @"";
	
	if (imageIndex < [imageURLArray count]) {
		retVal = [imageURLArray objectAtIndex:imageIndex];
	}
	
	return retVal;
}

+ (void) searchFlickrForKeywords:(NSString *)keywords {
	if ([keywords length] > 0) {
		[self clearImages];
		
		// https://www.flickr.com/services/api/flickr.photos.search.html
		// greekFlickr will return at most the first 4,000 results for any given search query.
		NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&safe_search=1&per_page=4000&format=json&nojsoncallback=1",
							   API_KEY,
							   [Helpers encodeStringForHTML:keywords]];
		
		// NSLog (@"%@", urlString);
		
		NSURL *url = [NSURL URLWithString:urlString];

		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		[NSURLConnection  sendAsynchronousRequest:request
											queue:[NSOperationQueue mainQueue]
								completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
		 {
			if (data.length > 0 && connectionError == nil) {
				NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
																	 options:0
																	   error:NULL];
				 
				NSDictionary *summary = json[@"photos"];
				NSArray *photos = summary[@"photo"];
				
				// NSLog (@"Pages: %@", summary[@"pages"]);
				// NSLog (@"Total: %@", summary[@"total"]);
				
				for (NSDictionary *nextPhoto in photos) {
					NSString *farmID = nextPhoto[@"farm"];
					NSString *serverID = nextPhoto[@"server"];
					NSString *imageID = nextPhoto[@"id"];
					NSString *secret = nextPhoto[@"secret"];
					
					// https://www.flickr.com/services/api/misc.urls.html
					NSString *thumbnailURL = [NSString stringWithFormat:@"https://farm%@.staticflickr.com/%@/%@_%@_t.jpg",
											  farmID,
											  serverID,
											  imageID,
											  secret];
					
					// NSLog (@"ImageURL: %@ (%@)", thumbnailURL, nextPhoto[@"title"]);
					[imageURLArray addObject:thumbnailURL];
					[cachedThumbnailArray addObject:[NSNull null]];
				}
				
				[[NSNotificationCenter defaultCenter] postNotificationName:EVENT_RELOAD_THUMBNAILS object:nil userInfo:nil];
			 }
		 }];
	}
}

+ (void) setCachedThumbnail:(UIImage *)image forIndex:(int)imageIndex {
	if (imageIndex < [cachedThumbnailArray count]) {
		[cachedThumbnailArray replaceObjectAtIndex:imageIndex withObject:image];
	}
}

@end
