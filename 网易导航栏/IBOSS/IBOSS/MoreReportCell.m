//
//  MoreReportCell.m
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "MoreReportCell.h"
#import "StockDetailVC.h"
@interface MoreReportCell()
@property(strong) UIButton * btnArrow;
@property(strong) UIView *subView;
@end
@implementation MoreReportCell
@synthesize subView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self initUI];
    }
    return self;
}
-(void)initUI
{
   
        UIControl *control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0,Screen_Width, 50)];
        [control addTarget:self action:@selector(headerClick1:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:control];
    

    UIImageView *iconView=[[UIImageView alloc] init];
    iconView.frame=CGRectMake(15, 15, 18, 17);
    iconView.image=[UIImage imageNamed:@"baobiaoxitong"];
    [self.contentView addSubview:iconView];
    UILabel *lblTitle=[[UILabel alloc] init];
    lblTitle.frame=CGRectMake(50, 15, 100, 18);
    lblTitle.text=@"报表系统";
    lblTitle.font = [UIFont fontWithName:@"Helvetica" size:18];
    [self.contentView addSubview:lblTitle];
    _btnArrow=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnArrow.frame=CGRectMake(Screen_Width-30, 20, 8, 13);
    [_btnArrow setBackgroundImage:[UIImage imageNamed:@"jintou1"] forState:UIControlStateNormal];
    [_btnArrow addTarget:self action:@selector(headerClick1:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:_btnArrow];

    
    //分割线
    UIImageView *fengeView=[[UIImageView alloc] init];
    fengeView.frame=CGRectMake(0, 50, Screen_Width, 1);
    fengeView.image=[UIImage imageNamed:@"fengexian"];
    [self.contentView addSubview:fengeView];
    //子view
    subView=[[UIView alloc]init];
    subView.frame=CGRectMake(0, 51, Screen_Width, 122);
   // subView.backgroundColor=[UIColor redColor];
    [self.contentView addSubview:subView];
    //日结对账
    UIButton *btnRiJie=[UIButton buttonWithType:UIButtonTypeCustom];
    btnRiJie.frame=CGRectMake(0, 0, Screen_Width, 60);
    //[btnRiJie setTitle:@"日结对账表" forState:UIControlStateNormal];
    [btnRiJie addTarget:self action:@selector(GoRiJie) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lblrijie=[[UILabel alloc]init];
    lblrijie.frame=CGRectMake(50, 21, Screen_Width, 18);
    lblrijie.text=@"日结对账表";
    [btnRiJie addSubview:lblrijie];
    UIButton *btnArrow2=[UIButton buttonWithType:UIButtonTypeCustom];
    btnArrow2.frame=CGRectMake(Screen_Width-30, 23.5, 8, 13);
    [btnArrow2 setBackgroundImage:[UIImage imageNamed:@"jintou1"] forState:UIControlStateNormal];
    [btnRiJie addSubview:btnArrow2];
    [subView addSubview:btnRiJie];
    //分割线
    UIImageView *fengeView2=[[UIImageView alloc] init];
    fengeView2.frame=CGRectMake(20, 61, Screen_Width, 1);
    fengeView2.image=[UIImage imageNamed:@"fengexian"];
    [subView addSubview:fengeView2];
    //库存明细
    UIButton *btnKuCun=[UIButton buttonWithType:UIButtonTypeCustom];
    btnKuCun.frame=CGRectMake(0, 61, Screen_Width, 60);
    UILabel *lblucun=[[UILabel alloc]init];
    lblucun.frame=CGRectMake(50, 21, Screen_Width, 18);
    lblucun.text=@"库存明细表";
    [btnKuCun addSubview:lblucun];
    [btnKuCun addTarget:self action:@selector(GoKuCun) forControlEvents:UIControlEventTouchUpInside];
    UIButton *btnArrow3=[UIButton buttonWithType:UIButtonTypeCustom];
    btnArrow3.frame=CGRectMake(Screen_Width-30, 23.5, 8, 13);
    [btnArrow3 setBackgroundImage:[UIImage imageNamed:@"jintou1"] forState:UIControlStateNormal];
    [btnKuCun addSubview:btnArrow3];
    [subView addSubview:btnKuCun];
    UIImageView *fengeView3=[[UIImageView alloc] init];
    fengeView3.frame=CGRectMake(0, 120, Screen_Width, 1);
    fengeView3.image=[UIImage imageNamed:@"fengexian"];
    [subView addSubview:fengeView3];

    
    
}
-(void)GoRiJie
{
    if([self.delegate respondsToSelector:@selector(gorijie)])
    {
        [self.delegate performSelector:@selector(gorijie) withObject:nil afterDelay:0.0];
    }

}
-(void)GoKuCun
{
   if([self.delegate respondsToSelector:@selector(gokucun)])
   {
       [self.delegate performSelector:@selector(gokucun) withObject:nil afterDelay:0.0];
   }
}
-(void)headerClick1:(id)sender{
    [self rotateArrowImage];
    if([self.delegate respondsToSelector:@selector(refreshTableView)])
    {
        [self.delegate performSelector:@selector(refreshTableView) withObject:nil afterDelay:0.0 ];
    }
}


-(void)rotateArrowImage{
    //如果已经展开,收缩
    if([_isOpen isEqualToString:@"1"]){
        [UIView animateWithDuration:0.2 animations:^{
            self.btnArrow.transform = CGAffineTransformMakeRotation(0 / 180.0 * M_PI );
        }];
        _isOpen = @"0";
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.btnArrow.transform = CGAffineTransformMakeRotation(90 / 180.0 * M_PI );
        }];
        _isOpen = @"1";
    }
}
-(void)setIsOpen:(NSString *)aIsOpen{
    _isOpen = aIsOpen;
    if([_isOpen isEqualToString:@"1"]){
        self.btnArrow.transform = CGAffineTransformMakeRotation(90 / 180.0 * M_PI );
    }
    else
    {
    
    }
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
