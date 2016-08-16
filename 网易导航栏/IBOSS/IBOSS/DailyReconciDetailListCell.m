//
//  DailyReconciDetailListCell.m
//  IBOSS
//
//  Created by iHope on 14-7-11.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "DailyReconciDetailListCell.h"
@interface DailyReconciDetailListCell()


@end
@implementation DailyReconciDetailListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
       
        [self InitView];
        self.backgroundView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)InitView
{
    UILabel *lblOr=[UILabel new];
    lblOr.frame=CGRectMake(10, 20, 100, 20);
    lblOr.text=@"部门名称：";
    [self.contentView addSubview:lblOr];
    _lblOrganizeName=[UILabel new];
    _lblOrganizeName.frame=CGRectMake(110, 20, 200, 20);
    _lblOrganizeName.textColor=[UIColor grayColor];
    [self.contentView addSubview:_lblOrganizeName];
    //分割线
    UIImageView *fengeView=[[UIImageView alloc]init];
    fengeView.image=[UIImage imageNamed:@"fengexian"];
    fengeView.frame=CGRectMake(10, 50, Screen_Width-10, 1);
   // [self.contentView addSubview:fengeView];
    //收款额
    UILabel *lblFullOr=[UILabel new];
    lblFullOr.frame=CGRectMake(10, 50, 100, 20);
    lblFullOr.text=@"收款额：";
    [self.contentView addSubview:lblFullOr];
    
    _lblShouKuan=[UILabel new];
    _lblShouKuan.frame=CGRectMake(110, 50, 200, 20);
    _lblShouKuan.textColor=[UIColor grayColor];
     [self.contentView addSubview: _lblShouKuan];
    //使用定金
    UILabel *lblDingjin=[UILabel new];
    lblDingjin.frame=CGRectMake(10, 80, 100, 20);
    lblDingjin.text=@"使用定金：";
    [self.contentView addSubview:lblDingjin];
    
    _lblDingJin=[UILabel new];
    _lblDingJin.frame=CGRectMake(110, 80, 200, 20);
    _lblDingJin.textColor=[UIColor grayColor];
    [self.contentView addSubview: _lblDingJin];
  
    //使用预存
    UILabel *lblYuCun=[UILabel new];
    lblYuCun.frame=CGRectMake(10, 110, 100, 20);
    lblYuCun.text=@"使用预存：";
    [self.contentView addSubview:lblYuCun];
    _lblYuCun=[UILabel new];
    _lblYuCun.frame=CGRectMake(110, 110, 200, 20);
    _lblYuCun.textColor=[UIColor grayColor];
    [self.contentView addSubview: _lblYuCun];

    //销售贷款总额
    UILabel *lbltotal=[UILabel new];
    lbltotal.frame=CGRectMake(10, 140, 100, 20);
    lbltotal.text=@"贷款总额：";
    [self.contentView addSubview:lbltotal];
    _lblTotalAmount=[UILabel new];
    _lblTotalAmount.frame=CGRectMake(110, 140, 200, 20);
    _lblTotalAmount.textColor=[UIColor grayColor];
    [self.contentView addSubview: _lblTotalAmount];
    //阴影
    UIImageView *fengeView2=[[UIImageView alloc]init];
    fengeView2.image=[UIImage imageNamed:@"fengexian"];
    fengeView2.frame=CGRectMake(0, 161, Screen_Width, 10);
    [self.contentView addSubview:fengeView2];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
    
    if(selected)
        [self setSelectionStyle:UITableViewCellSelectionStyleBlue];
    else
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
}
- (void) layoutSubviews {
    [super layoutSubviews]; // layouts the cell as UITableViewCellStyleValue2 would normally look like
    
    
}


@end
