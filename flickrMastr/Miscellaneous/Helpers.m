//
//  Helpers.m
//  flickrMastr
//
//  Created by Louis on 6/8/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import "Helpers.h"

#import "ProcessingView.h"

@implementation Helpers

static UIImage *placeholderPNG;
static ProcessingView *processingView;

// Modified from https://www.natashatherobot.com/ios-how-to-download-images-asynchronously-make-uitableview-scroll-fast/
+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock {
//	[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//		if (!error) {
//			UIImage *image = [[UIImage alloc] initWithData:data];
//			completionBlock(YES, image);
//			
//		} else {
//			completionBlock(NO,nil);
//		}
//	}];
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

	[NSURLConnection sendAsynchronousRequest:request
									   queue:[NSOperationQueue mainQueue]
						   completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
							   if (!error) {
								   UIImage *image = [[UIImage alloc] initWithData:data];
								   completionBlock(YES, image);
							   
							   } else{
								   completionBlock(NO,nil);
							   }
						   }];
}


+ (NSString *) encodeStringForHTML:(NSString *)input {
	if ([input length] > 0) {
		return [input stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
		
	} else {
		return @"";
	}
}

+ (UIImage *) getPlaceholderPNG {
	if (placeholderPNG == nil) {
		placeholderPNG = [Helpers getPNGNamed:@"placeholder"];
	}
	
	return placeholderPNG;
}

+ (UIImage *) getPNGNamed:(NSString *)imageName {
	UIImage *retObj = nil;
	
	if ([imageName length] > 0) {
		NSString *pathFile = [NSString stringWithFormat:@"Images.bundle/%@.png", imageName];

		retObj = [UIImage imageNamed:pathFile];
	}
	
	return retObj;
}

+ (void) hideProcessingView {
	if (processingView != nil) {
		[processingView hide];
	}
}

+ (void) showProcessingViewWithTitle:(NSString *)title onView:(UIView *)parentView {
	if (processingView == nil) {
		processingView = [[ProcessingView alloc] init];
	}
	
	[processingView showWithTitle:title onView:parentView];
}

@end
