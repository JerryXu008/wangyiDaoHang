//
//  NewsTableCell.h
//  Tamil
//
//  Created by iHope on 13-11-5.
//  Copyright (c) 2013年 Tamil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NetImageView.h"
#import "NewsInfo.h"

@interface NewsTableCell : UITableViewCell {
    NetImageView *mImageView;
    UILabel *mlbTitle;
    UILabel *mlbDesc;
}

- (void)LoadNewsInfo:(NewsInfo *)info;

@end
