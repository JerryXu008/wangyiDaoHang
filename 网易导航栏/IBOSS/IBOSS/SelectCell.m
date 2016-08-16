//
//  SelectCell.m
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "SelectCell.h"

@implementation SelectCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)layoutSubviews
{
   // [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    self.lblContent.textColor=[UIColor grayColor];
     _lblTitle.font = [UIFont fontWithName:@"Helvetica" size:13];
    _lblContent.font = [UIFont fontWithName:@"Helvetica" size:13];

self.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}

@end
