//
//  ApproveVC.m
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "ApproveVC.h"
#import "RadioButton.h"

@interface ApproveVC ()
@property(strong) ASIDownManager* mDownManager ;
@property(nonatomic)BOOL hasSelect;
@property(nonatomic,copy) NSString * AuditResult;
@property(nonatomic,strong) NSMutableArray *InvoiceIDArr;//ID数组
@property(nonatomic,strong) NSMutableArray *StatusArr;
@property(nonatomic,strong) NSMutableArray *StepNoArr;

@property(nonatomic,strong) UIButton *btnTongYi;
@property(nonatomic,strong) UIButton *btnnotTongYi;
@end

@implementation ApproveVC
@synthesize btnTongYi,btnnotTongYi;

-(void)setSelectArr:(NSMutableArray*)arr
{
    _selectArr=arr;
   
    WorkFlowInfoModel *model=arr[0];
    _flowCode=model.FlowCode;
    for (int i=0; i<_selectArr.count; i++) {
        WorkFlowInfoModel *dic=[_selectArr objectAtIndex:i];
        [_InvoiceIDArr addObject:dic.InvoiceID];
        [_StatusArr addObject:dic.Status];
        [_StepNoArr addObject:dic.StepNo];
    }
    
}

- (void)OnLoadFinish:(ImageDownManager *)sender {
    
    NSDictionary *dic = [sender.mWebStr JSONValue];
    NSLog(@"dic=%@",dic);
    [self Cancel];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        int iStatus = [[dic objectForKey:@"Status"] intValue];
         NSString *message=[dic objectForKey:@"Message"];
        if (iStatus == 0) {
              MBProgressHUD*   HUD = [[MBProgressHUD alloc] initWithView:self.view];
             [self.view addSubview:HUD];
             HUD.labelText = @"审批成功";
             HUD.mode = MBProgressHUDModeText;
             [HUD showAnimated:YES whileExecutingBlock:^{
             sleep(2);
             } completionBlock:^{
             [HUD removeFromSuperview];
             [self.ParentVC performSelector:@selector(reloadData) withObject:nil afterDelay:0.0];
             [self.navigationController popViewControllerAnimated:YES];
             
             }];
        }
        else if(iStatus==-2||iStatus==-3||iStatus==-4){
            __weak id weakapp=Appdelegate;
            __weak id userShare=[UserInfoManager Share] ;
            [UIAlertView showAlertViewWithTitle:@""
                                        message:@"操作失败,请您重新登录"
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
    [self showAlertViewText:@"操作失败"];
}
- (void)Cancel {
    [self hideLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _selectArr=[NSMutableArray new];
        _InvoiceIDArr=[NSMutableArray new];
        _StatusArr=[NSMutableArray new];
        _StepNoArr=[NSMutableArray new];
        

    }
    return self;
}
-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)MakeApprove
{
    if(!_hasSelect)
    {
        [self showAlertViewText:@"请选择通过或者退回"];
        return;
    }
    if([_txtView.text isEqualToString:@""]){
        [self showAlertViewText:@"审批内容不能为空"];
        return;
    }
    [self showLoading];
    self.mDownManager = [[ASIDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);

    NSString *urlStr = [NSString stringWithFormat:ServerURL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"AuditInvoiceInfo" forKey:@"Action"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",kkAccountCode]forKey:@"AccountCode"];
    [dict setObject:kkUserCode forKey:@"UserCode"];
    [dict setObject:kkUserPwd forKey:@"UserPassword"];
    [dict setObject:kkSessionKey forKey:@"SessionKey"];
    [dict setObject:_AuditResult forKey:@"AuditResult"];
    [dict setObject:_txtView.text forKey:@"Suggestion"];
    [dict setObject:_flowCode forKey:@"FlowCode"];
    [dict setObject:[self getArrToString:_InvoiceIDArr ] forKey:@"InvoiceID"];
    [dict setObject:[self getArrToString:_StatusArr ] forKey:@"Status"];
    [dict setObject:[self getArrToString:_StepNoArr ] forKey:@"StepNo"];
    NSLog(@"dic=%@",dict);
    
    [_mDownManager PostHttpRequest:urlStr :dict :nil :nil];
    
    
    
    
 
}
-(void)loadNavStyle
{
    //右边
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    // button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(MakeApprove)
      forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0, 0, 40, 24);
    //button2.titleLabel.text=@"跟进";
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    [button2 setTitleColor:NavBarItemColor forState:UIControlStateNormal];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _hasSelect=YES;
     _AuditResult=@"1";
	// Do any additional setup after loading the view.
    [self loadNavStyle];
    self.navigationItem.title=@"审批";
   [self.txtView becomeFirstResponder];
   [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationItem.title=@"审批";
    self.OutView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    self.TextView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
   
    /*RadioButton *rb1 = [[RadioButton alloc] initWithGroupId:@"1" index:0];
    RadioButton *rb2 = [[RadioButton alloc] initWithGroupId:@"1" index:1];
    rb1.title=@"通过";
    rb2.title=@"退回";
    rb1.frame = CGRectMake(100,self.SelectView.frame.size.height/2-rb1.Height/2,rb1.Width,rb1.Height);
    rb2.frame = CGRectMake(200,self.SelectView.frame.size.height/2-rb2.Height/2,rb2.Width,rb2.Height);
    
    [self.SelectView addSubview:rb1];
    [self.SelectView addSubview:rb2];
   
    [RadioButton addObserverForGroupId:@"1" observer:self];
    */
    
    btnTongYi=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTongYi.tag=1001;
    btnTongYi.frame=CGRectMake(100, self.SelectView.frame.size.height/2-7.5, 15, 15);
    [btnTongYi setBackgroundImage:[UIImage imageNamed:@"xuanzhongshenpi"] forState:UIControlStateNormal];
    [btnTongYi addTarget:self action:@selector(Check:) forControlEvents:UIControlEventTouchUpInside];
    [self.SelectView addSubview:btnTongYi];
    UILabel *lblTongyi=[UILabel new];
    lblTongyi.frame=CGRectMake(120, self.SelectView.frame.size.height/2-7.5, 50, 20);
    lblTongyi.text=@"通过";
    [self.SelectView addSubview:lblTongyi];
    
    btnnotTongYi=[UIButton buttonWithType:UIButtonTypeCustom];
    btnnotTongYi.tag=1002;
    btnnotTongYi.frame=CGRectMake(180, self.SelectView.frame.size.height/2-7.5, 15, 15);
    [btnnotTongYi setBackgroundImage:[UIImage imageNamed:@"weixuanshenpi"] forState:UIControlStateNormal];
    [btnnotTongYi addTarget:self action:@selector(Check:) forControlEvents:UIControlEventTouchUpInside];
    [self.SelectView addSubview:btnnotTongYi];
    UILabel *lblnotTongyi=[UILabel new];
    lblnotTongyi.frame=CGRectMake(200, self.SelectView.frame.size.height/2-7.5, 80, 20);
    lblnotTongyi.text=@"不通过";
    [self.SelectView addSubview:lblnotTongyi];
}

-(void) Check:(id)sender
{
    UIButton* btn=sender;
   if(btn.tag==1001)
   {
      _AuditResult=@"1";
       [btnTongYi setBackgroundImage:[UIImage imageNamed:@"xuanzhongshenpi"] forState:UIControlStateNormal];
       [btnnotTongYi setBackgroundImage:[UIImage imageNamed:@"weixuanshenpi"] forState:UIControlStateNormal];
       
   }
    else if(btn.tag==1002)
    {
         _AuditResult=@"0";
        [btnnotTongYi setBackgroundImage:[UIImage imageNamed:@"xuanzhongshenpi"] forState:UIControlStateNormal];
        [btnTongYi setBackgroundImage:[UIImage imageNamed:@"weixuanshenpi"] forState:UIControlStateNormal];
    }
}
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString *)groupId{
    _hasSelect=YES;
    _AuditResult=index==0?@"1":@"0" ;
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
