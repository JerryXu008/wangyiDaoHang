//
//  ScrollPageView.m
//  ShowProduct
//
//  Created by Bruce on 14-5-23.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import "ScrollPageView.h"

#import "AdvertTableCell.h"
#import "TouchView.h"
#import "NewsInfo.h"
#import "NSString+SBJSON.h"
#import "NewsTableCell.h"
@interface ScrollPageView(){
    int miPage;
    int miIndex;
}
@property (nonatomic, strong) ImageDownManager *mDownManager;
@property (nonatomic, strong) NSMutableArray *mArray;
@property (nonatomic, strong) NSMutableArray *mArray2;
@end
@implementation ScrollPageView
@synthesize mDownManager;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        mNeedUseDelegate = YES;
        [self commInit];
        miIndex = 0;
        self.mArray = [[NSMutableArray alloc] initWithCapacity:10];
        self.mArray2 = [[NSMutableArray alloc] initWithCapacity:10];

    }
    return self;
}

-(void)initData{
    [self freshContentTableAtIndex:0];
}


-(void)commInit{
    if (_contentItems == nil) {
        _contentItems = [[NSMutableArray alloc] init];
    }
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
     
        _scrollView.pagingEnabled = YES;
        _scrollView.delegate = self;
        _scrollView.backgroundColor=[UIColor whiteColor];
    }
    [self addSubview:_scrollView];
}


#pragma mark - 其他辅助功能
#pragma mark 添加ScrollowViewd的ContentView
-(void)setContentOfTables:(NSInteger)aNumerOfTables{
    for (int i = 0; i < aNumerOfTables; i++) {
       /* CustomTableView *vCustomTableView = [[CustomTableView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, self.frame.size.height)];
        vCustomTableView.delegate = self;
        vCustomTableView.dataSource = self;
        */
        //为table添加嵌套HeadderView
       // [self addLoopScrollowView:vCustomTableView];
      //  RefreshTableView *vCustomTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, self.frame.size.height)];
       RefreshTableView *vCustomTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(320 * i, 0, 320, self.frame.size.height)];
        vCustomTableView.backgroundColor=[UIColor redColor];
        vCustomTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        vCustomTableView.backgroundColor = [UIColor whiteColor];
        vCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        vCustomTableView.delegate = self;
       // vCustomTableView.dataSource = self;
        
        
        [_scrollView addSubview:vCustomTableView];
       // _scrollView.contentSize=CGSizeMake(320, 1000);
        [_contentItems addObject:vCustomTableView];
        
       // [vCustomTableView release];
    }
    [_scrollView setContentSize:CGSizeMake(320 * aNumerOfTables, self.frame.size.height)];
}

#pragma mark 移动ScrollView到某个页面
//点击上面选项卡调用这个方法
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex{
    mNeedUseDelegate = NO;
    //CGRect vMoveRect = CGRectMake(self.frame.size.width * aIndex, 0, self.frame.size.width, self.frame.size.width);
     CGRect vMoveRect = CGRectMake(self.frame.size.width * aIndex, 0, self.frame.size.width, self.frame.size.height);
    [_scrollView scrollRectToVisible:vMoveRect animated:YES];
    mCurrentPage= aIndex;
    if ([_delegate respondsToSelector:@selector(didScrollPageViewChangedPage:)]) {
        //上面的选项卡滚动到指定位置
        [_delegate didScrollPageViewChangedPage:mCurrentPage];
    }
}

#pragma mark 刷新某个页面
//==============================强制刷新某个页面
-(void)freshContentTableAtIndex:(NSInteger)aIndex{
    if (_contentItems.count < aIndex) {
        return;
    }
    /*CustomTableView *vTableContentView =(CustomTableView *)[_contentItems objectAtIndex:aIndex];
    [vTableContentView forceToFreshData];*/
   /* RefreshTableView *vTableContentView =( RefreshTableView *)[_contentItems objectAtIndex:aIndex];
    [vTableContentView FinishLoading];
    [vTableContentView reloadData];*/
    [_mArray removeAllObjects];
    miPage=0;
   
    [self LoadNewsList];
    
}


