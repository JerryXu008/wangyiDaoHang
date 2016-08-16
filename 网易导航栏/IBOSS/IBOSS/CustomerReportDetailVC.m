//
//  CustomerReportDetailVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerReportDetailVC.h"
#import "CustomerFollowUpVC.h"

#import "FollowUpCell.h"
#import "FollowUpInfoModel.h"
#define padding_slide_menu_left  0
#define padding_slide_menu_rigth 60
@interface CustomerReportDetailVC ()

@property(nonatomic,strong) NSMutableArray * headMenuArray;

@property(nonatomic,strong) UIButton *btnBasicInfo;
@property(nonatomic,strong) UIButton *btnfollowUp;
@property(nonatomic,strong) UIImageView *redLineView;
@property(nonatomic,strong) NSDictionary *ReportDic;

@property(nonatomic,strong) IBOutlet UILabel *lblCustomerChannel;
@property(nonatomic,strong) IBOutlet UILabel *lblCustomerProperty;
@property(nonatomic,strong) IBOutlet UILabel *lblMessager;
@property(nonatomic,strong) IBOutlet UILabel *lblDepartment;
@property(nonatomic,strong) IBOutlet UILabel *lblMidCustomer;
@property(nonatomic,strong) IBOutlet UILabel *lblRoomArea;
@property(nonatomic,strong) IBOutlet UILabel *lblProgress;
@property(nonatomic,strong) IBOutlet UILabel *lblAddress;
@property(nonatomic,strong) IBOutlet UILabel *lblNote;
@property(nonatomic,strong) IBOutlet UILabel *lblCustomerName;
@property(nonatomic,strong) IBOutlet UILabel *lblMesPhone;
@property(nonatomic,strong) IBOutlet UILabel *lblMesMobilePhone;
@property(nonatomic,strong) IBOutlet UILabel *lblSaleMan;
@property(nonatomic,strong) IBOutlet UILabel *lblMidEmployee;
@property(nonatomic,strong) IBOutlet UILabel *lblHouseType;

@property(nonatomic,assign) int friendPage;
@end

