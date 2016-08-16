//
//  TextCell.m
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "TextCell.h"


@implementation TextCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)setTxtPlace:(NSString *)txtPlace
{
    _txtPlace=txtPlace;
    self.txtContent.placeholder=txtPlace;

}
-(void)layoutSubviews
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    _txtContent.borderStyle=UITextBorderStyleNone;
    //_lblTitle.font=[UIFont fontWithName:@"Arial-BoldItalicMT" size:14];
   // _lblTitle.textColor=[UIColor colorWithRed:146/255.0 green:146/255.0 blue:146/255.0 alpha:1.0];
    _lblTitle.font = [UIFont fontWithName:@"Helvetica" size:13];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
