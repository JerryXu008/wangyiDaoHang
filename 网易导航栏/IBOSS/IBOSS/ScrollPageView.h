//
//  ScrollPageView.h
//  ShowProduct
//
//  Created by Bruce on 14-5-23.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "CustomTableView.h"
#import "RefreshTableView.h"
#import "BaseADView.h"
@protocol ScrollPageViewDelegate <NSObject>
-(void)didScrollPageViewChangedPage:(NSInteger)aPage;
@end

@interface ScrollPageView :BaseADView<UIScrollViewDelegate,UITableViewDataSource, UITableViewDelegate,RefreshTableViewDelegate>
{
    NSInteger mCurrentPage;
    BOOL mNeedUseDelegate;
}
@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain) NSMutableArray *contentItems;

@property (nonatomic,assign) id<ScrollPageViewDelegate> delegate;

#pragma mark 添加ScrollowViewd的ContentView
-(void)setContentOfTables:(NSInteger)aNumerOfTables;
#pragma mark 滑动到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex;
#pragma mark 刷新某个页面
-(void)freshContentTableAtIndex:(NSInteger)aIndex;
#pragma mark 改变TableView上面滚动栏的内容
//-(void)changeHeaderContentWithCustomTable:(CustomTableView *)aTableContent;
/*-(void)changeHeaderContentWithCustomTable:(RefreshTableView *)aTableContent;*/
@end
