//
//  Helpers.h
//  flickrMastr
//
//  Created by Louis on 6/8/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helpers : NSObject

+ (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock;

+ (NSString *) encodeStringForHTML:(NSString *)input;

+ (UIImage *) getPlaceholderPNG;

+ (UIImage *) getPNGNamed:(NSString *)imageName;

+ (void) hideProcessingView;

+ (void) showProcessingViewWithTitle:(NSString *)title onView:(UIView *)parentView;

@end
