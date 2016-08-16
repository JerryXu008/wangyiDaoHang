//
//  RefreshTableView.m
//  MicroVideo
//
//  Created by Hepburn Alex on 12-11-23.
//  Copyright (c) 2012年 wei. All rights reserved.
//

#import "RefreshTableView.h"

@implementation RefreshTableView

@synthesize delegate, mbMoreHidden, mbRefreshHidden, separatorColor, separatorStyle, miBotOffset, contentSize, contentOffset;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        miBotOffset = 0;
        mTableView = [[UITableView alloc] initWithFrame:self.bounds];
        mTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        mTableView.delegate = self;
        mTableView.dataSource = self;
        mTableView.backgroundColor = [UIColor colorWithRed:0.87 green:0.88 blue:0.91 alpha:1.0];
        [self addSubview:mTableView];
      //  [mTableView release];
        mTableView.frame=CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-8);
        mLoadMore = [[LoadMoreView alloc] initWithFrame:CGRectMake(10, 0, mTableView.frame.size.width-20, 32)];
        mLoadMore.delegate = self;
        mLoadMore.OnLoadMore = @selector(OnLoadMoreClick);
        mLoadMore.hidden = YES;
       // [mTableView addSubview:mLoadMore];
        mTableView.tableFooterView=mLoadMore;
      //  [mLoadMore release];
       // mLoadMore.backgroundColor=[UIColor redColor];
        
        mRefreshHeader = [[RefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, -mTableView.bounds.size.height, mTableView.frame.size.width, mTableView.bounds.size.height)];
        [mTableView addSubview:mRefreshHeader];
      //  [mRefreshHeader release];
    }
    return self;
}

- (void)setBackgroundColor:(UIColor *)color {
    [super setBackgroundColor:color];
    mTableView.backgroundColor = color;
}

- (void)setSeparatorColor:(UIColor *)color {
    mTableView.separatorColor = color;
}

- (UIColor *)separatorColor {
    return mTableView.separatorColor;
}

- (void)setSeparatorStyle:(UITableViewCellSeparatorStyle)style {
    mTableView.separatorStyle = style;
}

- (UITableViewCellSeparatorStyle)separatorStyle {
    return mTableView.separatorStyle;
}

- (CGSize)contentSize {
    return mTableView.contentSize;
}

- (CGPoint)contentOffset {
    return mTableView.contentOffset;
}

- (void)setContentOffset:(CGPoint)Offset {
    mTableView.contentOffset = Offset;
}

- (void)dealloc {
   // [super dealloc];
}

- (void)setMbMoreHidden:(BOOL)bHidden {
    mLoadMore.hidden = bHidden;
}

- (BOOL)mbMoreHidden {
    return mLoadMore.hidden;
}

- (void)setMbRefreshHidden:(BOOL)bHidden {
    mRefreshHeader.hidden = bHidden;
}

- (BOOL)mbRefreshHidden {
    return mRefreshHeader.hidden;
}

- (void)reloadData {
    [mTableView reloadData];
   // int iTop = mTableView.contentSize.height;
    //mLoadMore.frame = CGRectMake(10, iTop, mTableView.frame.size.width-20, 32);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (delegate && [delegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [delegate numberOfSectionsInTableView:tableView];
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (delegate && [delegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [delegate tableView:tableView numberOfRowsInSection:section];
    }
    return 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (delegate && [delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [delegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (delegate && [delegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [delegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (delegate && [delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (BOOL)CanRefresh {
    if (delegate && [delegate respondsToSelector:@selector(CanRefreshTableView:)]) {
        return [delegate CanRefreshTableView:self];
    }
    return NO;
}
//scrollView滚动时，就调用该方法。任何offset值改变都调用该方法。即滚动过程中，调用多次
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

	if (scrollView.isDragging) {//显示下拉更新
		if (mRefreshHeader.state == PullRefreshPulling && scrollView.contentOffset.y > -65.0f && scrollView.contentOffset.y < 0.0f && [self CanRefresh]) {
			[mRefreshHeader setState:PullRefreshNormal];
		}
		else if (mRefreshHeader.state == PullRefreshNormal && scrollView.contentOffset.y < -65.0f && [self CanRefresh]) {//显示松开更新
			[mRefreshHeader setState:PullRefreshPulling];
		}
	}
}
// 滑动视图，当手指离开屏幕那一霎那，调用该方法。一次有效滑动，只执行一次。
// decelerate,指代，当我们手指离开那一瞬后，视图是否还将继续向前滚动（一段距离），经过测试，decelerate=YES
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	if (scrollView.contentOffset.y <= - 65.0f && [self CanRefresh]) {
        [mRefreshHeader setState:PullRefreshLoading];
        
        //int iBotHeight = mLoadMore.hidden ? miBotOffset : miBotOffset+40;
        int iBotHeight = 0;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
       // mTableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, iBotHeight, 0.0f);
       //上边、左边、下边、右边
         mTableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, iBotHeight, 0.0f);
        mTableView.contentOffset = CGPointMake(0, -60);
        [UIView commitAnimations];
        if (delegate && [delegate respondsToSelector:@selector(ReloadList:)]) {
            return [delegate ReloadList:self];
        }
	}
}
// 滚动视图减速完成，滚动将停止时，调用该方法。一次有效滑动，只执行一次。
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int iOffset = scrollView.contentOffset.y+scrollView.frame.size.height-scrollView.contentSize.height;
    if (iOffset >= 30) {
       // [self OnLoadMoreClick];
    }
}

- (void)OnLoadMoreClick {
    if (!mLoadMore.hidden && [self CanRefresh]) {
        [mLoadMore StartLoading];
        if (delegate && [delegate respondsToSelector:@selector(LoadMoreList:)]) {
            return [delegate LoadMoreList:self];
        }
    }
}

- (void)FinishLoading {
   // int iBotHeight = mLoadMore.hidden ? miBotOffset : miBotOffset+40;
   int  iBotHeight=0;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:.3];
    [mTableView setContentInset:UIEdgeInsetsMake(0.0f, 0.0f, iBotHeight, 0.0f)];
    [UIView commitAnimations];
    
    [mRefreshHeader setState:PullRefreshNormal];
    [mRefreshHeader setCurrentDate];
    [mLoadMore StopLoading];
}

@end
