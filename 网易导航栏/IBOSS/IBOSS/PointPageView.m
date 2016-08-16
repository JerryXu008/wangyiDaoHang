//
//  PointPageView.m
//  News
//
//  Created by Bruce on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PointPageView.h"

@implementation PointPageView

@synthesize numberOfPages, currentPage;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        numberOfPages = 0;
        currentPage = 0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/

- (void)dealloc {
}

- (void)setNumberOfPages:(int)value {
    @autoreleasepool {
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
    }
	numberOfPages = value;
	int iTop = (self.frame.size.height-5)/2;
	int iLeft = self.frame.size.width-10*numberOfPages;
	for (int i = 0; i < numberOfPages; i ++) {
		UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(iLeft+i*10, iTop, 5, 5)];
		imageView.tag = i+100;
		[self addSubview:imageView];
	}
    self.currentPage = 0;
}

- (void)setCurrentPage:(int)index {
    currentPage = index;
	for (int i = 0; i < numberOfPages; i ++) {
		UIImageView *imageView = (UIImageView *)[self viewWithTag:i+100];
		if (index == i) {
			imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"f_blackpoint" ofType:@"png"]];
		}
		else {
			imageView.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"f_graypoint" ofType:@"png"]];
		}
	}
}

@end
