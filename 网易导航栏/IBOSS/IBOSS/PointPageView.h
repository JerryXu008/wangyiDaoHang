//
//  PointPageView.h
//  News
//
//  Created by Bruce on 5/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PointPageView : UIView {
	int numberOfPages;
    int currentPage;
}

@property (nonatomic, assign) int currentPage;
@property (nonatomic, assign) int numberOfPages;

@end