@implementation CustomerReportDetailVC
@synthesize ReportIndex=_ReportIndex;
@synthesize scrollView=_scrollView;
@synthesize redLineView,friendPage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        friendPage = 1;
        // Custom initialization
        self.ReportDic=@{@"客户渠道":@"小区",@"客户名称":@"黄仙林",
                         @"客户性质":@"个人客户",@"联系电话":@"010-7882274",
                         @"联系人":@"沈海燕",@"联系方式":@"13298892394",
                         @"业务部门":@"小区部",@"业务员":@"琴颈",
                         @"中间客户":@"艺匠装饰",@"员工":@"赵本山",
                         @"室内面积":@"123m",@"户型":@"三室两厅",
                         @"装修进度":@"打地面",@"地址":@"北京市朝阳区雅宝路12号华声国际大厦",
                         @"备注":@"成交意向强烈"};
    }
    return self;
}
-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadLabelStyle
{
    [_lblCustomerChannel setTextColor:[UIColor grayColor]];
     [_lblCustomerProperty setTextColor:[UIColor grayColor]];
    [_lblMessager setTextColor:[UIColor grayColor]];
    [_lblDepartment setTextColor:[UIColor grayColor]];
    [_lblMidCustomer setTextColor:[UIColor grayColor]];
    [_lblRoomArea setTextColor:[UIColor grayColor]];
    [_lblProgress setTextColor:[UIColor grayColor]];
    [_lblAddress setTextColor:[UIColor grayColor]];
    [_lblNote setTextColor:[UIColor redColor]];
    [_lblCustomerName setTextColor:[UIColor grayColor]];
    [_lblMesPhone setTextColor:[UIColor grayColor]];
    [_lblMesMobilePhone setTextColor:[UIColor grayColor]];
    [_lblSaleMan setTextColor:[UIColor grayColor]];
    [_lblMidEmployee setTextColor:[UIColor grayColor]];
    [_lblHouseType setTextColor:[UIColor grayColor]];

}
-(void)loadNavStyle
{
 //右边
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
   // button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(FollowUp:)
     forControlEvents:UIControlEventTouchUpInside];
     button2.frame = CGRectMake(0, 0, 40, 24);
    //button2.titleLabel.text=@"跟进";
    [button2 setTitleColor:NavBarItemColor forState:UIControlStateNormal];
    [button2 setTitle:@"跟进" forState:UIControlStateNormal];
    UIBarButtonItem *menuButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = menuButton2;

 //返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
}
//加载选择标题
-(void)loadSubTitles{
    //根据ID找到下级菜单 展示到二级菜单上
   /* self.headMenuArray = [[NSMutableArray alloc]initWithObjects:@"基本信息",@"跟进情况", nil] ;
    
    // 添加slide menu view
    self.slideMenu = [self loadSlideMenuWithTitles:_headMenuArray];
    [self.slideMenu loadSubView];
    [self.slideMenu changeNoniusToIndex:0 performDelegate:NO];        // 默认选中第一个
   // [self.navigationItem setTitleView:_slideMenu];
    [self.subTitleView addSubview:_slideMenu];
    self.subTitleView.backgroundColor=[UIColor yellowColor];
 */
   
    
    UIImageView *imageview=[[UIImageView alloc] init];
    imageview.userInteractionEnabled=YES;
    imageview.image=[UIImage imageNamed:@"erjidaohang_bj.png"];
    imageview.frame=CGRectMake(0, 0, self.subTitleView.frame.size.width, self.subTitleView.frame.size.height);
    [self.subTitleView addSubview:imageview];
    //添加自定义按钮
    _btnBasicInfo = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnBasicInfo.frame = CGRectMake(40, 0, Screen_Width/2-40-40, 40);
    //[_btnBasicInfo setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
    /*UIImage *img = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"bgd_img_slide_menu_btn" ofType:@"png"]];
    [img stretchableImageWithLeftCapWidth:img.size.width/2 topCapHeight:img.size.height/2];
    [_btnBasicInfo setBackgroundImage:img forState:UIControlStateSelected];
*/
    [_btnBasicInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //[_btnBasicInfo setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    [_btnBasicInfo setTitle:@"基本信息" forState:UIControlStateNormal];
   // [_btnBasicInfo setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnBasicInfo addTarget:self action:@selector(showBasicInfo:) forControlEvents:UIControlEventTouchUpInside];
    _btnBasicInfo.titleLabel.font = [UIFont systemFontOfSize:15];
    [imageview addSubview:_btnBasicInfo];
    _btnfollowUp = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnfollowUp.frame = CGRectMake(Screen_Width/2+40, 0, Screen_Width/2-40-40, 40);
   //  [_btnfollowUp setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
    
    [_btnfollowUp setTitle:@"跟进情况" forState:UIControlStateNormal];
  //  [_btnfollowUp setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnfollowUp addTarget:self action:@selector(showFollowUp:) forControlEvents:UIControlEventTouchUpInside];
    _btnfollowUp.titleLabel.font = [UIFont systemFontOfSize:15];
   
    [_btnfollowUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
   // [_btnfollowUp setTitleColor:[UIColor redColor] forState:UIControlStateSelected];

    [imageview addSubview:_btnfollowUp];
   
    redLineView=[[UIImageView alloc] init];
    redLineView.frame=CGRectMake(30, self.subTitleView.frame.size.height-2, 100, 2);
   // redLineView.frame=CGRectMake(Screen_Width/2+30, self.subTitleView.frame.size.height-2, 100, 2);
    redLineView.backgroundColor=NavBarItemColor;
    [self.subTitleView addSubview:redLineView];
    
    [self showBasicInfo:nil];
    
}
-(void)LoadScrollView
{
    _scrollView.contentSize=CGSizeMake(320, 500);
   // _scrollView.backgroundColor=[UIColor redColor];
    //[_scrollView superview].backgroundColor=[UIColor greenColor];
}
-(void)showBasicInfo:(id)sender
{
   // UIButton *btn=(UIButton *)sender;
    _btnfollowUp.selected=NO;
    //[_btnBasicInfo setTitleColor:[UIColor colorWithRed:0.0f green:151.0f/255.0f blue:219.0f/255.0f alpha:1.0] forState:UIControlStateNormal];
    [_btnBasicInfo setTitleColor:NavBarItemColor forState:UIControlStateNormal];
    [_btnfollowUp setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _tbView.hidden=YES;
    _baseInfoView.hidden=NO;
    redLineView.frame=CGRectMake(30, self.subTitleView.frame.size.height-2, 100, 2);

}
-(void) showFollowUp:(id)sender
{
    _btnBasicInfo.selected=NO;
     [_btnfollowUp setTitleColor:NavBarItemColor  forState:UIControlStateNormal];
     [_btnBasicInfo setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _tbView.hidden=NO;
    _baseInfoView.hidden=YES;
    redLineView.frame=CGRectMake(Screen_Width/2+30, self.subTitleView.frame.size.height-2, 100, 2);
}

-(void)LoadTableView
{
    //int heightTop = IOS_VERSION_CODE >= 7?64:0;
   // CGRect frame=_baseInfoView.frame;
   
  //  self.tbView = [[CustomerReportTableView alloc] initWithFrame:CGRectMake(frame.origin.x,frame.origin.y, frame.size.width,frame.size.height)];
   // self.tbView.hidden=YES;
   // [self.view addSubview:_tbView];
   // CGRect frame=_tbView.frame;
   // frame=CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, 100);
  //  _tbView.frame=frame;
    _tbView.eventDelegate = self;
    _tbView.isMore = YES;
    if(IOS_7)
    {
    CGRect frame=_tbView.frame;
    frame=CGRectMake(frame.origin.x, frame.origin.y+64, _tbView.frame.size.width, _tbView.frame.size.height-64);
   // _tbView.userModel = _userModel;
    _tbView.frame=frame;
        }
    _tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
     [_tbView autoRefreshData];
   // _tbView.backgroundColor=[UIColor greenColor];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self LoadTableView];
    [self loadNavStyle];
    [self loadSubTitles];
    [self LoadScrollView];
    [self loadLabelStyle];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"天华";
    self.lblCustomerChannel.text=[self.ReportDic objectForKey:@"客户渠道"];
    self.lblCustomerProperty.text=[self.ReportDic objectForKey:@"客户性质"];
    self.lblMessager.text=[self.ReportDic objectForKey:@"联系人"];
    self.lblDepartment.text=[self.ReportDic objectForKey:@"业务部门"];
    self.lblMidCustomer.text=[self.ReportDic objectForKey:@"中间客户"];
    self.lblRoomArea.text=[self.ReportDic objectForKey:@"室内面积"];;
    self.lblProgress.text=[self.ReportDic objectForKey:@"装修进度"];;
    self.lblAddress.text=[self.ReportDic objectForKey:@"地址"];;
    self.lblNote.text=[self.ReportDic objectForKey:@"备注"];;
    self.lblCustomerName.text=[self.ReportDic objectForKey:@"客户名称"];
    self.lblMesPhone.text=[self.ReportDic objectForKey:@"联系电话"];
    self.lblMesMobilePhone.text=[self.ReportDic objectForKey:@"联系方式"];
    self.lblSaleMan.text=[self.ReportDic objectForKey:@"业务员"];
    self.lblMidEmployee.text=[self.ReportDic objectForKey:@"员工"];;
    self.lblHouseType.text=[self.ReportDic objectForKey:@"户型"];
   // self.baseInfoView.hidden=YES;
   // self.tbView.hidden=NO;
   // self.subTitleView.hidden=YES;
    self.FollowUpArr=[[NSMutableArray alloc] init];
    [self reloadData];
   
    //[_tbView autoRefreshData];
    [self pullDownData];
    
   
    NSLog(@"tbview.frame.x=%f,y=%f,width=%f,height=%f",_tbView.frame.origin.x,
          _tbView.frame.origin.y,_tbView.frame.size.width,_tbView.frame.size.height-64-39);
    
    
    
    
}
-(void)reloadData
{
    FollowUpInfoModel *model=[FollowUpInfoModel new];
    model.title=@"现在正在紧张施工，预计工期是2个月，地砖马上就要铺设，就在这几天进行订货现在正在紧张施工，预计工期是2，就在这几天进行订货预计工期是2个月，地砖马马上就要铺设，就在这几天进行订货";
    model.imgView=[UIImage imageNamed:@"tu1.png"];
    model.fileRecordName=@"";
    model.address=@"东北旺路";
    model.time=@"05-23 13:20";
    [self.FollowUpArr addObject:model];
    model=[FollowUpInfoModel new];
    model.title=@"已经和甲方谈好了，明日选颜色和尺寸，面积已经确定，具体数量也已经计算出来了，选好颜色和尺寸就可以下单了";
    model.imgView=[UIImage imageNamed:@"tu2.png"];
    model.fileRecordName=@"";
    model.address=@"城铁西二旗";
    model.time=@"05-25 18:20";
    [self.FollowUpArr addObject:model];
    model=[FollowUpInfoModel new];
    model.title=@"现在正在紧张施工，预计工期是2个月，地砖马上就要铺设，就在这几天进行订货";
    model.imgView=[UIImage imageNamed:@"tu1.png"];
    model.fileRecordName=@"";
    model.address=@"东北旺路";
    model.time=@"05-23 13:20";
   [self.FollowUpArr addObject:model];
    model=[FollowUpInfoModel new];
    model.title=@"已经和甲方谈好了，明日选颜色和尺寸，面积已经确定，具体数量也已经计算出来了，选好颜色和尺寸就可以下单了";
    model.imgView=[UIImage imageNamed:@"tu2.png"];
    model.fileRecordName=@"";
    model.address=@"城铁西二旗";
    model.time=@"05-25 18:20";
    [self.FollowUpArr addObject:model];
    
    self.FollowUpArr=[self sortByTime:self.FollowUpArr];

}
-(NSMutableArray *)sortByTime:(NSMutableArray *)myArray
{
    NSSortDescriptor*sorter=[[NSSortDescriptor alloc]initWithKey:@"time" ascending:NO];
    NSMutableArray *sortDescriptors=[[NSMutableArray alloc]initWithObjects:&sorter count:1];
    NSArray *sortArray=[myArray sortedArrayUsingDescriptors:sortDescriptors];
    return [[NSMutableArray alloc] initWithArray:sortArray];
}


-(void)viewWillAppear:(BOOL)animated
{
     self.FollowUpArr=[self sortByTime:self.FollowUpArr];
    [_tbView reloadData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}
-(IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)FollowUp:(id)sender
{
    self.hidesBottomBarWhenPushed=YES;
    CustomerFollowUpVC *followupVC=[[CustomerFollowUpVC alloc] initWithNibName:@"CustomerFollowUpView" bundle:nil];
    followupVC.parentVC=self;
    [self.navigationController pushViewController:followupVC animated:YES];
    
}
# pragma mark -
# pragma mark - tableView EventDelegate
- (void)pullDown:(BaseTableView *)tableView{
    
    [self pullDownData];
    
}//下拉刷新

- (void)pullUp:(BaseTableView *)tableView{
    
    
    
        [self pullUpData];
    
    
}//上拉刷新
- (void)tableView:(BaseTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    
}//选中

- (void)pullDownData{
   
    friendPage = 1;
    
    if (friendPage == 1) {
       // [_FollowUpArr removeAllObjects];
    }
   // if (array.count > 0) {
        //            if (_listState != personalList) {
        friendPage++;
        NSLog(@"大于0有动态");
      //  emptyLabel.hidden = YES;
        // }
    
    [self performSelector:@selector(getData) withObject:nil afterDelay:2.0f];
    
    
   
}
-(void)getData
{
    _tbView.dataArray =_FollowUpArr;
    
    
    [_tbView reloadData];
    [_tbView doneLoadingTableViewData]; //结束刷新
}
- (void)pullUpData{

    
    [_tbView reloadData];
    [_tbView doneLoadingTableViewData];
}




/*
// tableview-delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_FollowUpArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 250.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FollowUpCell";
    
    
    FollowUpCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[FollowUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
   // int rowIndex=indexPath.row;
    FollowUpInfoModel *model=[_FollowUpArr objectAtIndex:indexPath.row];
    
    cell.txtViewTitle.text=model.title;
    cell.imageView.image=model.imgView;
    ((UILabel *)[cell.messageView viewWithTag:1002]).text=@"24''" ;
     ((UILabel *)[cell.locationView viewWithTag:1003]).text=model.address ;
     cell.lblTime.text=model.time;
    cell.followModel=model;
    // [cell.messageView setTitle:@"24" forState:UIControlStateNormal];
    //int rowIndex=indexPath.row;
   // NSDictionary *dic=[self.reportArr objectAtIndex:rowIndex];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section==0)
    {
        
        
       /* self.hidesBottomBarWhenPushed=YES;
        CustomerReportDetailVC *detailVC=[[CustomerReportDetailVC alloc] initWithNibName:@"CustomerReportDetailView" bundle:nil];
        [self.navigationController pushViewController:detailVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
        
    }
    
    
}*/




- (void)didReceiveMemoryWarning
{
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
