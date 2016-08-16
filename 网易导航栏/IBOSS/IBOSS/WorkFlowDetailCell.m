//
//  WorkFlowDetailCell.m
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "WorkFlowDetailCell.h"

@implementation WorkFlowDetailCell

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
@end
