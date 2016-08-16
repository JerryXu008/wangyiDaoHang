//
//  FollowUpCellCalculation.m
//  IBOSS
//
//  Created by iHope on 14-6-20.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "FollowUpCellCalculation.h"
#import "FollowUpInfoModel.h"
#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH  280
@implementation FollowUpCellCalculation

+ (CGFloat) getViewHeight:(FollowUpInfoModel *)followModel{

    float h = 0;
    h+=15;//顶部阴影
    NSString *textContent=followModel.title;
    
    UIView *contentView = [self assembleMessageViewWithMessage:textContent];
    //contentView.frame = CGRectMake(10, 0, contentView.width, contentView.height);
    h+=(17-15);//标题view和顶部阴影的间距
    h+=contentView.height;//标题内容长度
    h+=5;//相片和标题view的间距
    float imgwidth=followModel.imgView.size.width;
    float imgheight=followModel.imgView.size.height;
    CGFloat biLi = imgheight/imgwidth;
    float imgWidth=80;
    float imgHeight = biLi* imgWidth;
    h+=imgHeight;//加上照片的高度
    h+=5;//录音与照片的间距
    h+=25;//录音的高度
    h+=10;//分割线与录音的高度间距
    h+=1;//分割线高度
    h+=10;//位置与分割线的间距
    h+=20;//位置的高度
    
    h+=10;//在增加这些高度
    
    return h;
    
   


}
// 分割字符串
+ (void)getImageRangeWithMessage:(NSString *)contentString andArray:(NSMutableArray *)array{
    
    NSString *matchStr = @"smile[0-9]{3}";  //字符串名称
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *moodArray = nil;
    
    moodArray = [regex matchesInString:contentString options:NSMatchingReportProgress range:NSMakeRange(0,[contentString length])];
    
    NSString *imageName = nil;
    NSString *beforeString = nil;
    NSString *aferString = nil;
    
    if (moodArray.count > 0) {
        NSTextCheckingResult *b = [moodArray objectAtIndex:0];
        beforeString = [contentString substringToIndex:b.range.location];
        imageName = [contentString substringWithRange:b.range];
        //
        //        NSLog(@"imageName = %@",imageName);
        
        aferString = [contentString substringFromIndex:b.range.location + b.range.length];
        
        if (beforeString != nil && ![@"" isEqualToString:beforeString]) {
            [array addObject:beforeString];
        }
        [array addObject:imageName];
        [self getImageRangeWithMessage:aferString andArray:array];
    }else{
        if (contentString != nil && ![@"" isEqualToString:contentString]) {
            [array addObject:contentString];
        }
        
    }
}

+(UIView *)assembleMessageViewWithMessage: (NSString *) message{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self getImageRangeWithMessage:message andArray:array];
    
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSArray *dataArray = array;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    //坐标，
    CGFloat itemX = 0;     //图片坐标x
    CGFloat itemY = 0;
    CGFloat ViewWidth = 0;  //要生成的视图width
    CGFloat ViewHeight = 18;
    
    if (dataArray) {
        
        for (int i = 0 ; i < dataArray.count ; i++) {
            
            NSString *str = [dataArray objectAtIndex:i];
            
            NSString *matchStr = @"smile[0-9]{3}";  //字符串名称
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchStr options:NSRegularExpressionCaseInsensitive error:nil];
            
            NSArray *moodArray = nil;
            
            moodArray = [regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0,[str length])];
            
            
            //如果是表情图片
            if (moodArray.count > 0) {
                
                if (itemX >= (isPad?728:280))
                {
                    itemY = itemY + KFacialSizeHeight;
                    itemX = 0;
                    ViewWidth = isPad?728:280;
                    ViewHeight = itemY +KFacialSizeHeight;
                }
                
                NSString *imageName = str;
                
                //                NSLog(@"imageName = %@",imageName);
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                
                imageView.frame = CGRectMake(itemX, itemY, KFacialSizeWidth, KFacialSizeHeight);
                
                [returnView addSubview:imageView];
                // [imageView release];
                
                itemX = KFacialSizeWidth+itemX; //这个
                
                if (ViewWidth < (isPad?728:280)) {
                    ViewWidth = itemX;
                }
                
            }else{
                //普通字符串,一个字一个字的贴
                for (int j = 0; j < [str length]; j++) {
                    
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    
                    if (itemX >=SCREENWIDTH -40)
                    {
                        itemY = itemY + KFacialSizeHeight;
                        itemX = 0;
                        ViewWidth = SCREENWIDTH-40;
                        ViewHeight = itemY +KFacialSizeHeight;
                    }
                    
                    CGSize size = [temp sizeWithFont:font constrainedToSize:CGSizeMake( isPad? 728:280, 40)];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(itemX,itemY,size.width,size.height)];
                    label.font = font;
                    label.text = temp;
                    label.textColor = FONTCOLOR;
                    label.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:label];
                    // [label release];
                    itemX = itemX + size.width;
                    //                    NSLog(@"%f",itemX);
                    
                    if (ViewWidth < SCREENWIDTH-40)
                    {
                        ViewWidth = itemX;
                    }
                }
            }
        }
    }
    
    returnView.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
    
   
    return returnView;
}





