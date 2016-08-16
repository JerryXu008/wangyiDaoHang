//
//  GeneralSettingCell.m
//  IBOSS
//
//  Created by iHope on 14-7-11.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "GeneralSettingCell.h"

@implementation GeneralSettingCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIButton *btnArrow=[UIButton buttonWithType:UIButtonTypeCustom];
        btnArrow.frame=CGRectMake(Screen_Width-30, 23.5, 8, 13);
        [btnArrow setBackgroundImage:[UIImage imageNamed:@"jintou1"] forState:UIControlStateNormal];
        [self.contentView addSubview:btnArrow];
    }
    return self;
}
-(void)setType:(int)type
{
    if(type==1)
    {
        
        self.textLabel.text=@"切换用户";
    }
    if(type==3)
    {
        
        self.textLabel.text=@"版本信息";
    }
    if(type==5)
    {
      
        self.textLabel.text=@"退出登录";
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
