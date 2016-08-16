//
//  DailyReconciDetailList.m
//  IBOSS
//
//  Created by iHope on 14-7-10.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "DailyReconciDetailList.h"
#import "DailyReconciDetailListCell.h"
#import "DailyReconciDetailDetail.h"
@interface DailyReconciDetailList ()<UITableViewDataSource, UITableViewDelegate,RefreshTableViewDelegate>{
    int miPage;
    
}
@property(nonatomic,strong) ASIDownManager *mDownManager;
@property(nonatomic,strong) RefreshTableView *vCustomTableView;
@property(nonatomic,strong) NSMutableArray *stockArr;
@end

@implementation DailyReconciDetailList
@synthesize vCustomTableView;


- (void)OnLoadFinish:(ImageDownManager *)sender {
    
    NSDictionary *dic = [sender.mWebStr JSONValue];
    NSLog(@"dic=%@",dic);
    [self Cancel];
    int iNewCount = 0;
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        int iStatus = [[dic objectForKey:@"Status"] intValue];
         NSString *message=[dic objectForKey:@"Message"];
        if (iStatus == 0) {
            NSArray * approvArr=[dic objectForKey:@"Result"];
            if(approvArr!=nil)
            {
                if (miPage == 1) {
                    [_stockArr removeAllObjects];
                }
                [_stockArr addObjectsFromArray:approvArr];
                iNewCount = approvArr.count;
               // miPage ++;
                vCustomTableView.mbMoreHidden =YES;
                [vCustomTableView FinishLoading];
                [vCustomTableView reloadData];
            }
        }
        else if(iStatus==-2||iStatus==-3||iStatus==-4){
            __weak id weakapp=Appdelegate;
            __weak id userShare=[UserInfoManager Share] ;
            [UIAlertView showAlertViewWithTitle:@""
                                        message:@"加载失败,请您重新登录"
                              cancelButtonTitle:nil
                              otherButtonTitles:[NSArray arrayWithObject:@"OK"]
                                      onDismiss:^(int buttonIndex)  {
                                          [userShare ClearUserData];
                                          [weakapp changeViewDidLogout];
                                          
                                      }
                                       onCancel:^ {}];
            
            
            
            
        }
        else  {
                      [vCustomTableView FinishLoading];
            [vCustomTableView reloadData];
            [self showAlertViewText:message];
            
            
        }
        
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
    // [_flowArr removeAllObjects];
    //[self.tableView reloadData];
    [vCustomTableView FinishLoading];
    [vCustomTableView reloadData];
    [self showAlertViewText:@"加载失败"];
}
- (void)Cancel {
    [self StopLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
}

-(void)reloadData
{
    [self StartLoading];
    NSString *urlStr = [NSString stringWithFormat:ServerURL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"GetDailyReconciliationList" forKey:@"Action"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",kkAccountCode]forKey:@"AccountCode"];
    [dict setObject:kkUserCode forKey:@"UserCode"];
    [dict setObject:kkUserPwd forKey:@"UserPassword"];
    [dict setObject:kkSessionKey forKey:@"SessionKey"];
    
    [dict setObject:_OrganizationCodestr forKey:@"OrganizationCode"];
    [dict setObject:_AccountDateFromstr forKey:@"AccountDateFrom"];
    [dict setObject:_AccountDateTostr forKey:@"AccountDateTo"];
    [dict setObject:_BusinessTypestr forKey:@"BusinessType"];
   
   // [dict setObject:@"001001" forKey:@"OrganizationCode"];
   // [dict setObject:@"2012-6-7" forKey:@"AccountDateFrom"];
    //[dict setObject:@"2013-12-12" forKey:@"AccountDateTo"];
    //[dict setObject:@"1" forKey:@"BusinessType"];
    self.mDownManager = [[ASIDownManager alloc] init];
       _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    [_mDownManager PostHttpRequest:urlStr :dict :nil :nil];
}

-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
        _OrganizationCodestr=@"";//业务部门Code
        _AccountDateFromstr=@"";//财务日期开始
        _AccountDateTostr=@"";//财务日期结束
        _BusinessTypestr=@"";//业务类型

        
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"查询结果";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    vCustomTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    vCustomTableView.backgroundColor=[UIColor redColor];
    vCustomTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    vCustomTableView.backgroundColor = [UIColor whiteColor];
    
    
    vCustomTableView.delegate = self;
    [self.view addSubview:vCustomTableView];
    
    _stockArr=[NSMutableArray new];
    miPage=1;
    
     [self reloadData];
    
    
}
-(void)dealloc
{
    [self Cancel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - RefreshTableView

- (void)LoadMoreList:(RefreshTableView *)sender {
    [self reloadData];
}

- (void)ReloadList:(RefreshTableView *)sender{
    miPage = 1;
    [self reloadData];
}

- (BOOL)CanRefreshTableView:(RefreshTableView *)sender {
    return !_mDownManager;
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return _stockArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    
   DailyReconciDetailListCell *cell2 = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell2 == nil) {
        cell2= [[ DailyReconciDetailListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dic= _stockArr[indexPath.row];
    if(dic!=nil)
    {
       // cell2.lblOrganizeName=[dic objectForKey:@"OrganizationName"];
       // cell2.lblOrganizeFullName=[dic objectForKey:@"OrganizationFullName"];
    cell2.lblOrganizeName.text=[dic objectForKey:@"OrganizationName"];
     if([dic objectForKey:@"ReceiptAmount"]){
        cell2.lblShouKuan.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ReceiptAmount"] ];
        }
        if([dic objectForKey:@"EarnestAmount"]){
            cell2.lblDingJin.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"EarnestAmount"]];
        }
        if([dic objectForKey:@"DepositAmount"]){
            cell2.lblYuCun.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"DepositAmount"]];
        }
        if([dic objectForKey:@"ReceivableAmount"]){
            cell2.lblTotalAmount.text=[NSString stringWithFormat:@"%@",[dic objectForKey:@"ReceivableAmount"]];
        }
  
    }
    return cell2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary *dic= _stockArr[indexPath.row];
    if(dic!=nil)
    {
        NSString *orgID=[dic objectForKey:@"OrganizationID"];
        NSString *time=[dic objectForKey:@"AccountDate"];
        NSString *businessType=_BusinessTypestr;
        
        self.hidesBottomBarWhenPushed=YES;
        DailyReconciDetailDetail *detailVC =[[DailyReconciDetailDetail alloc]init];
        detailVC.OrganizationID=orgID;
        detailVC.AccountDate=time;
        detailVC.BusinessType=businessType;
        [self.navigationController pushViewController:detailVC animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    

        
    }

}


@end
