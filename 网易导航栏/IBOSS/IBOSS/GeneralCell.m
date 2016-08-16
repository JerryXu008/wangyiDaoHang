//
//  GeneralCell.m
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "GeneralCell.h"

@implementation GeneralCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        UIButton *btnArrow=[UIButton buttonWithType:UIButtonTypeCustom];
        btnArrow.frame=CGRectMake(Screen_Width-30, 23.5, 8, 13);
        [btnArrow setBackgroundImage:[UIImage imageNamed:@"jintou1"] forState:UIControlStateNormal];
        [self.contentView addSubview:btnArrow];
        self.backgroundColor=[UIColor whiteColor];
        self.backgroundView.backgroundColor=[UIColor whiteColor];
    }
    return self;
}
-(void)setType:(int)type
{
  if(type==1)
  {
      self.imageView.image=[UIImage imageNamed:@"xianchangguanli"];
      self.textLabel.text=@"现场管理";
  }
   if(type==3)
    {
        self.imageView.image=[UIImage imageNamed:@"rizhiguanli"];
        self.textLabel.text=@"日志管理";
    }
    if(type==7)
    {
        self.imageView.image=[UIImage imageNamed:@"gerenshezhi"];
        self.textLabel.text=@"设置";
        self.imageView.size=CGSizeMake(34, 37);
    }


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
