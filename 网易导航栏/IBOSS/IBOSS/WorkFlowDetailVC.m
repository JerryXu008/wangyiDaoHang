//
//  WorkFlowDetailVC.m
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "WorkFlowDetailVC.h"
#import "WorkFlowDetailCell.h"
@interface WorkFlowDetailVC ()
@property(nonatomic,strong) ASIDownManager *mDownManager;
@property(nonatomic,strong) NSArray *DetailArr;
@property(strong)UILabel *lblDanJuHao;
@property(strong)UILabel *lblDanjuleixing;
@property(strong)UILabel *lblshenpiyuanyin;
@property(strong)UILabel *lblchuangjianzhe;
@property(strong)UILabel *lblchuangjianshijian;
@property(strong)UILabel *lblbeizhu;
@end

@implementation WorkFlowDetailVC
- (void)OnLoadFinish:(ImageDownManager *)sender {
    
    NSDictionary *dic = [sender.mWebStr JSONValue];
    NSLog(@"dic=%@",dic);
    [self Cancel];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        int iStatus = [[dic objectForKey:@"Status"] intValue];
         NSString *message=[dic objectForKey:@"Message"];
        if (iStatus == 0) {
            NSArray * approvArr=[dic objectForKey:@"Result"];
            if(approvArr!=nil&&approvArr.count>0)
            {
                _DetailArr= approvArr;
              //  NSLog(@"arroveArr=%@",approvArr[0]);
                [self reLoadData];
               
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
            [self showAlertViewText:message];
        }
        
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
    [self showAlertViewText:@"加载失败"];
}
- (void)Cancel {
    [self hideLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
}
-(void) reLoadData
{
    [self.tbView reloadData];
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _DetailArr=[[NSArray alloc] init];
    //self.navigationController.navigationBar.tintColor=NavColor;

    self.navigationItem.title=@"单据详情";
	// Do any additional setup after loading the view.
    _scrollView.contentSize=CGSizeMake(320, 568);
    self.tbView.dataSource=self;
    self.tbView.delegate=self;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    [self InitTableHeader];
    

}
-(void)InitTableHeader
{
    //单据内容
    UIView * contentView=[[UIView alloc] init];
    contentView.frame=CGRectMake(0, 0, Screen_Width, 190);
   // contentView.backgroundColor=[UIColor redColor];
    
    UILabel *lblShow=[UILabel new];
    lblShow.frame=CGRectMake(25, 20, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"单  据  号：";
    [contentView addSubview:lblShow];
    
    _lblDanJuHao=[UILabel new];
    _lblDanJuHao.frame=CGRectMake(110, 20, 200, 20);
  //  _lblDanJuHao.text=@"No.00001";
      [contentView addSubview:_lblDanJuHao];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(25, 45, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"单据类型：";
    [contentView addSubview:lblShow];
    
    _lblDanjuleixing=[UILabel new];
    _lblDanjuleixing.frame=CGRectMake(110, 45, 200, 20);
  //  _lblDanjuleixing.text=@"销售订单";
    [contentView addSubview:_lblDanjuleixing];
    
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(25, 70, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"审批原因：";
    [contentView addSubview:lblShow];
    
    _lblshenpiyuanyin=[UILabel new];
     _lblshenpiyuanyin.frame=CGRectMake(110, 70, 200, 20);
    // _lblshenpiyuanyin.text=@"折扣低于限制";
    [contentView addSubview: _lblshenpiyuanyin];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(25, 95, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"创  建  者：";
    [contentView addSubview:lblShow];
    
    _lblchuangjianshijian=[UILabel new];
    _lblchuangjianshijian.frame=CGRectMake(110, 95, 200, 20);
   // _lblchuangjianshijian.text=@"霍非";
    [contentView addSubview: _lblchuangjianshijian];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(25, 120, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"创建时间：";
    [contentView addSubview:lblShow];
    
    _lblchuangjianshijian=[UILabel new];
     _lblchuangjianshijian.frame=CGRectMake(110, 120, 200, 20);
    // _lblchuangjianshijian.text=@"2014";
    [contentView addSubview:  _lblchuangjianshijian];
    
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(25, 145, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"备       注：";
    [contentView addSubview:lblShow];
    
    _lblbeizhu=[UILabel new];
    _lblbeizhu.frame=CGRectMake(110, 145, 200, 20);
   // _lblbeizhu.text=@"霍非";
    [contentView addSubview: _lblbeizhu];
    
    UIImageView *fengeView=[UIImageView new];
    fengeView.image=[UIImage imageNamed:@"fengexian"];
    fengeView.frame=CGRectMake(0, 180, Screen_Width, 1);
    [contentView addSubview:fengeView];
    _tbView.tableHeaderView=contentView;
    
    if(self.dicInfo)
    {
      _lblDanJuHao.text= [self.dicInfo InvoiceNo];
      _lblDanjuleixing.text=[self.dicInfo AuditTypeName];
     _lblshenpiyuanyin.text=[self.dicInfo AuditReason];
     _lblchuangjianzhe.text=[self.dicInfo CreateUserName];
      _lblchuangjianshijian.text=[self.dicInfo CreateTime];
      _lblbeizhu.text=[self.dicInfo Remarks];
    }
    

}
-(void)viewWillAppear:(BOOL)animated
{
    self.mDownManager = [[ASIDownManager alloc] init];
    self.mDownManager = [[ASIDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);

    [self showLoading];
    NSString *urlStr = [NSString stringWithFormat:ServerURL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"GetAuditDetail" forKey:@"Action"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",kkAccountCode]forKey:@"AccountCode"];
    [dict setObject:kkUserCode forKey:@"UserCode"];
    [dict setObject:kkUserPwd forKey:@"UserPassword"];
    [dict setObject:kkSessionKey forKey:@"SessionKey"];
    [dict setObject:_FlowCode forKey:@"FlowCode"];
    [dict setObject:_InvoiceID forKey:@"InvoiceID"];
    [_mDownManager PostHttpRequest:urlStr :dict :nil :nil];
    
    

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *textDetail=[[NSString alloc] init];
    NSString *detailStr=[_DetailArr objectAtIndex:indexPath.row];
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
    return _DetailArr.count;
}
-(NSArray *)SeparateStringToArray :(NSString *)text
{
  NSArray  * array= [text componentsSeparatedByString:@" "];
  return [array copy];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    WorkFlowDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell= [[WorkFlowDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    NSString *textDetail=@"";
    NSString *detailStr=[_DetailArr objectAtIndex:indexPath.row];
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

    
    
    return cell;
   
    
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

@end
