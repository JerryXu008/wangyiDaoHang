//
//  StockDetailListCell.m
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "StockDetailListCell.h"

@implementation StockDetailListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.moreText = [[UILabel alloc] init];
        [self.moreText setFrame:CGRectMake(0.0, 0.0, 100.0, 10.0)];
        self.moreText.backgroundColor=[UIColor colorWithRed:76/255.0 green:76/255.0 blue:76/255.0 alpha:1.0];
        [self.contentView addSubview:self.moreText];
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        
        self.backgroundView.backgroundColor=[UIColor whiteColor];
    }
    return self;
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
    
    
    [self setClipsToBounds:YES];
    self.moreText.font = [UIFont systemFontOfSize:16.0];
    self.moreText.backgroundColor = [UIColor clearColor];
    
    [self recalculateView];
    
}
-(void) recalculateView
{
    
    self.detailTextLabel.textAlignment = UIControlContentHorizontalAlignmentLeft;
    CGSize expectedLabelSize = [self.detailTextLabel.text sizeWithFont:self.detailTextLabel.font
                                                     constrainedToSize:CGSizeMake(296,9999)
                                                         lineBreakMode:self.detailTextLabel.lineBreakMode];
    
    [self.detailTextLabel setFrame:CGRectMake(7, 5, expectedLabelSize.width, expectedLabelSize.height)];
    expectedLabelSize = [self.textLabel.text sizeWithFont:self.textLabel.font
                                        constrainedToSize:CGSizeMake(296,9999)
                                            lineBreakMode:self.textLabel.lineBreakMode];
    
    self.textLabel.font = [UIFont systemFontOfSize:14];
    [self.textLabel setFrame:CGRectMake(self.textLabel.frame.origin.x, self.detailTextLabel.frame.origin.y + self.detailTextLabel.frame.size.height + 5, expectedLabelSize.width, expectedLabelSize.height)];
    
    expectedLabelSize = [self.moreText.text sizeWithFont:self.moreText.font
                                       constrainedToSize:CGSizeMake(296,9999)
                                           lineBreakMode:self.moreText.lineBreakMode];
    
    [self.moreText setFrame:CGRectMake(self.textLabel.frame.origin.x+25, self.textLabel.frame.origin.y + self.textLabel.frame.size.height+5, 200, expectedLabelSize.height)];
    
    
}

-(void)InitView
{
   /* UILabel *lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 20, 100, 20);
     lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"商品编码：";
    [self.contentView addSubview:lblShow];
   
    _lblShangPinBianMa=[UILabel new];
    _lblShangPinBianMa.frame=CGRectMake(100, 20, 200, 20);
    _lblShangPinBianMa.text=@"1008";
    _lblShangPinBianMa.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblShangPinBianMa];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 45, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"唯一编码：";
    [self.contentView addSubview:lblShow];
    
    _lblWeiYiBianMa=[UILabel new];
    _lblWeiYiBianMa.frame=CGRectMake(100, 45, 200, 20);
    _lblWeiYiBianMa.text=@"1012648";
    _lblWeiYiBianMa.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblWeiYiBianMa];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 70, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"规       格：";
    [self.contentView addSubview:lblShow];
    
    _lblGuiGe=[UILabel new];
    _lblGuiGe.frame=CGRectMake(100, 70, 200, 20);
    _lblGuiGe.text=@"1000*600";
    _lblGuiGe.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblGuiGe];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 95, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"库       区：";
    [self.contentView addSubview:lblShow];
    _lblKuQu=[UILabel new];
   _lblKuQu.frame=CGRectMake(100, 95, 200, 20);
    _lblKuQu.text=@"北京库区";
    _lblKuQu.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblKuQu];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 120, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"品       牌：";
    [self.contentView addSubview:lblShow];
    _lblPinPai=[UILabel new];
    _lblPinPai.frame=CGRectMake(100, 120, 200, 20);
    _lblPinPai.text=@"阿迪达斯";
    _lblPinPai.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblPinPai];
   
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 145, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"结  存  量：";
    [self.contentView addSubview:lblShow];
    _lblJieCunLiang=[UILabel new];
    _lblJieCunLiang.frame=CGRectMake(100, 145, 200, 20);
    _lblJieCunLiang.text=@"15可售量";
    _lblJieCunLiang.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblJieCunLiang];
    
    lblShow=[UILabel new];
    lblShow.frame=CGRectMake(10, 170, 100, 20);
    lblShow.textColor=[UIColor blackColor];
    lblShow.text=@"可  售  量：";
    [self.contentView addSubview:lblShow];
    _lblKeShouLiang=[UILabel new];
    _lblKeShouLiang.frame=CGRectMake(100, 170, 200, 20);
    _lblKeShouLiang.text=@"-244";
    _lblKeShouLiang.textColor=[UIColor colorWithRed:165/255.0 green:165/255.0 blue:165/255.0 alpha:1.0];
    [self.contentView addSubview:_lblKeShouLiang];
*/
    
    
}

@end
