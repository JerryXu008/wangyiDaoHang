//
//  AdvertTableCell.h
//  掌上社区
//
//  Created by Hepburn Alex on 14-3-13.
//  Copyright (c) 2014年 iHope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageDownManager.h"

@interface AdvertTableCell : UITableViewCell<UIScrollViewDelegate> {
    UIScrollView *mScrollView;
}

@property (nonatomic, strong) ImageDownManager *mDownManager;
@property (nonatomic, strong) NSArray *mArray;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL OnAdvertSelect;

- (void)reloadData:(NSArray *)array;
- (void)LoadNewsPics:(int)iType;

@end
