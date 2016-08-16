//
//  CustomerWayCategoryCell.m
//  IBOSS
//
//  Created by iHope on 14-6-17.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerWayCategoryCell.h"

@implementation CustomerWayCategoryCell
@synthesize leftView=_leftView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        if(_leftView==nil)
        {
            _leftView=[[UIImageView alloc]init];
            _leftView.frame=CGRectMake(0, 0, 5, 58);
            _leftView.backgroundColor=NavBarItemColor;
            [self.contentView addSubview:_leftView];
        
        }
        _leftView.hidden=YES;
        _IsSelected=NO;
        
    }
    return self;
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
