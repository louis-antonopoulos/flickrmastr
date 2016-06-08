//
//  ProcessingView.h
//  flickrMastr
//
//  Created by Louis on 6/8/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessingView : UIView

- (void) hide;

- (void) showWithTitle:(NSString *)title onView:(UIView *)parentView;

@end
