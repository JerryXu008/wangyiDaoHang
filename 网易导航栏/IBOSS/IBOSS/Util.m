//
//  Util.m
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "Util.h"

@implementation Util
+(void)alignLabelWithTop:(UILabel *)label{
    CGSize maxSize = CGSizeMake(label.frame.size.width, 999);
    label.adjustsFontSizeToFitWidth = NO;
    CGSize actualSize = [label.text sizeWithFont:label.font constrainedToSize:maxSize lineBreakMode:label.lineBreakMode];
    CGRect rect = label.frame;
    rect.size.height = actualSize.height;
    label.frame = rect;
    
}

@end