#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return _mArray.count;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 160;
    }
    return 74;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *CellIdentifier = @"ImageScrollCell";
        AdvertTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[AdvertTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.delegate = self;
            cell.OnAdvertSelect = @selector(OnAdvertSelect:);
        }
        [cell LoadNewsPics:miIndex];
        //[cell reloadData:self.mArray2];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"NewsCell";
        NewsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[NewsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.selectionStyle = UITableViewCellSelectionStyleGray;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.backgroundColor = [UIColor whiteColor];
        //        if (indexPath.row%2 == 0) {
        //            cell.backgroundColor = [UIColor whiteColor];
        //        }
        //        else {
        //            cell.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];
        //        }
        if(_mArray.count>0){
        NewsInfo *info = [_mArray objectAtIndex:indexPath.row];
            [cell LoadNewsInfo:info];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        //不做处理
    }
    else{
        /*NewsInfo *info = [_mArray objectAtIndex:indexPath.row];
        NewsDetailViewController *ctrl = [[NewsDetailViewController alloc] init];
        ctrl.hidesBottomBarWhenPushed = YES;
        ctrl.mInfo = info;
        [self.navigationController pushViewController:ctrl animated:YES];
       */
         }
}







#pragma mark - ImageDownManager

- (void)Cancel {
    [self StopLoading];

    SAFE_CANCEL_ARC(self.mDownManager);
}

- (void)LoadNewsList {
    if (mDownManager) {
        return;
    }
    [self StartLoading];
    self.mDownManager = [[ImageDownManager alloc] init];
    mDownManager.delegate = self;
    mDownManager.OnImageDown = @selector(OnLoadFinish:);
    mDownManager.OnImageFail = @selector(OnLoadFail:);
    
    // NSArray *array = @[@"news", @"hot", @"say"];
    NSArray *array = @[@"news", @"say"];
    NSString *urlstr = [NSString stringWithFormat:@"http://www.hebradio.com/app/%@/", array[miIndex]];
    if (miPage == 0) {
        urlstr = [urlstr stringByAppendingString:@"index.json"];
    }
    else {
        urlstr = [urlstr stringByAppendingFormat:@"index_%d.json", miPage+1];
    }
    [mDownManager GetImageByStr:urlstr];
   // NSLog(@"LoadNewsList:%@", urlstr);
}

- (void)OnLoadFinish:(ImageDownManager *)sender {
    NSString *newstr = [self GetFormatContent:sender.mWebStr];
    NSDictionary *dict = [newstr JSONValue];
    [self Cancel];
    int iNewCount = 0;
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSLog(@"%@", dict);
        if (miPage == 0) {
            [_mArray removeAllObjects];
        }
        NSArray *array = [dict objectForKey:@"news"];
        if (array && [array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *tmpdict in array) {
                NewsInfo *info = [NewsInfo CreateWithDict:tmpdict];
                if (info && info.m_url) {
                    [_mArray addObject:info];
                }
            }
            iNewCount = array.count;
        }
        miPage ++;
    }
    RefreshTableView *vTableContentView =( RefreshTableView *)[_contentItems objectAtIndex:mCurrentPage];
    [vTableContentView FinishLoading];
    [vTableContentView reloadData];
    vTableContentView.mbMoreHidden = (iNewCount == 0);
   
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
    RefreshTableView *vTableContentView =( RefreshTableView *)[_contentItems objectAtIndex:mCurrentPage];
    [vTableContentView FinishLoading];

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

#pragma mark - RefreshTableView

- (void)LoadMoreList:(RefreshTableView *)sender {
    [self LoadNewsList];
}

- (void)ReloadList:(RefreshTableView *)sender{
    miPage = 0;
    [self LoadNewsList];
}

- (BOOL)CanRefreshTableView:(RefreshTableView *)sender {
    return !mDownManager;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    mNeedUseDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (_scrollView.contentOffset.x+320/2.0) / 320;
    if (mCurrentPage == page) {
        return;
    }
    mCurrentPage= page;
    if ([_delegate respondsToSelector:@selector(didScrollPageViewChangedPage:)] && mNeedUseDelegate) {
        [_delegate didScrollPageViewChangedPage:mCurrentPage];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate)
    {
        
    }
    
    
}






//点击标题图片执行的事情
- (void)OnAdvertSelect:(TouchView *)sender
{
   
}
-(void)dealloc{
    [_contentItems removeAllObjects],_contentItems= nil;
   
    
}


@end
