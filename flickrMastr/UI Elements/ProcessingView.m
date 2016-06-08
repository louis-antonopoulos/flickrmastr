//
//  ProcessingView.m
//  flickrMastr
//
//  Created by Louis on 6/8/16.
//  Copyright © 2016 Louis Antonopoulos. All rights reserved.
//

#import "ProcessingView.h"

#import "Defines.h"

@implementation ProcessingView

int const ACTIVITY_INDICATOR_WIDTH = 50;
int const FRAME_WIDTH = 250;
int const FRAME_HEIGHT = 100;

UIActivityIndicatorView *activityIndicator;

UIView *backgroundView;
UIView *maskView;

UILabel *lblTitle;

- (id) init {
	if(self = [super init]) {
		maskView = [[UIView alloc] init];
		
		maskView.alpha = 0.1;
		maskView.backgroundColor = BLACK;
		maskView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
		
		backgroundView = [[UIView alloc] init];
		
		backgroundView.alpha = 0.85;
		backgroundView.backgroundColor = BLACK;
		backgroundView.frame = CGRectMake(0, 0, FRAME_WIDTH, FRAME_HEIGHT);
		backgroundView.layer.cornerRadius = 16;
		
		activityIndicator = [[UIActivityIndicatorView alloc] init];
		
		activityIndicator.color = WHITE;
		activityIndicator.frame = CGRectMake(0, 0, ACTIVITY_INDICATOR_WIDTH, ACTIVITY_INDICATOR_WIDTH);
		
		lblTitle = [[UILabel alloc] init];
		
		lblTitle.font = [UIFont boldSystemFontOfSize:20];
		lblTitle.textAlignment = NSTextAlignmentCenter;
		lblTitle.textColor = WHITE;
		
		self.frame = maskView.frame;
		[self addSubview:maskView];
		[self addSubview:backgroundView];
		[self addSubview:activityIndicator];
		[self addSubview:lblTitle];
	}
	
	return self;
}

- (void) hide {
	[activityIndicator stopAnimating];
	[self removeFromSuperview];
}

- (void) showWithTitle:(NSString *)title onView:(UIView *)parentView {
	if (parentView != nil) {
		CGPoint center = maskView.center;
		
		backgroundView.center = center;
		
		lblTitle.text = title;
		[lblTitle sizeToFit];
		
		center.x += 16;
		
		lblTitle.center = center;
		
		activityIndicator.center = lblTitle.center;
		
		CGRect activityIndicatorFrame = activityIndicator.frame;
		 
		activityIndicatorFrame.origin.x = lblTitle.frame.origin.x - ACTIVITY_INDICATOR_WIDTH + 8;
		
		activityIndicator.frame = activityIndicatorFrame;
		[activityIndicator startAnimating];
		
		[parentView addSubview:self];
	}
}

@end
