//
//  DailyReconciDetailDetail.m
//  IBOSS
//
//  Created by iHope on 14-7-11.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "DailyReconciDetailDetail.h"
#import "StockDetailListCell.h"
#import "RefreshTableView.h"
@interface DailyReconciDetailDetail ()<UITableViewDataSource, UITableViewDelegate,RefreshTableViewDelegate>{
 
    
}
@property(nonatomic,strong) ASIDownManager *mDownManager;
@property(nonatomic,strong) RefreshTableView *vCustomTableView;
@property(nonatomic,strong) NSMutableArray *stockArr;
@end

@implementation DailyReconciDetailDetail
@synthesize vCustomTableView;
-(NSArray *)SeparateStringToArray :(NSString *)text
{
    NSArray  * array= [text componentsSeparatedByString:@" "];
    return [array copy];
    
}


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
               
                [_stockArr removeAllObjects];
                
                [_stockArr addObjectsFromArray:approvArr];
                iNewCount = approvArr.count;
              
                vCustomTableView.mbMoreHidden = YES;
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
            //  [[UserInfoManager Share] ClearUserData];
            // [_flowArr removeAllObjects];
            //  [self.tableView reloadData];
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
    
    [dict setObject:@"GetDailyReconciliationDetail" forKey:@"Action"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",kkAccountCode]forKey:@"AccountCode"];
    [dict setObject:kkUserCode forKey:@"UserCode"];
    [dict setObject:kkUserPwd forKey:@"UserPassword"];
    [dict setObject:kkSessionKey forKey:@"SessionKey"];
    
    [dict setObject:_OrganizationID forKey:@"OrganizationID"];
    [dict setObject:_AccountDate forKey:@"AccountDate"];
    [dict setObject:_BusinessType forKey:@"BusinessType"];
  
    
    
    self.mDownManager = [[ASIDownManager alloc] init];
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
        _OrganizationID=@"";
        _AccountDate=@"";
        _BusinessType=@"";
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    [self reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"日结对账表明细";
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
    // vCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    vCustomTableView.delegate = self;
    [self.view addSubview:vCustomTableView];
    
    _stockArr=[NSMutableArray new];
   
    
    
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
   
    [self reloadData];
}

- (BOOL)CanRefreshTableView:(RefreshTableView *)sender {
    return !_mDownManager;
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *textDetail=[[NSString alloc] init];
    NSString *detailStr=[_stockArr objectAtIndex:indexPath.row];
    NSArray *tempArr= [self SeparateStringToArray:detailStr];
    if(tempArr!=nil)
    {
        for(int i=0;i<tempArr.count;i++)
        {
            textDetail= [textDetail stringByAppendingFormat:@"%@ \n", [tempArr objectAtIndex:i] ];
            
        }
    }
    UILabel *tmp = [[UILabel alloc] init];
    tmp.font = [UIFont systemFontOfSize:16];
    
    CGSize  expectedLabelSize = [textDetail sizeWithFont:tmp.font constrainedToSize:CGSizeMake(269, 9999) lineBreakMode:NSLineBreakByWordWrapping];
    return expectedLabelSize.height+10+10;
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
    
    
    StockDetailListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[StockDetailListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *textDetail=@"";
    NSString *detailStr=_stockArr[indexPath.row];
    NSArray *tempArr= [self SeparateStringToArray:detailStr];
    if(tempArr!=nil)
    {
        for(int i=0;i<tempArr.count;i++)
        {
            textDetail= [textDetail stringByAppendingFormat:@"%@ \n", [tempArr objectAtIndex:i] ];
            
        }
    }
    
    cell.moreText.text=textDetail;
    cell.moreText.numberOfLines = 0;
    cell.moreText.textColor = [UIColor blackColor];
    cell.moreText.lineBreakMode = NSLineBreakByWordWrapping;
    
    return cell;
}


@end
