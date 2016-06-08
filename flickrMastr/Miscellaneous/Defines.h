//
//  Helpers.h
//  flickrMastr
//
//  Created by Louis on 6/7/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APPLICATION [UIApplication sharedApplication]
#define ORIENTATION [UIApplication sharedApplication].statusBarOrientation
#define MAIN_BOUNDS [[UIScreen mainScreen] bounds]
#define SCREEN_WIDTH (((ORIENTATION == UIInterfaceOrientationPortrait) || (ORIENTATION == UIInterfaceOrientationPortraitUpsideDown)) ? MAIN_BOUNDS.size.width : MAIN_BOUNDS.size.height)
#define SCREEN_HEIGHT (((ORIENTATION == UIInterfaceOrientationPortrait) || (ORIENTATION == UIInterfaceOrientationPortraitUpsideDown)) ? MAIN_BOUNDS.size.height : MAIN_BOUNDS.size.width)

#define BLACK [UIColor blackColor]
#define GRAY [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1]
#define WHITE [UIColor whiteColor]
#define BLUE [UIColor colorWithRed:(CGFloat) 23/255 green:(CGFloat) 112/255 blue:(CGFloat) 222/255 alpha:1]

#define EVENT_RELOAD_THUMBNAILS @"EVENT_RELOAD_THUMBNAILS"