//
//  SeprateCell.m
//  IBOSS
//
//  Created by iHope on 14-6-16.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "SeprateCell.h"
@interface SeprateCell()
@property(nonatomic,strong) UIImageView *imageView;

@end
@implementation SeprateCell
@synthesize imageView=_imageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _imageView=[[UIImageView alloc] init];
        _imageView.frame=CGRectMake(0, 0, 320, SeprateCellHeight);
        _imageView.image=[UIImage imageNamed:@"fengexian.png"];
        [self addSubview:_imageView];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
