//
//  StockDetailVC.m
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "StockDetailVC.h"
#import "StockDetailList.h"
#import "KuQuSearchTC.h"
#import "PinPaiSearchTC.h"
@interface StockDetailVC ()
@property(strong) UITextField *txtKunQu;
@property(strong) UITextField *txtPinPai;
@property(strong) UITextField *txtShangBian;
@property(strong) UITextField *txtWeiBian;

//@property(strong) UIPickerView *picker;
@property(strong) NSArray *pickerArray;
@property(strong) UIView *pickBG;
@property BOOL keyboardShow;
@end

@implementation StockDetailVC

-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"库存明细表";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    [self initUI];
    _KuQuHiddenStr=@"";
    _PinPaiHiddenStr=@"";
//    _pickerArray=@[@"北京库区",@"天津库区",@"济南库区",@"菏泽库区",@"沧州库区"];
 //   _picker.delegate=self;
  //  _picker.dataSource=self;
    

   
    
}
-(void)viewWillAppear:(BOOL)animated
{
}
-(void)viewWillDisappear:(BOOL)animated
{
    //_picker.hidden=YES;
}
-(void)showKunQuSelect
{
    [self.view  endEditing:YES];
    KuQuSearchTC *tc=[KuQuSearchTC new];
    tc.parentVC=self;
    [self.navigationController pushViewController:tc animated:YES];
}
-(void)showPinPaiSelect
{
    [self.view  endEditing:YES];
    PinPaiSearchTC *tc=[PinPaiSearchTC new];
    tc.parentVC=self;
    [self.navigationController pushViewController:tc animated:YES];
 /* if(_picker.hidden)
  {
     _picker.hidden=NO;
 }
 else {
     _picker.hidden=YES;
 }*/
}
-(void)clearData:(id)sender
{
    UIButton *btn=sender;
    if(btn.tag==1001)//清楚业务类型
    {
        [_btnKunQu setTitle:@"请选择库区" forState:UIControlStateNormal];
         _KuQuHiddenStr=@"";
    }
    else if(btn.tag==1002){//清除开始日期
        
         [_btnPinPai setTitle:@"请选择品牌" forState:UIControlStateNormal];
        _PinPaiHiddenStr=@"";
        
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
    
   

    
    
    //库区==================
    UIView *v1=[UIView new];
    v1.frame=CGRectMake(0, 0, Screen_Width, 51);
    [contentView addSubview:v1];
    UILabel *lblKunQu=[UILabel new];
    lblKunQu.frame=CGRectMake(20, 16, 100, 25);
    lblKunQu.text=@"库      区：";
    [v1 addSubview:lblKunQu];
   // v1.backgroundColor=[UIColor greenColor];
  //  _txtKunQu=[UITextField new];
   // _txtKunQu.frame=CGRectMake(105, 16, 200, 25);
    //_txtKunQu.placeholder=@"选择库区";
    _btnKunQu=[UIButton buttonWithType:UIButtonTypeCustom];
   // _btnKunQu.frame=CGRectMake(105, 16, 200, 25);
     _btnKunQu.frame=CGRectMake(105, 16, 90, 25);
    [_btnKunQu setTitle:@"请选择库区" forState:UIControlStateNormal];
    [_btnKunQu setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnKunQu addTarget:self action:@selector(showKunQuSelect) forControlEvents:UIControlEventTouchUpInside];
    [v1 addSubview:_btnKunQu];
    //清除按钮
    UIButton *btnClearKuQu=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClearKuQu.frame=CGRectMake(Screen_Width-50, 18, 22, 22);
    [btnClearKuQu setBackgroundImage:[UIImage imageNamed:@"ClearData"] forState:UIControlStateNormal];
    btnClearKuQu.tag=1001;
    [btnClearKuQu addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [v1 addSubview:btnClearKuQu];
    //分割线
    UIImageView *f1=[UIImageView new];
    f1.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f1.image=[UIImage imageNamed:@"fengexian"];
    [v1 addSubview:f1];
    
    //品牌==================
    UIView *v2=[UIView new];
    v2.frame=CGRectMake(0, 51, Screen_Width, 51);
    [contentView addSubview:v2];
    UILabel *lblPinPai=[UILabel new];
    lblPinPai.frame=CGRectMake(20, 16, 100, 25);
    lblPinPai.text=@"品      牌：";
    [v2 addSubview:lblPinPai];
    _btnPinPai=[UIButton buttonWithType:UIButtonTypeCustom];
    // _btnKunQu.frame=CGRectMake(105, 16, 200, 25);
    _btnPinPai.frame=CGRectMake(105, 16, 90, 25);
    [_btnPinPai setTitle:@"请选择品牌" forState:UIControlStateNormal];
    [_btnPinPai setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
     [_btnPinPai addTarget:self action:@selector(showPinPaiSelect) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:_btnPinPai];
    //清除按钮
    UIButton *btnClearPinPai=[UIButton buttonWithType:UIButtonTypeCustom];
    btnClearPinPai.frame=CGRectMake(Screen_Width-50, 18, 22, 22);
    [btnClearPinPai setBackgroundImage:[UIImage imageNamed:@"ClearData"] forState:UIControlStateNormal];
    btnClearPinPai.tag=1002;
    [btnClearPinPai addTarget:self action:@selector(clearData:) forControlEvents:UIControlEventTouchUpInside];
    [v2 addSubview:btnClearPinPai];

    //分割线
    UIImageView *f2=[UIImageView new];
    f2.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f2.image=[UIImage imageNamed:@"fengexian"];
    [v2 addSubview:f2];
    
    //商品编号==================
    UIView *v3=[UIView new];
    v3.frame=CGRectMake(0, 51*2, Screen_Width, 51);
    [contentView addSubview:v3];
    UILabel *lblShangBian=[UILabel new];
    lblShangBian.frame=CGRectMake(20, 16, 100, 25);
    lblShangBian.text=@"商品编码：";
    [v3 addSubview:lblShangBian];
    _txtShangBian=[UITextField new];
    _txtShangBian.frame=CGRectMake(105, 16, 200, 25);
    _txtShangBian.placeholder=@"";
    [v3 addSubview:_txtShangBian];
    //分割线
    UIImageView *f3=[UIImageView new];
    f3.frame=CGRectMake(20, 50, Screen_Width-20, 1);
    f3.image=[UIImage imageNamed:@"fengexian"];
    [v3 addSubview:f3];
    
    //唯一编码==================
    UIView *v4=[UIView new];
    v4.frame=CGRectMake(0, 51*3, Screen_Width, 51);
    [contentView addSubview:v4];
    UILabel *lblWeiBian=[UILabel new];
    lblWeiBian.frame=CGRectMake(20, 16, 100, 25);
    lblWeiBian.text=@"唯一编码：";
    [v4 addSubview:lblWeiBian];
    _txtWeiBian=[UITextField new];
    _txtWeiBian.frame=CGRectMake(105, 16, 200, 25);
    _txtWeiBian.placeholder=@"";
    [v4 addSubview:_txtWeiBian];
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
    
   // _pickBG=[UIView new];
   // _pickBG.userInteractionEnabled=YES;
     // _picker=[[UIPickerView alloc] init];
   // _picker.frame=CGRectMake(0, Screen_Height2-_picker.bounds.size.height, _picker.bounds.size.width, _picker.bounds.size.height);
   // [scroll addSubview:_picker];
  
   // _picker.frame=CGRectMake(0, 0, _picker.bounds.size.width, _picker.bounds.size.height);
  //  _picker.backgroundColor=[UIColor grayColor];
   // [_pickBG addSubview: _picker];
    //_picker.hidden=YES;
    //[Appdelegate.window addSubview:_picker];
    
}


-(void)GOSearch
{
    /*if([NSString stringWithFormat:@"%@",_KuQuHiddenStr ].length==0)
    {
        [self showAlertViewText:@"请选择库区"];
        return;
    }
    if([NSString stringWithFormat:@"%@",_PinPaiHiddenStr ].length==0)
    {
        [self showAlertViewText:@"请选择品牌"];
        return;
    }*/

    
    
    self.hidesBottomBarWhenPushed=YES;
    StockDetailList *detailList=[[StockDetailList alloc] init];
    [self.navigationController pushViewController:detailList animated:YES];
    detailList.GoodsCodestr=_txtShangBian.text;
    detailList.OnlyCodestr=_txtWeiBian.text;
    detailList.WarehouseIDstr=_KuQuHiddenStr;
    detailList.BrandIDstr=_PinPaiHiddenStr;
      self.hidesBottomBarWhenPushed=NO;
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [_pickerArray count];
}
-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [_pickerArray objectAtIndex:row];
}
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    [_btnKunQu setTitle:_pickerArray[row] forState:UIControlStateNormal];
}

-(void)hideKey
{   //_picker.hidden=YES;
    [self.view  endEditing:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
