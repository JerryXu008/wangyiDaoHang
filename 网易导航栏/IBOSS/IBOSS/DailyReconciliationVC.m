//
//  DailyReconciliationVC.m
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "DailyReconciliationVC.h"
#import "YeWuSearchTC.h"
#import "DailyReconciDetailList.h"
#import "BRDatePickerView.h"
#import "BuMenSearchTC.h"
@interface DailyReconciliationVC ()
@property(strong)BRDatePickerView *brdatePicker;
@end

@implementation DailyReconciliationVC

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
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"日结对账表";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
     button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    [self initUI];
    _YeWuHiddenStr=@"";
    _BuMenHiddenStr=@"";
    _StartRiQiStr=@"";
    _EndRiQiStr=@"";

}
-(void)clearData:(id)sender
{
    UIButton *btn=sender;
    if(btn.tag==1001)//清楚业务类型
    {
      [_btnYeWu setTitle:@"请选择业务类型" forState:UIControlStateNormal];
        _YeWuHiddenStr=@"";
    }
    else if(btn.tag==1002){//清除开始日期
      
        [_btnStartRiQi setTitle:@"请选择开始日期" forState:UIControlStateNormal];
        _StartRiQiStr=@"";
        
    }
    else if(btn.tag==1003){//清除结束日期
        [_btnEndRiQi setTitle:@"请选择结束日期" forState:UIControlStateNormal];
        _EndRiQiStr=@"";
    }
    else if(btn.tag==1004){//清除业务部门
        [_btnBuMen setTitle:@"请选择业务部门" forState:UIControlStateNormal];
        _BuMenHiddenStr=@"";
    }
}
-(void)initUI
{
    UIScrollView *scroll=[UIScrollView new];
    scroll.frame=self.view.bounds;
    scroll.tag=1001;
    
    UITapGestureRecognizer*  singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKey)];
    [scroll addGestureRecognizer:singleRecognizer];
    [self.view addSubview:scroll];
    // scroll.backgroundColor=[UIColor redColor];
    if(Screen_Height2<=480){
        scroll.contentSize=CGSizeMake(self.view.frame.size.width, self.view.frame.size.height+80);
    }
    UIView * contentView=[[UIView alloc]init];
    contentView.frame=CGRectMake(0, 20, Screen_Width, 204);
    contentView.backgroundColor=[UIColor whiteColor];
    [scroll addSubview:contentView];
    //业务类型==================
    UIView *v1=[UIView new];
    v1.frame=CGRectMake(0, 0, Screen_Width, 51);
    [contentView addSubview:v1];
    //星号
    UIImageView* bitian1=[UIImageView new];
    bitian1.image=[UIImage imageNamed:@"bitian"];
    bitian1.frame=CGRectMake(12, 25, 8, 7);
    [v1 addSubview:bitian1];
    UILabel *lblKunQu=[UILabel new];
    lblKunQu.frame=CGRectMake(20, 16, 100, 25);
    lblKunQu.text=@"业务类型：";
    [v1 addSubview:lblKunQu];
    _btnYeWu=[UIButton buttonWithType:UIButtonTypeCustom];
    // _btnKunQu.frame=CGRectMake(105, 16, 200, 25);
    _btnYeWu.frame=CGRectMake(105, 16, 150, 25);
    [_btnYeWu setTitle:@"请选择业务类型" forState:UIControlStateNormal];
    [_btnYeWu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    //_btnYeWu.backgroundColor=[UIColor redColor];
    [_btnYeWu addTarget:self action:@selector(showYeWuSelect) forControlEvents:UIControlEventTouchUpInside];
    [v1 addSubview:_btnYeWu];
    //清除按钮
    UIButton *btnClearYeWu=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClearYeWu.frame=CGRectMake(Screen_Width-50, 18, 22, 22);
    [btnClearYeWu setBackgroundImage:[UIImage imageNamed:@"ClearData"] forState:UIControlStateNormal];
    btnClearYeWu.tag=1001;
    [btnClearYeWu addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [v1 addSubview:btnClearYeWu];
    //分割线
    UIImageView *f1=[UIImageView new];
    f1.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f1.image=[UIImage imageNamed:@"fengexian"];
    [v1 addSubview:f1];
    
    //开始日期==================
    UIView *v2=[UIView new];
    v2.frame=CGRectMake(0, 51, Screen_Width, 51);
    [contentView addSubview:v2];
    
    UIImageView* bitian2=[UIImageView new];
    bitian2.image=[UIImage imageNamed:@"bitian"];
    bitian2.frame=CGRectMake(12, 25, 8, 7);
    [v2 addSubview:bitian2];
   
    UILabel *lblstarttime=[UILabel new];
    lblstarttime.frame=CGRectMake(20, 16, 150, 25);
    lblstarttime.text=@"开始日期：";
    [v2 addSubview:lblstarttime];
    _btnStartRiQi=[UIButton buttonWithType:UIButtonTypeCustom];
    // _btnKunQu.frame=CGRectMake(105, 16, 200, 25);
   _btnStartRiQi.frame=CGRectMake(105, 16, 150, 25);
    [_btnStartRiQi setTitle:@"请选择开始日期" forState:UIControlStateNormal];
    [_btnStartRiQi setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnStartRiQi addTarget:self action:@selector(showKaiShiSelect) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:_btnStartRiQi];
    //清除按钮
    UIButton *btnClearStartDate=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClearStartDate.frame=CGRectMake(Screen_Width-50, 18, 22, 22);
    [btnClearStartDate setBackgroundImage:[UIImage imageNamed:@"ClearData"] forState:UIControlStateNormal];
    btnClearStartDate.tag=1002;
    [btnClearStartDate addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:btnClearStartDate];
    //分割线
    UIImageView *f2=[UIImageView new];
    f2.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f2.image=[UIImage imageNamed:@"fengexian"];
    [v2 addSubview:f2];
    
    //结束日期
    UIView *v3=[UIView new];
    v3.frame=CGRectMake(0, 51*2, Screen_Width, 51);
    [contentView addSubview:v3];
    UIImageView* bitian3=[UIImageView new];
    bitian3.image=[UIImage imageNamed:@"bitian"];
    bitian3.frame=CGRectMake(12, 25, 8, 7);
    [v3 addSubview:bitian3];
    UILabel *lblendtime=[UILabel new];
    lblendtime.frame=CGRectMake(20, 16, 100, 25);
    lblendtime.text=@"结束日期：";
    [v3 addSubview:lblendtime];
    _btnEndRiQi=[UIButton buttonWithType:UIButtonTypeCustom];
     _btnEndRiQi.frame=CGRectMake(105, 16, 150, 25);
    [ _btnEndRiQi setTitle:@"请选择结束日期" forState:UIControlStateNormal];
    [ _btnEndRiQi setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [ _btnEndRiQi addTarget:self action:@selector(showJieShuSelect) forControlEvents:UIControlEventTouchUpInside];
    [v3 addSubview: _btnEndRiQi];
    //清除按钮
    UIButton *btnClearEndDate=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClearEndDate.frame=CGRectMake(Screen_Width-50, 18, 22, 22);
    [btnClearEndDate setBackgroundImage:[UIImage imageNamed:@"ClearData"] forState:UIControlStateNormal];
    btnClearEndDate.tag=1003;
    [btnClearEndDate addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [v3 addSubview:btnClearEndDate];
    //分割线
    UIImageView *f3=[UIImageView new];
    f3.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f3.image=[UIImage imageNamed:@"fengexian"];
    [v3 addSubview:f3];

    
    //业务部门==================
    UIView *v4=[UIView new];
    v4.frame=CGRectMake(0, 51*3, Screen_Width, 51);
    [contentView addSubview:v4];
    UILabel *lblShangBian=[UILabel new];
    lblShangBian.frame=CGRectMake(20, 16, 100, 25);
    lblShangBian.text=@"业务部门：";
    [v4 addSubview:lblShangBian];
    _btnBuMen=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnBuMen.frame=CGRectMake(105, 16, 150, 25);
    [_btnBuMen setTitle:@"请选择业务部门" forState:UIControlStateNormal];
    [_btnBuMen setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnBuMen addTarget:self action:@selector(showBuMenSelect) forControlEvents:UIControlEventTouchUpInside];
    [v4 addSubview:_btnBuMen];
    //清除按钮
    UIButton *btnClearBuMen=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClearBuMen.frame=CGRectMake(Screen_Width-50, 18, 22, 22);
    [btnClearBuMen setBackgroundImage:[UIImage imageNamed:@"ClearData"] forState:UIControlStateNormal];
    btnClearBuMen.tag=1004;
    [btnClearBuMen addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [v4 addSubview:btnClearBuMen];
    //分割线
    UIImageView *f4=[UIImageView new];
    f4.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f4.image=[UIImage imageNamed:@"fengexian"];
    [v4 addSubview:f4];
    
       //查询
    UIButton *btnSearch=[UIButton buttonWithType:UIButtonTypeCustom];
    btnSearch.frame=CGRectMake((Screen_Width-204)*0.5, 240, 204, 35);
    [btnSearch setBackgroundImage:[UIImage imageNamed:@"chaxunanniu"] forState:UIControlStateNormal];
    [btnSearch addTarget:self action:@selector(GOSearch) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:btnSearch];
    
    
}
-(void)showYeWuSelect
{
    [self.view  endEditing:YES];
    YeWuSearchTC *tc=[YeWuSearchTC new];
    tc.parentVC=self;
    [self.navigationController pushViewController:tc animated:YES];
    
}
-(void)showBuMenSelect
{
    [self.view  endEditing:YES];
    BuMenSearchTC *tc=[BuMenSearchTC new];
    tc.parentVC=self;
    [self.navigationController pushViewController:tc animated:YES];

}
-(void)showKaiShiSelect
{
    __weak typeof(self)  weakself=self;
    _brdatePicker = [BRDatePickerView PickerAlertWithTitle:@""];
    [_brdatePicker configureSelectionBlock:^(NSString *date){
        weakself.StartRiQiStr=date;
    } andCompletionBlock:^(void){
        [weakself.btnStartRiQi setTitle:weakself.StartRiQiStr forState:UIControlStateNormal];
    } andCancelBlock:^(void){
        weakself.StartRiQiStr=@"";
    }];
    [_brdatePicker show];

}
-(void)showJieShuSelect
{
    __weak typeof(self)  weakself=self;
    _brdatePicker = [BRDatePickerView PickerAlertWithTitle:@""];
    [_brdatePicker configureSelectionBlock:^(NSString *date){
        weakself.EndRiQiStr=date;
    } andCompletionBlock:^(void){
        [weakself.btnEndRiQi setTitle:weakself.EndRiQiStr forState:UIControlStateNormal];
    } andCancelBlock:^(void){
    weakself.EndRiQiStr=@"";
    }];
    [_brdatePicker show];

}
-(void)GOSearch
{
    
   if([NSString stringWithFormat:@"%@",_YeWuHiddenStr ].length==0)
   {
       [self showAlertViewText:@"请选择业务类型"];
       return;
   }
   if([NSString stringWithFormat:@"%@",_StartRiQiStr ].length==0)
   {
       [self showAlertViewText:@"请选择开始日期"];
       return;
   }
   if([NSString stringWithFormat:@"%@",_EndRiQiStr ].length==0)
   {
       [self showAlertViewText:@"请选择结束日期"];
       return;
   }
   //时间间隔最多为30天
    double totalSenconds=30*24*3600;
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1=[dateFormatter dateFromString:_StartRiQiStr];
    NSDate *date2=[dateFormatter dateFromString:_EndRiQiStr];
    NSTimeInterval time=[date2 timeIntervalSinceDate:date1];
    if(time<0){
    //结束日期要大于开始日期
    [self showAlertViewText:@"结束日期要大于开始日期"];
        return;
    }
    
    if(time>totalSenconds)
    {
     [self showAlertViewText:@"日期跨度不能超过30天"];
        return;
    }
    
    

   self.hidesBottomBarWhenPushed=YES;
   DailyReconciDetailList *detailList=[[DailyReconciDetailList alloc] init];
    
    detailList.OrganizationCodestr=_BuMenHiddenStr;
    detailList.BusinessTypestr=_YeWuHiddenStr;
    detailList.AccountDateFromstr=_StartRiQiStr;
    detailList.AccountDateTostr=_EndRiQiStr;
    [self.navigationController pushViewController:detailList animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}



-(void)hideKey
{
    [self.view  endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
