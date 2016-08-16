//
//  CustomerManaView.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerManaView.h"
@interface CustomerManaView(){

}
@property(nonatomic,strong) UIButton *btnCustomerWay;
@property(nonatomic,strong) UIButton *btnDate;
@property(nonatomic) BOOL isDistanceShow;
//下拉菜单 客户渠道
@property(nonatomic)  BOOL  isWayShow;
@property(nonatomic,strong) UIView* WayView;
@property(nonatomic,strong) UIView* WayAlphaView;
@property(nonatomic,strong) UITableView* wayTableview;
//下拉菜单 时间
@property(nonatomic) BOOL isDateShow;


@property(nonatomic,strong) UIView* DateView;
@property(nonatomic,strong) UIView* DateAlphaView;
@property(nonatomic,strong) UIDatePicker *datePicker;

@property(nonatomic,strong) UIView* mainBackGroundView;
@end
@implementation CustomerManaView
@synthesize btnCustomerWay=_btnCustomerWay,btnDate=_btnDate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor=[UIColor whiteColor];
        
        
        
        //[self loadSearchMenu];
    }
    return self;
}
-(id)init
{
    self =[super init];
    if(self){
    
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.searchBar.placeholder=@"客户名称";
    
    CGRect frame=[self.searchBar superview].frame;
    NSLog(@"x=%f,y=%f,width=%f,height=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    frame=CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, self.menuView.frame.size.width, self.menuView.frame.size.height);
    self.menuView.frame=frame;
    self.menuView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
    // self.menuView.backgroundColor=[erjidaohang_bj@2x];
    // [self.menuView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"erjidaohang_bj.png"]]];
    [self loadSearchMenu];
    [self LoadDropMenu];
    [self loadCustomerWayTable];
    [self loadDatePicker];

}
-(id)initWithCoder:(NSCoder *)coder{
    
   return  [super initWithCoder:coder];
}

-(void)loadCustomerWayTable
{
    _wayTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 320, self.mainBackGroundView.frame.size.height-49) style:UITableViewStylePlain];
    _wayTableview.delegate = self;
    _wayTableview.dataSource = self;
   // _wayTableview.separatorStyle = UITableViewCellSeparatorStyleNone;

}
-(void)loadDatePicker
{
    _datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, 320, 162)];
    _datePicker.datePickerMode=UIDatePickerModeDate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy MM dd"];
   // timefield.text  =[formatter stringFromDate:datePicker.date];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    /*self.searchBar.placeholder=@"客户名称";
    
    CGRect frame=[self.searchBar superview].frame;
    NSLog(@"x=%f,y=%f,width=%f,height=%f",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
    frame=CGRectMake(frame.origin.x, frame.origin.y+frame.size.height, self.menuView.frame.size.width, self.menuView.frame.size.height);
    self.menuView.frame=frame;
    self.menuView.backgroundColor=[UIColor colorWithRed:239.0/255.0 green:239.0/255.0 blue:239.0/255.0 alpha:1.0];
   // self.menuView.backgroundColor=[erjidaohang_bj@2x];
   // [self.menuView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"erjidaohang_bj.png"]]];
    [self loadSearchMenu];
    [self LoadDropMenu];
  //  [self loadXiaLaView];
    //self.searchBar.hidden=YES;
    */
    
}
//初始化下拉菜单
-(void)LoadDropMenu
{
    //两个搜索按钮下面的视图
    CGRect frame=self.menuView.frame;
    _mainBackGroundView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.origin.y+frame.size.height, Screen_Width, Screen_Height-(frame.origin.y+frame.size.height))];
    _mainBackGroundView.userInteractionEnabled=YES;
    _mainBackGroundView.backgroundColor = [UIColor whiteColor];
   
    _isWayShow = NO;
    //阴影视图
    _WayAlphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, _mainBackGroundView.frame.size.height)];
    [_WayAlphaView setBackgroundColor:[UIColor blackColor]];
    [_WayAlphaView setAlpha:0.f];
   //分类试图
    _WayView = [[UIView alloc]init];
    _WayView.backgroundColor = [[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:1];
    
    _isDateShow=NO;
    _DateAlphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, _mainBackGroundView.frame.size.height)];
    [_DateAlphaView setBackgroundColor:[UIColor blackColor]];
    [_DateAlphaView setAlpha:0.f];
    //[_DateView setFrame:CGRectMake(0, 0, Screen_Width, 200)];
    //分类试图
    _DateView = [[UIView alloc]init];
    _DateView.backgroundColor = [[UIColor alloc]initWithRed:1 green:1 blue:1 alpha:1];



}
//加载搜索菜单按钮
-(void)loadSearchMenu
{
    _btnCustomerWay = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnCustomerWay.frame = CGRectMake(0, 0, Screen_Width/2, 40);
    [_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
    //[_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_select.png"] forState:UIControlStateHighlighted];
   // _btnCustomerWay.backgroundColor=[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];
     [_btnCustomerWay setTitle:@"客户渠道" forState:UIControlStateNormal];
    [_btnCustomerWay setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnCustomerWay addTarget:self action:@selector(pressCustomerWayBtn) forControlEvents:UIControlEventTouchUpInside];
    _btnCustomerWay.titleLabel.font = [UIFont systemFontOfSize:15];

    
    UIImageView* image1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow.png"]];
    image1.frame = CGRectMake(120, (40-6)/2, 12, 6);
    [_btnCustomerWay addSubview:image1];
    [self.menuView addSubview:_btnCustomerWay];
    
    //排序按钮
    _btnDate = [UIButton buttonWithType:UIButtonTypeCustom];
    _btnDate.frame = CGRectMake(Screen_Width/2, 0, Screen_Width/2, 40);
    [_btnDate setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
    //[_btnDate setBackgroundImage:[UIImage imageNamed:@"button_select.png"] forState:UIControlStateHighlighted];
    //_btnDate.backgroundColor=[UIColor colorWithRed:243.0/255.0 green:243.0/255.0 blue:243.0/255.0 alpha:1.0];

    [_btnDate setTitle:@"日期" forState:UIControlStateNormal];
    [_btnDate setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_btnDate addTarget:self action:@selector(pressDateBtn) forControlEvents:UIControlEventTouchUpInside];
    _btnDate.titleLabel.font = [UIFont systemFontOfSize:15];
    
    
     UIImageView* image2  = [[UIImageView alloc]initWithFrame:CGRectMake(115, (40-6)/2, 12, 6)];
    image2.image = [UIImage imageNamed:@"arrow.png"];
    [ _btnDate addSubview:image2];
    [self.menuView addSubview:_btnDate];

}
-(void)pressDateBtn{
    [_btnDate setBackgroundImage:[UIImage imageNamed:@"button_select"] forState:UIControlStateNormal];
    [_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
    if (_isDateShow) {
       // [UIView animateWithDuration:0.1f animations:^{
            _isDateShow = NO;
            [_DateAlphaView setAlpha:0.f];
            
            [_DateView removeFromSuperview];
            [_DateAlphaView removeFromSuperview];
            [_mainBackGroundView removeFromSuperview];
            // [_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
            [_btnDate setBackgroundImage:[UIImage imageNamed:@"button_nomal"] forState:UIControlStateNormal];
       // }];
    }else{
        //[UIView animateWithDuration:0.1f animations:^{
           
            _isWayShow = NO;
            [_WayAlphaView setAlpha:0.f];
            [_WayView removeFromSuperview];
            [_WayAlphaView removeFromSuperview];
            [_mainBackGroundView removeFromSuperview];
            
            
            _isDateShow = YES;
         
            [_DateAlphaView setAlpha:0.5f];
            [_DateView setFrame:CGRectMake(0, 0, Screen_Width, 200)];
            _DateView.backgroundColor=[UIColor colorWithRed:61/255.0 green:169/255.0 blue:223/255.0 alpha:1.0];
            [_DateView addSubview:_datePicker];
            [_mainBackGroundView addSubview:_DateView];
            [_mainBackGroundView addSubview:_DateAlphaView];
            [_mainBackGroundView bringSubviewToFront:_DateView];
               [self addSubview:_mainBackGroundView];
            [_btnDate setBackgroundImage:[UIImage imageNamed:@"button_select"] forState:UIControlStateNormal];
              //     }];
        
    }

}
- (void)pressCustomerWayBtn{
   /* UIActionSheet* mySheet = [[UIActionSheet alloc]
                              initWithTitle:@"渠道"
                              delegate:nil
                              cancelButtonTitle:nil
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"零售",@"批发",@"促销", nil];
    [mySheet showInView:self];*/
    
    [_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_select"] forState:UIControlStateNormal];
    [_btnDate setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];

    
    if (_isWayShow) {
       // [UIView animateWithDuration:0.1f animations:^{
            _isWayShow = NO;
            [_WayAlphaView setAlpha:0.f];
            [_WayView removeFromSuperview];
            [_WayAlphaView removeFromSuperview];
            [_mainBackGroundView removeFromSuperview];
            [_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];

       // }];
    }else{
       // [UIView animateWithDuration:0.1f animations:^{
            /*移除上一个*/
            _isDateShow = NO;
            [_DateAlphaView setAlpha:0.f];
            
            [_DateView removeFromSuperview];
            [_DateAlphaView removeFromSuperview];
            [_mainBackGroundView removeFromSuperview];
            
            
            
            
            
            _isWayShow = YES;
             [self addSubview:_mainBackGroundView];
            [_WayAlphaView setAlpha:0.5f];
            [_WayView setFrame:CGRectMake(0, 0, Screen_Width, _mainBackGroundView.frame.size.height-49)];
            _WayView.backgroundColor=[UIColor redColor];
             [_WayView addSubview:_wayTableview];
                     [_mainBackGroundView addSubview:_WayView];
            //[_sortView addSubview:_sortTableview];
            
            [_mainBackGroundView addSubview:_WayAlphaView];
            [_mainBackGroundView bringSubviewToFront:_WayView];
           [_btnCustomerWay setBackgroundImage:[UIImage imageNamed:@"button_select"] forState:UIControlStateNormal];
            
              //     }];
        
    }

    
    
 }

#pragma mark-
#pragma TableVIew代理
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == _wayTableview) {
        return 44;
    }
    return 0;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == _wayTableview) {
        
        return 5;
    }
       return 0;
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == _wayTableview) {
        UITableViewCell* sortCell = [tableView dequeueReusableCellWithIdentifier:@"sortCell"];
        if (sortCell == nil) {
            sortCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"sortCell"];
                   }
        sortCell.textLabel.text =@"测试";
        return sortCell;
    }
        return nil;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
