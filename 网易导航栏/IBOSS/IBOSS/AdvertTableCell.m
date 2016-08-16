//
//  AdvertTableCell.m
//  掌上社区
//
//  Created by Hepburn Alex on 14-3-13.
//  Copyright (c) 2014年 iHope. All rights reserved.
//

#import "AdvertTableCell.h"
#import "TouchView.h"
#import "NetImageView.h"
#import "NewsInfo.h"
#import "JSON.h"
#import "PointPageView.h"

@implementation AdvertTableCell {
    PointPageView *mPageView;
    UILabel *mlbName;
    int miPage;
}

@synthesize delegate, OnAdvertSelect, mArray, mDownManager;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       // NSLog(@"adverttablecell init");
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    }
    return self;
}

- (void)reloadData:(NSArray *)array {
    @autoreleasepool {
        if (mScrollView) {
            [mScrollView removeFromSuperview];
            mScrollView = nil;
        }
    }
    self.mArray = array;
    float fWidth = self.contentView.frame.size.width;
    float fHeight = 160;
    mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, fWidth, fHeight)];
    mScrollView.delegate = self;
    mScrollView.contentSize = CGSizeMake(fWidth*array.count, fHeight);
    mScrollView.pagingEnabled = YES;
    mScrollView.showsHorizontalScrollIndicator = NO;
    mScrollView.showsVerticalScrollIndicator = NO;
    [self.contentView addSubview:mScrollView];
    
    for (int i = 0; i < array.count; i ++) {
        NewsInfo *info = [array objectAtIndex:i];
        TouchView *touchView = [[TouchView alloc] initWithFrame:CGRectMake(fWidth*i, 0, fWidth, fHeight)];
        touchView.delegate = self;
        touchView.OnViewClick = @selector(OnViewClick:);
        touchView.tag = i+1000;
        [mScrollView addSubview:touchView];
        
        NetImageView *imageView = [[NetImageView alloc] initWithFrame:touchView.bounds];
        imageView.mImageType = TImageType_CutFill;
        [touchView addSubview:imageView];
        [imageView GetImageByStr:info.m_image];
        
//        NSString *imagename = [[NSBundle mainBundle] resourcePath];
//        imagename = [imagename stringByAppendingPathComponent:info.m_image];
//        [imageView ShowLocalImage:imagename];
        
    }
    UIView *botView = [[UIView alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-24, self.frame.size.width, 24)];
    botView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    botView.backgroundColor = [UIColor colorWithWhite:0.94 alpha:0.8];
    [self.contentView addSubview:botView];
    
    mlbName = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width-70, botView.frame.size.height)];
    mlbName.backgroundColor = [UIColor clearColor];
    mlbName.font = [UIFont systemFontOfSize:14];
    mlbName.textColor = [UIColor blackColor];
    [botView addSubview:mlbName];
    
    miPage = 0;
    mPageView = [[PointPageView alloc] initWithFrame:CGRectMake(self.frame.size.width-60, 0, 60, botView.frame.size.height)];
    mPageView.numberOfPages = array.count;
    mPageView.currentPage = miPage;
    [botView addSubview:mPageView];
    
    [self scrollViewDidEndDecelerating:mScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    miPage = round(scrollView.contentOffset.x/scrollView.frame.size.width);
    mPageView.currentPage = miPage;
    if (miPage < self.mArray.count) {
        NewsInfo *info = [self.mArray objectAtIndex:miPage];
        mlbName.text = info.m_title;
    }
}

- (void)OnViewClick:(TouchView *)sender {
    int index = sender.tag-1000;
    NewsInfo *info = [self.mArray objectAtIndex:index];
    if (delegate && OnAdvertSelect) {
        [delegate performSelector:OnAdvertSelect withObject:info];
    }
}

- (void)dealloc {
   // NSLog(@"adverttablecell dealloc");
    self.mArray = nil;
    [self Cancel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - ImageDownManager

- (void)Cancel {
    SAFE_CANCEL_ARC(self.mDownManager);
}

- (void)LoadNewsPics:(int)iType {
    if (mDownManager) {
        return;
    }
    self.mDownManager = [[ImageDownManager alloc] init];
    mDownManager.delegate = self;
    mDownManager.OnImageDown = @selector(OnLoadFinish:);
    mDownManager.OnImageFail = @selector(OnLoadFail:);
    
    NSArray *array = @[@"newspic", @"hotpic", @"saypic"];
    
    NSString *urlstr = [NSString stringWithFormat:@"http://www.hebradio.com/app/%@/index.json", array[iType]];
    [mDownManager GetImageByStr:urlstr];
  //  NSLog(@"LoadNewsPics:%@", urlstr);
}

- (void)OnLoadFinish:(ImageDownManager *)sender {
    NSString *newstr = [self GetFormatContent:sender.mWebStr];
    NSDictionary *dict = [newstr JSONValue];
    [self Cancel];
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
       // NSLog(@"%@", dict);
        NSArray *array = [dict objectForKey:@"toplist"];
        NSMutableArray *newarray = [NSMutableArray arrayWithCapacity:10];
        for (NSDictionary *tmpdict in array) {
            NewsInfo *info = [NewsInfo CreateWithDict:tmpdict];
            [newarray addObject:info];
            if (newarray.count>=3) {
                break;
            }
        }
        [self reloadData:newarray];
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
}

- (NSString *)GetFormatContent:(NSString *)content {
    if (!content) {
        return content;
    }
    NSMutableString *newcontent = [NSMutableString stringWithString:content];
    NSArray *oldarray = @[@"&", @"\"", @"'"];
    NSArray *newarray = @[@"&amp;", @"&quot;", @"\""];
    
    for (int i = 0; i < oldarray.count; i ++) {
        NSString *oldstr = [oldarray objectAtIndex:i];
        NSString *newstr = [newarray objectAtIndex:i];
        [newcontent replaceOccurrencesOfString:oldstr withString:newstr options:NSCaseInsensitiveSearch range:NSMakeRange(0, newcontent.length)];
    }
    return newcontent;
}

@end
