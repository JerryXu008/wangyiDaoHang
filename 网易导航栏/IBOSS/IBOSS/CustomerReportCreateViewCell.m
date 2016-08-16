//
//  CustomerReportCreateViewCell.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerReportCreateViewCell.h"

@implementation CustomerReportCreateViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self loadView];
    }
    return self;
}
-(void)loadView
{
    if(self.lblTitle==nil){
    self.lblTitle=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
        self.lblTitle.backgroundColor=[UIColor redColor];
        [self.contentView addSubview:self.lblTitle];
    }
    if(self.viewContent==nil){
    self.viewContent=[[UIView alloc] initWithFrame:CGRectMake(80, 10, 2150, 30)];
    self.viewContent.backgroundColor=[UIColor greenColor];
        [self.contentView addSubview:self.viewContent];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
