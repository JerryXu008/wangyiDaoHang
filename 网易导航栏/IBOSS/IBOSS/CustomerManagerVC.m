//
//  CustomerManagerVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerManagerVC.h"
#import "CustomerManagerCell.h"
#import "CustomerReportCreateVC.h"
#import "CustomerSearchVC.h"
typedef enum {
    DataSearchStateBank = 0,
} DataSearchState;


@interface CustomerManagerVC ()
@property(nonatomic,strong) NSArray * ItemArr;
@property(nonatomic,strong) NSMutableArray * reportArr;
@property (nonatomic,strong)NSMutableArray *dataHold;
@property(nonatomic,strong) NSDictionary * reportOneDic;
@property (nonatomic,assign)DataSearchState searchState;
@property(strong)UIBarButtonItem *menuButton;
@property(strong) SNPopupView  *popup;
@property(strong) UIView * dropView;
@property(strong) UIView *searchBG;
@end

@implementation CustomerManagerVC
@synthesize searchBar=_searchBar;
@synthesize dataHold=_dataHold;
@synthesize popup,menuButton,dropView,searchBG;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.reportArr=[[NSMutableArray alloc] init];
    }
    return self;
}
-(void)reloadData
{
    self.reportOneDic=@{@"客户名称": @"Bruce",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    [_dataHold addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"Bom",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    [_dataHold addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"Marry",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    [_dataHold addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"Jet",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    [_dataHold addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"Bob",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    [_dataHold addObject:_reportOneDic];
    
  //  NSLog(@"self.reportcount=%d",self.reportArr.count);
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    if(popup!=nil)
    {
        [popup dismiss:NO];
        popup = nil;
        [searchBG removeFromSuperview];
        searchBG=nil;
    }
}
-(void)initDropMenu
{
    dropView=[[UIView alloc]init];
    dropView.frame=CGRectMake(0, 0, 150, 101);
   // dropView.backgroundColor=[UIColor redColor];
    //搜索按钮
    UIView *searchView=[[UIView alloc] init];
    searchView.frame=CGRectMake(0, 0, 150, 50) ;
    [dropView addSubview:searchView];
    UIImageView *searchIcon=[[UIImageView alloc]init];
    searchIcon.frame=CGRectMake(20, 16.5, 17, 17);
    searchIcon.image=[UIImage imageNamed:@"sousuo_icon.png"];
    [searchView addSubview:searchIcon];
    UIButton *searchbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [searchbtn setTitle:@"搜    索" forState:UIControlStateNormal];
    [searchbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    searchbtn.frame=CGRectMake(40, 16.5, 110, 17);
    [searchbtn addTarget:self action:@selector(Gosearch) forControlEvents:UIControlEventTouchUpInside];
    [searchView addSubview:searchbtn];
    
    
    //新增报备
    UIView *addReportView=[[UIView alloc]init];
    addReportView.frame=CGRectMake(0, 51, 150, 50);
    [dropView addSubview:addReportView];
    UIImageView *reportIcon=[[UIImageView alloc]init];
    reportIcon.frame=CGRectMake(20, 16.5, 17, 17);
    reportIcon.image=[UIImage imageNamed:@"xinzengbaobiao_icon.png"];
    [addReportView addSubview:reportIcon];
    UIButton *reportbtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [reportbtn setTitle:@"新增报备" forState:UIControlStateNormal];
    [reportbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    reportbtn.frame=CGRectMake(40, 16.5, 110, 17);
    [reportbtn addTarget:self action:@selector(createReport) forControlEvents:UIControlEventTouchUpInside];
   
    [addReportView addSubview:reportbtn];
    
    //分割线
    UIImageView* fenView=[[UIImageView alloc] init];
    fenView.frame=CGRectMake(0, 50, 150, 1);
    fenView.image=[UIImage imageNamed:@"fengexian.png"];
    [dropView addSubview:fenView];
    

}
-(void)createReport
{
    self.hidesBottomBarWhenPushed=YES;
    CustomerReportCreateVC *detailVC=[[CustomerReportCreateVC alloc] initWithNibName:@"CustomerReportCreateView" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
-(void)Gosearch
{
    self.hidesBottomBarWhenPushed=YES;
  CustomerSearchVC *detailVC=[[CustomerSearchVC alloc] initWithNibName:@"CustomerSearchView" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}


-(void)createFunction:(id)sender
{
    
   // UIBarButtonItem *menuButton
    if(popup==nil){
        searchBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,self.tbView.frame.size.height)];
        [searchBG setBackgroundColor:[UIColor blackColor]];
        [searchBG setAlpha:0.3f];
        [self.tbView addSubview:searchBG];
        [self.tbView bringSubviewToFront:searchBG];
        
        
    //popup = [[SNPopupView alloc] initWithString:@"test message" withFontOfSize:29];
    //[popup showFromBarButtonItem:menuButton inView:self.view animated:NO];
    popup = [[SNPopupView alloc] initWithContentView:dropView contentSize:CGSizeMake(dropView.frame.size.width,dropView.frame.size.height)];
    [popup setDelegate:self];
    [popup showFromBarButtonItem:menuButton inView:self.view animated:NO];
        /* self.hidesBottomBarWhenPushed=YES;
    CustomerReportCreateVC *detailVC=[[CustomerReportCreateVC alloc] initWithNibName:@"CustomerReportCreateView" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;*/
    }
    else {
		[popup dismiss:NO];
		 popup = nil;
        [searchBG removeFromSuperview];
        searchBG=nil;
	}

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
  //  self.edgesForExtendedLayout = UIRectEdgeNone;
  //  self.extendedLayoutIncludesOpaqueBars = NO;
  //  self.modalPresentationCapturesStatusBarAppearance = NO;
    
    [self initDropMenu];
    
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"客户";
    _dataHold=[[NSMutableArray alloc]init] ;
    //添加 添加按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
   // [button setBackgroundImage:[UIImage imageNamed:@"jia.png"]
    //                  forState:UIControlStateNormal];
    [button setTitle:@"功能" forState:UIControlStateNormal];
    [button setTitleColor:NavBarItemColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(createFunction:)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 50, 30);
    //button.backgroundColor=[UIColor redColor];
    menuButton = [[UIBarButtonItem alloc] initWithCustomView: button];
    self.navigationItem.rightBarButtonItem = menuButton;
   
    _searchBar.delegate=self;
    
    
    self.ItemArr=[[NSArray alloc] initWithObjects:@"客户报备",@"客户跟进", nil];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    
   // self.navigationController.navigationBar.hidden=YES;
   // self.tbView.hidden=YES;
    self.tbView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self reloadData];
}
-(void)CancelSearch
{
 [_searchBar resignFirstResponder];
    [self RemoveLeftCancel];
}
-(void) RemoveLeftCancel
{
    self.navigationItem.leftBarButtonItem = nil;
}
-(void)AddLeftCancel
{
    //添加取消按钮
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    // button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(CancelSearch)
      forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0, 0, 40, 24);
    //button2.titleLabel.text=@"跟进";
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    UIBarButtonItem *menuButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem = menuButton2;
}
#pragma mark search bar delegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    [self AddLeftCancel];
    return YES;
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    NSLog(@"%@",searchText);
    if ([searchText isEqualToString:@""]) {
        self.reportArr = _dataHold;
        [_tbView reloadData];
        return;
    }
    
    NSString *keyName = @"";
    if (_searchState == DataSearchStateBank) {
        keyName = @"客户名称";
    }
    /**< 模糊查找*/
    NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K contains[cd] %@", keyName, searchText];
    /**< 精确查找*/
    //  NSPredicate *predicateString = [NSPredicate predicateWithFormat:@"%K == %@", keyName, searchText];
    
    NSLog(@"predicate %@",predicateString);
    
    NSMutableArray  *filteredArray = [NSMutableArray arrayWithArray:[_dataHold filteredArrayUsingPredicate:predicateString]];
    
    self.reportArr = filteredArray;
    [_tbView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [self CancelSearch];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_searchBar resignFirstResponder];
     [self CancelSearch];
}








- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.reportArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CustomerManagerCell";
    
    
    CustomerManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"CustomerManagerCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    int rowIndex=indexPath.row;
    NSDictionary *dic=[self.reportArr objectAtIndex:rowIndex];
    [cell setDicInfo:dic];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==0)
    {
        
      
            self.hidesBottomBarWhenPushed=YES;
            CustomerReportDetailVC *detailVC=[[CustomerReportDetailVC alloc] initWithNibName:@"CustomerReportDetailView" bundle:nil];
            [self.navigationController pushViewController:detailVC animated:YES];
             self.hidesBottomBarWhenPushed=NO;
        
    }
    
    
}

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if(indexPath.section==0)
    {
     if(indexPath.row==0)
     {
          self.hidesBottomBarWhenPushed=YES;
         CustomerReportVC * reportVC=[[CustomerReportVC alloc] initWithNibName:@"CustomerReportView" bundle:nil];
         [self.navigationController pushViewController:reportVC animated:YES];
          self.hidesBottomBarWhenPushed=NO;
     }
     else if(indexPath.row==1){
         self.hidesBottomBarWhenPushed=YES;
         CustomerFollowUpVC *followupVC=[[CustomerFollowUpVC alloc] initWithNibName:@"CustomerFollowUpView" bundle:nil];
         [self.navigationController pushViewController:followupVC animated:YES];
           self.hidesBottomBarWhenPushed=NO;
     }
    }
    
    
}*/
// 该delegate是可选的，对那些可以被编辑的对象返回YES
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
// 对特定编辑风格进行操作
- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //以下是apple的缺省实例
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // 如果是要删除那行栏格，那么就去删除数据源中的对象
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // 如果是要添加栏格，那么就应该将要添加的内容添加到数据源中
    }
}
// 可选delegate，对那些被移动栏格作特定操作
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath
      toIndexPath:(NSIndexPath *)toIndexPath {
}
// 对那些可以移动的行返回YES
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // 如果不像让栏格移动，就返回NO
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
