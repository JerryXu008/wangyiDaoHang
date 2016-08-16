//
//  BaseTableView.m
//  So Amusing
//
//  Created by ihope999 on 13-8-9.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import "BaseTableView.h"
#import "UIViewExt.h"

#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation BaseTableView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self _initUI];
    }
    return self;
}

- (void)awakeFromNib{

    [self _initUI];
    
}

# pragma mark -
# pragma mark - pravite Method
- (void)_initUI
{
    /*** EGO ***/
    _refreshHeaderView = [[EGORefreshTableHeaderViews alloc] initWithFrame:CGRectMake(0, 0 - self.bounds.size.height, self.bounds.size.width, self.bounds.size.height)];
    _refreshHeaderView.delegate = self;
    
    self.delegate = self;
    self.dataSource = self;
    self.refresher = YES;   //默认有［下拉刷新视图］
    
    /*** 加载更多button ***/
    _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
//    _moreButton.alpha = 0.5;
    _moreButton.backgroundColor = [UIColor clearColor];
    [_moreButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(loadMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicatorView.frame = CGRectMake(100, 10, 20, 20);
    indicatorView.tag = 2013;
    [indicatorView stopAnimating];
    [_moreButton addSubview:indicatorView];
    
    self.tableFooterView = _moreButton; //始终在tableView的尾部
   
}

//  是否添加［下拉刷新］功能
- (void) setRefresher:(BOOL)refresher
{
    _refresher = refresher;
    if (_refresher) {
        [self addSubview:_refreshHeaderView];
    }else {
        if ([_refreshHeaderView superview]) {
            [_refreshHeaderView removeFromSuperview];   //不添加［下拉刷新］视图
        }
    }
}

// ［加载更多］触发方法
- (void)_startLoadMore
{
    [_moreButton setTitle:@"正在加载..." forState:UIControlStateNormal];
    _moreButton.enabled = NO;
    UIActivityIndicatorView *indicationView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2013];
    [indicationView startAnimating];
    
}

//  加载完成后动画
- (void)_stopLoadMore
{

    if (self.dataArray.count >0) {
        _moreButton.hidden = NO;
        [_moreButton setTitle:@"上拉加载更多..." forState:UIControlStateNormal];
        _moreButton.enabled = YES;
        UIActivityIndicatorView *indicationView = (UIActivityIndicatorView *)[_moreButton viewWithTag:2013];
        [indicationView stopAnimating];
        
        if (!self.isMore) {
            [_moreButton setTitle:@"没有更多啦..." forState:UIControlStateNormal];
            _moreButton.enabled = NO;
            _moreButton.hidden = YES;
        }
    } else {
        _moreButton.hidden = YES;
    }
}

# pragma mark -
# pragma mark - Method
- (void)loadMoreAction:(UIButton *)button
{
    //代理中执行刷新方法
    if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
        [self.eventDelegate pullUp:self];
        [self _startLoadMore];   //加载更多 动画
    }
}

//外部执行－父类方法
- (void)reloadData
{
    [super reloadData];
    NSLog(@"reloadData");
    
    [self _stopLoadMore];
}

# pragma mark -
# pragma mark - tableView Datasource
//- (NSInteger)numberOfRowsInSection:(NSInteger)section
//{
//    return [self.dataArray count];
//}

- (NSInteger )tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] ;
    
    return cell;
}

# pragma mark - 下拉刷新 相关
# pragma mark - Data Source Loading/Reloading Method
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}

//在外部完成
- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self];
}

- (void)autoRefreshData
{
    [_refreshHeaderView initLoading:self];
}

# pragma mark -
# pragma mark - ScrollView Delegate
//手指滑动时调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

//手指停止拖拽时调用
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if (_refresher) {
        [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
    }
    
    if (!_isMore) {
        return;
    }
    
    /*** 上拉刷新 ***/
    float sub = scrollView.contentSize.height - scrollView.contentOffset.y;
    if (scrollView.height - sub > 30) {
        
        /*** 按钮显示下拉刷新效果，并且执行更新的代理方法，把自己传进度，更新自己，执行reloadData ***/
        [self _startLoadMore];
        
        if ([self.eventDelegate respondsToSelector:@selector(pullUp:)]) {
            [self.eventDelegate pullUp:self];
        }
    }
}

# pragma mark -
# pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.eventDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.eventDelegate tableView:self didSelectRowAtIndexPath:indexPath];
    }
}

# pragma mark -
# pragma mark - EGOrefresh Delegate
//下拉到一定距离，手指放开时
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderViews*)view
{
    /*** 设置下拉状态 ***/
    [self reloadTableViewDataSource];
    
  id i=  _eventDelegate;
    /*** 执行［下拉刷新］功能 ***/
    if ([self.eventDelegate respondsToSelector:@selector(pullDown:)]) {
        [self.eventDelegate pullDown:self];
    }
//    //3秒后停止［下拉刷新］动作
//    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:3];
    
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderViews*)view
{
    /*** 上面那个代理走完，就走这个 ***/
    return _reloading;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderViews*)view
{
    return [NSDate date];
}



@end