-(BOOL)assembleMessageViewWithMessage: (NSString *) message{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self getImageRangeWithMessage:message andArray:array];
    
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSArray *dataArray = array;
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    //坐标，
    CGFloat itemX = 0;     //图片坐标x
    CGFloat itemY = 0;
    CGFloat ViewWidth = 0;  //要生成的视图width
    CGFloat ViewHeight = 18;
    
    if (dataArray) {
        
        for (int i = 0 ; i < dataArray.count ; i++) {
            
            NSString *str = [dataArray objectAtIndex:i];
            
            NSString *matchStr = @"smile[0-9]{3}";  //字符串名称
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchStr options:NSRegularExpressionCaseInsensitive error:nil];
            
            NSArray *moodArray = nil;
            
            moodArray = [regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0,[str length])];
            
            
            //如果是表情图片
            if (moodArray.count > 0) {
                
                if (itemX >= (isPad?728:280))
                {
                    itemY = itemY + KFacialSizeHeight;
                    itemX = 0;
                    ViewWidth = isPad?728:280;
                    ViewHeight = itemY +KFacialSizeHeight;
                }
                
                NSString *imageName = str;
                
                //                NSLog(@"imageName = %@",imageName);
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                
                imageView.frame = CGRectMake(itemX, itemY, KFacialSizeWidth, KFacialSizeHeight);
                
                [returnView addSubview:imageView];
                // [imageView release];
                
                itemX = KFacialSizeWidth+itemX; //这个
                
                if (ViewWidth < (isPad?728:280)) {
                    ViewWidth = itemX;
                }
                
            }else{
                //普通字符串,一个字一个字的贴
                for (int j = 0; j < [str length]; j++) {
                    
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    
                    if (itemX >=SCREENWIDTH -40)
                    {
                        itemY = itemY + KFacialSizeHeight;
                        itemX = 0;
                        ViewWidth = SCREENWIDTH-40;
                        ViewHeight = itemY +KFacialSizeHeight;
                    }
                    
                    CGSize size = [temp sizeWithFont:font constrainedToSize:CGSizeMake( isPad? 728:280, 40)];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(itemX,itemY,size.width,size.height)];
                    label.font = font;
                    label.text = temp;
                    label.textColor = FONTCOLOR;
                    label.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:label];
                    // [label release];
                    itemX = itemX + size.width;
                    //                    NSLog(@"%f",itemX);
                    
                    if (ViewWidth < SCREENWIDTH-40)
                    {
                        ViewWidth = itemX;
                    }
                }
            }
        }
    }
   
   // UIView *returnView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
   // returnView.backgroundColor=[UIColor redColor];
    returnView.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
   // UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    //lbl.text=message;
   // [returnView addSubview:lbl];
    self.FinalView=returnView;
    return YES;
   // return returnView;
}
# pragma mark -
# pragma mark - 图文混排
// 分割字符串
- (void)getImageRangeWithMessage:(NSString *)contentString andArray:(NSMutableArray *)array{
    
    NSString *matchStr = @"smile[0-9]{3}";  //字符串名称
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchStr options:NSRegularExpressionCaseInsensitive error:nil];
    
    NSArray *moodArray = nil;
    
    moodArray = [regex matchesInString:contentString options:NSMatchingReportProgress range:NSMakeRange(0,[contentString length])];
    
    NSString *imageName = nil;
    NSString *beforeString = nil;
    NSString *aferString = nil;
    
    if (moodArray.count > 0) {
        NSTextCheckingResult *b = [moodArray objectAtIndex:0];
        beforeString = [contentString substringToIndex:b.range.location];
        imageName = [contentString substringWithRange:b.range];
        
        //        NSLog(@"imageName = %@",imageName);
        
        aferString = [contentString substringFromIndex:b.range.location + b.range.length];
        
        if (beforeString != nil && ![@"" isEqualToString:beforeString]) {
            [array addObject:beforeString];
        }
        [array addObject:imageName];
        [self getImageRangeWithMessage:aferString andArray:array];
    }else{
        if (contentString != nil && ![@"" isEqualToString:contentString]) {
            [array addObject:contentString];
        }
        
    }
}

@end
