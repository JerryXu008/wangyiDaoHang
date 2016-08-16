//
//  SearchOtherCell.m
//  IBOSS
//
//  Created by iHope on 14-6-17.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "SearchOtherCell.h"

@implementation SearchOtherCell

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
    [super layoutSubviews];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
  //  self.txtName.borderStyle=UITextBorderStyleNone;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
