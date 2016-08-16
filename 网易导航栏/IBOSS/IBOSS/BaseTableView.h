//
//  BaseTableView.h
//  So Amusing
//
//  Created by ihope999 on 13-8-9.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderViews.h"

@class BaseTableView;
@protocol UItableViewEventDelegate <NSObject>

- (void)pullDown:(BaseTableView *)tableView;    //下拉刷新
- (void)pullUp:(BaseTableView *)tableView;    //上拉刷新
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;    //选中


@end

@interface BaseTableView : UITableView<UITableViewDataSource,UITableViewDelegate,EGORefreshTableHeaderDelegate>
{
    EGORefreshTableHeaderViews *_refreshHeaderView;
    BOOL _reloading;
    
//    UIButton *_moreButton;  //加载更多按钮
}

@property (nonatomic, retain) UIButton *moreButton;                 //加载更多按钮
@property (nonatomic, assign) BOOL refresher;                       //是否－需要下拉刷新
@property (nonatomic, retain) NSMutableArray *dataArray;            //tableView的数据
@property (nonatomic, assign) id<UItableViewEventDelegate>eventDelegate;          //代理
@property (nonatomic, assign) BOOL isMore;                          //是否－还有更多 下一页

    //加载数据
- (void)doneLoadingTableViewData;

    //自动下拉刷新
- (void)autoRefreshData;


@end
