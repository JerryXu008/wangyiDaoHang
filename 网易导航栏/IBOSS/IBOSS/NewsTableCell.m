//
//  NewsTableCell.m
//  Tamil
//
//  Created by iHope on 13-11-5.
//  Copyright (c) 2013年 Tamil. All rights reserved.
//

#import "NewsTableCell.h"

@implementation NewsTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        mImageView = [[NetImageView alloc] initWithFrame:CGRectMake(11, 9, 70, 56)];
        mImageView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
        mImageView.mDefaultPath = @"f_goodback";
        mImageView.mImageType = TImageType_CutFill;
        [self.contentView addSubview:mImageView];
        
        mlbTitle = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, self.contentView.frame.size.width-100, 20)];
        mlbTitle.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        mlbTitle.backgroundColor = [UIColor clearColor];
        mlbTitle.font = [UIFont systemFontOfSize:16];
        mlbTitle.textColor = [UIColor blackColor];
        [self.contentView addSubview:mlbTitle];
        
        mlbDesc = [[UILabel alloc] initWithFrame:CGRectMake(90, 32, self.contentView.frame.size.width-100, 35)];
        mlbDesc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        mlbDesc.backgroundColor = [UIColor clearColor];
        mlbDesc.font = [UIFont systemFontOfSize:12];
        mlbDesc.textColor = [UIColor grayColor];
        mlbDesc.numberOfLines = 2;
        [self.contentView addSubview:mlbDesc];
        
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-1, self.contentView.frame.size.width, 1)];
        lineView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleWidth;
        lineView.image = [UIImage imageNamed:@"f_tableline.png"];
        [self.contentView addSubview:lineView];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)LoadNewsInfo:(NewsInfo *)info {
    NSRange range = [info.m_image rangeOfString:@"http://"];
    if (range.length>0) {
        [mImageView GetImageByStr:info.m_image];
    }
    else {
        NSString *path = [[NSBundle mainBundle] resourcePath];
        path = [path stringByAppendingPathComponent:info.m_image];
        [mImageView ShowLocalImage:path];
    }
    mlbTitle.text = info.m_title;
    mlbDesc.text = info.m_abstract;
}

@end
