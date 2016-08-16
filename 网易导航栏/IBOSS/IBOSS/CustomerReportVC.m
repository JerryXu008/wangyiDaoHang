//
//  CustomerReportVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerReportVC.h"
#import "ReportTBCell.h"
#import "CustomerReportDetailVC.h"
#import "CustomerReportCreateVC.h"
@interface CustomerReportVC ()
@property(nonatomic,strong) NSMutableArray * reportArr;
@property(nonatomic,strong) NSDictionary * reportOneDic;
@end

@implementation CustomerReportVC
@synthesize reportListTV=_reportListTV;
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
    self.reportOneDic=@{@"客户名称": @"天华",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"天华",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
    [self.reportArr addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"天华",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
     [self.reportArr addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"天华",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
     [self.reportArr addObject:_reportOneDic];
    self.reportOneDic=@{@"客户名称": @"天华",@"渠道":@"零售",@"联系电话":@"13287781387",@"业务部门":@"小区部",@"业务员":@"周伟明",@"地址":@"北京市朝阳区"};
     [self.reportArr addObject:_reportOneDic];
    NSLog(@"self.reportcount=%d",self.reportArr.count);
    
}
-(void)setViewStyle
{
  self.navigationItem.title=@"客户报备";
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
   // self.reportListTV.backgroundColor=[UIColor redColor];
    [self setViewStyle];
    //self.reportListTV.hidden=YES;
    self.searchView.userInteractionEnabled=YES;
    self.searchView.backgroundColor=[UIColor redColor];
    
    NSLog(@"searchView=%@",self.searchView);
    
    [self reloadData];
    [self.reportListTV reloadData];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        
    }
    else {
        
    }
    
    self.reportListTV.backgroundColor=[UIColor greenColor];
    
}
-(void)viewWillAppear:(BOOL)animated
{
  //  self.hidesBottomBarWhenPushed=YES;
   // self.tabBarController.tabBar.hidden=YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.reportArr count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 93.0f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ReportCell";
   
    
    ReportTBCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"ReportTBCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   /* static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"ReportTBCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:CellIdentifier ];
        nibsRegistered = YES;
    }
    
    ReportTBCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];*/
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
        // self.hidesBottomBarWhenPushed=NO;
    }
    
    
}
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


//点击查询
-(IBAction)btnSearch :(id)sender
{
    

}
//新建报备
-(IBAction)btnCreateReport:(id)sender
{
   self.hidesBottomBarWhenPushed=YES;
    CustomerReportCreateVC * createVC=[[CustomerReportCreateVC alloc] initWithNibName:@"CustomerReportCreateView" bundle:nil];
    [self.navigationController pushViewController:createVC animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
