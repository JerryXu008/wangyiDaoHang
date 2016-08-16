//
//  FollowUpCellView.m
//  IBOSS
//
//  Created by iHope on 14-6-18.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "FollowUpCellView.h"
#import "RTLabel.h"
#import "FollowUpCellCalculation.h"
@interface FollowUpCellView()
@property (nonatomic, readwrite, strong) dispatch_queue_t queue;

@end
@implementation FollowUpCellView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.view = [[UIView alloc]initWithFrame:frame];
        
              _followModel=[FollowUpInfoModel new];
        [self addSubview:_view];
       // [self addSubview:_contentLabel];
        [self LoadSubView];
        
    }
    return self;
}
-(void)LoadSubView
{
    self.queue = dispatch_queue_create("FollowUpCell", DISPATCH_QUEUE_SERIAL);
    if(_topShadow==nil){
        _topShadow=[[UIImageView alloc] init];
        _topShadow.frame=CGRectMake(0, 0, 320, 15);
        _topShadow.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0] ;
        [self.view  addSubview:_topShadow];
    }
    if(_txtViewTitle==nil){
        _txtViewTitle=[[UIView alloc] init];
        _txtViewTitle.frame = CGRectMake(0, 17, 320, 70);
        _txtViewTitle.backgroundColor=[UIColor clearColor];
       
        [self.view addSubview:_txtViewTitle];
    }
    if(_imageView==nil)
    {
        _imageView=[[UIImageView alloc] init];
        _imageView.frame=CGRectMake(5, 88, 310, 90);
        [self.view addSubview:_imageView];
    }
    if(_messageView==nil)
    {
        //添加自定义按钮
        _messageView = [UIButton buttonWithType:UIButtonTypeCustom];
        _messageView.frame = CGRectMake(5, 185, 100, 25);
        [_messageView addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
        _messageView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        //[_messageView setBackgroundImage:[UIImage imageNamed:@"button_nomal.png"] forState:UIControlStateNormal];
        [_messageView.layer setMasksToBounds:YES];
        [_messageView.layer setCornerRadius:5.0];
        [_messageView.layer setBorderWidth:0.0];
        
        
        
        UIImageView *pinImageView=[[UIImageView alloc] init];
        pinImageView.frame=CGRectMake(5, 5.5, 12.5, 16.5);
        pinImageView.tag=1001;
        //pinImageView.image=[UIImage imageNamed:@"yinpin_icon.png"];
        pinImageView.image=[UIImage imageNamed:@"luyin.png"];
        [_messageView addSubview:pinImageView];
        //  pinImageView.backgroundColor=[UIColor redColor];
        UILabel *lblsecond=[[UILabel alloc]init];
        lblsecond.frame=CGRectMake(45, 5.5, 20, 16.5);
        lblsecond.tag=1002;
        [_messageView addSubview:lblsecond];
         lblsecond.text=@"24";
        lblsecond.font=[UIFont fontWithName:@"Helvetica" size:12];
        [self.view addSubview:_messageView];
      
    }
    if(_seperaView==nil)
    {
        _seperaView=[[UIImageView alloc] init];
        _seperaView.frame=CGRectMake(0, 215, 320, 1);
        _seperaView.image=[UIImage imageNamed:@"fengexian.png"];
        [self.view addSubview:_seperaView];
    }
    if(_locationView==nil)
    {
        _locationView=[[UIView alloc] init];
        _locationView.frame=CGRectMake(5, 223, 100, 20);
        // _locationView.backgroundColor=[UIColor redColor];
        [self.view addSubview:_locationView];
        //小图标
        UIImageView *imageicon=[[UIImageView alloc] init];
        imageicon.frame=CGRectMake(0, 3, 13, 13);
        imageicon.image=[UIImage imageNamed:@"dibiao_icon"];
        [_locationView addSubview:imageicon];
        UILabel *lbllocaiton=[[UILabel alloc]init];
        lbllocaiton.frame=CGRectMake(15, 0, 85, 20);
        lbllocaiton.tag=1003;
        lbllocaiton.font=[UIFont fontWithName:@"Helvetica" size:12];
        lbllocaiton.textColor=[UIColor grayColor];
        [_locationView addSubview:lbllocaiton];
        //lbllocaiton.text=@"东北旺路";
        //lbllocaiton.backgroundColor=[UIColor greenColor];
        
    }
    if(_lblTime==nil){
        _lblTime=[[UILabel alloc] init];
        _lblTime.frame=CGRectMake(320-80-5, 223, 80, 20);
        [self.view addSubview:_lblTime];
        _lblTime.font=[UIFont fontWithName:@"Helvetica" size:12];
        _lblTime.textColor=[UIColor grayColor];
        _lblTime.text=@"05-23 13:20";
        // _lblTime.backgroundColor=[UIColor redColor];
        
    }



}
# pragma mark -
# pragma mark - Method
//tweetyView的视图总高度
+ (CGFloat) getViewHeight:(FollowUpInfoModel *)followModel{
    
   
  return  [FollowUpCellCalculation getViewHeight:followModel];
  /* float h = 0;
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
    
    return 100;
    */
    
}
- (id) blockForTitleView:(NSString *)title
{
  FollowUpCellCalculation *calc=[[FollowUpCellCalculation alloc ]init] ;
  __weak typeof(self) weakSelf = self;
    return ^{
        
        if([calc assembleMessageViewWithMessage:title])
        {
           // dispatch_async(dispatch_get_main_queue(), ^{
             weakSelf.txtViewTitle.height = calc.FinalView.height;
             calc.FinalView.frame = CGRectMake(10, 0, calc.FinalView.width, calc.FinalView.height);
            [weakSelf.txtViewTitle addSubview:calc.FinalView];
            
           
           // });
            
           
        }
        
    };

}
-(void)Draw
{
  /*  NSString *textContent=_followModel.title;
    
    //防止重用
    for (UIView *view in _txtViewTitle.subviews) {
        [view removeFromSuperview];
    }
    UIView *contentView = [self assembleMessageViewWithMessage:textContent];
    _txtViewTitle.height = contentView.height;
    //    _contentView.backgroundColor = [UIColor grayColor];
    contentView.frame = CGRectMake(10, 0, contentView.width, contentView.height);
    
    [_txtViewTitle addSubview:contentView];
    */
  
    NSString *textContent=_followModel.title;
    void (^showTitle)(void)= [self blockForTitleView:textContent];
    showTitle();
    // dispatch_async(self.queue, block);
    
    //图片的位置和高度，以及获取
   // if(_followModel.imgView!=nil)
   // {
    
   // dispatch_async(self.queue, ^(void){
        _imageView.image=_followModel.imgView;
        float width=_imageView.image.size.width;
        float height=_imageView.image.size.height;
        
        CGFloat biLi = height/width;
        float imgWidth=80;
        float imgHeight = biLi* imgWidth;
        float y= _txtViewTitle.frame.origin.y+_txtViewTitle.height;
        _imageView.frame=CGRectMake(10, y+5, imgWidth, imgHeight);
    
     /*  dispatch_sync(dispatch_get_main_queue(), ^(void) {
            _imageView.frame=CGRectMake(10, y+5, imgWidth, imgHeight);
            _imageView.image=_followModel.imgView;
        });
    
    });*/
    // }
   //录音时长和位置
    ((UILabel *)[_messageView viewWithTag:1002]).text=@"24''" ;
    float messageviewY=_imageView.frame.origin.y+_imageView.height;
    CGRect messageviewframe = CGRectMake(5, messageviewY+5, 100, 25);
    _messageView.frame=messageviewframe;
    //分割线位置
    float sepraViewY=_messageView.frame.origin.y+_messageView.height;
    CGRect sepraViewframe=CGRectMake(0, sepraViewY+10, 320, 1);
    _seperaView.frame=sepraViewframe;
    //位置
    ((UILabel *)[_locationView viewWithTag:1003]).text=_followModel.address ;
    float locationviewY=_seperaView.frame.origin.y+_seperaView.height;
    CGRect locationViewFrame=CGRectMake(5, locationviewY+10, 100, 20);
    _locationView.frame=locationViewFrame;
    //时间
    _lblTime.text=_followModel.time;
    _lblTime.frame=CGRectMake(320-80-5, locationviewY+10, 80, 20);
  
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
 
  /*  NSString *textContent=_followModel.title;
   
    //防止重用
    for (UIView *view in _txtViewTitle.subviews) {
        [view removeFromSuperview];
    }
      UIView *contentView = [self assembleMessageViewWithMessage:textContent];
    _txtViewTitle.height = contentView.height;
    //    _contentView.backgroundColor = [UIColor grayColor];
    contentView.frame = CGRectMake(10, 0, contentView.width, contentView.height);
    
    [_txtViewTitle addSubview:contentView];
   
   
    //图片的位置和高度，以及获取
    if(_followModel.imgView!=nil)
    {
       _imageView.image=_followModel.imgView;
        float width=_imageView.image.size.width;
        float height=_imageView.image.size.height;
        
        CGFloat biLi = height/width;
        float imgWidth=80;
        float imgHeight = biLi* imgWidth;
        float y= _txtViewTitle.frame.origin.y+_txtViewTitle.height;
       _imageView.frame=CGRectMake(10, y+5, imgWidth, imgHeight);

        
    }
    //录音时长和位置
    ((UILabel *)[_messageView viewWithTag:1002]).text=@"24''" ;
    float messageviewY=_imageView.frame.origin.y+_imageView.height;
     CGRect messageviewframe = CGRectMake(5, messageviewY+5, 100, 25);
    _messageView.frame=messageviewframe;
    //分割线位置
    float sepraViewY=_messageView.frame.origin.y+_messageView.height;
     CGRect sepraViewframe=CGRectMake(0, sepraViewY+10, 320, 1);
    _seperaView.frame=sepraViewframe;
    //位置
    ((UILabel *)[_locationView viewWithTag:1003]).text=_followModel.address ;
    float locationviewY=_seperaView.frame.origin.y+_seperaView.height;
    CGRect locationViewFrame=CGRectMake(5, locationviewY+10, 100, 20);
    _locationView.frame=locationViewFrame;
    //时间
    _lblTime.text=_followModel.time;
    _lblTime.frame=CGRectMake(320-80-5, locationviewY+10, 80, 20);
    */
}


# pragma mark -
# pragma mark - 图文混排
// 分割字符串
/*- (void)getImageRangeWithMessage:(NSString *)contentString andArray:(NSMutableArray *)array{
    
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
*/
#warning 根据分割的文本生成视图以及获取动态高度

/*#define KFacialSizeWidth  18
#define KFacialSizeHeight 18
#define MAX_WIDTH  280
-(UIView *)assembleMessageViewWithMessage: (NSString *) message{
    
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
    
  //  NSLog(@"ViewHeight = %f",ViewHeight);
    //
    //    NSLog(@"returnView.height = %f",returnView.height);
    //    NSLog(@"returnView.width = %f",returnView.width);
    return returnView;
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
    
    //  NSLog(@"ViewHeight = %f",ViewHeight);
    //
    //    NSLog(@"returnView.height = %f",returnView.height);
    //    NSLog(@"returnView.width = %f",returnView.width);
    return returnView;
}
*/
/*
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
*/
/*-(CGFloat)getHeightOfMessage:(NSString *)message{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self getImageRangeWithMessage:message andArray:array];
    
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSArray *dataArray = array;
    
    //    NSLog(@"%@",dataArray);
    
    UIFont *font = [UIFont systemFontOfSize:14];
    
    //坐标，
    CGFloat itemX = 0;     //图片坐标x
    CGFloat itemY = 0;
    CGFloat ViewWidth = 0;  //要生成的视图width
    CGFloat ViewHeight = 18;
    
    if (dataArray) {
        
        NSLog(@"dataArray = %@",dataArray);
        
        for (int i = 0 ; i < dataArray.count ; i++) {
            
            NSString *str = [dataArray objectAtIndex:i];
            
            NSString *matchStr = @"smile[0-9]{3}";  //字符串名称
            NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:matchStr options:NSRegularExpressionCaseInsensitive error:nil];
            
            NSArray *moodArray = nil;
            
            moodArray = [regex matchesInString:str options:NSMatchingReportProgress range:NSMakeRange(0,[str length])];
            
            
            //如果是表情图片
            if (moodArray.count > 0) {
                
                if (itemX >= MAX_WIDTH)
                {
                    itemY = itemY + KFacialSizeHeight;
                    itemX = 0;
                    ViewWidth = MAX_WIDTH;
                    ViewHeight = itemY +KFacialSizeHeight;
                }
                
                NSString *imageName = str;
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                
                imageView.frame = CGRectMake(itemX, itemY, KFacialSizeWidth, KFacialSizeHeight);
                
                [returnView addSubview:imageView];
               // [imageView release];
                
                itemX = KFacialSizeWidth+itemX; //这个
                
                if (ViewWidth < MAX_WIDTH) {
                    ViewWidth = itemX;
                }
            }else{
                //普通字符串,一个字一个字的贴
                for (int j = 0; j < [str length]; j++) {
                    
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    
                    if (itemX >= MAX_WIDTH)
                    {
                        itemY = itemY + KFacialSizeHeight;
                        itemX = 0;
                        ViewWidth = MAX_WIDTH;
                        ViewHeight = itemY +KFacialSizeHeight;
                    }
                    
                    CGSize size = [temp sizeWithFont:font constrainedToSize:CGSizeMake(MAX_WIDTH, 40)];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(itemX,itemY,size.width,size.height)];
                    label.font = font;
                    label.text = temp;
                    label.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:label];
                //    [label release];
                    itemX = itemX + size.width;
                    //                    NSLog(@"%f",itemX);
                    
                    if (ViewWidth < MAX_WIDTH)
                    {
                        ViewWidth = itemX;
                    }
                }
            }
        }
    }
    
    returnView.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
    
    //    NSLog(@"returnView.height = %f",returnView.height);
    //    NSLog(@"returnView.width = %f",returnView.width);
    return returnView.height;
    
}*/

/*+(CGFloat)getHeightOfMessage:(NSString *)message{
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [self getImageRangeWithMessage:message andArray:array];
    
    UIView *returnView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    NSArray *dataArray = array;
    
    //    NSLog(@"%@",dataArray);
    
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
                
                if (itemX >= MAX_WIDTH)
                {
                    itemY = itemY + KFacialSizeHeight;
                    itemX = 0;
                    ViewWidth = MAX_WIDTH;
                    ViewHeight = itemY +KFacialSizeHeight;
                }
                
                NSString *imageName = str;
                
                //                NSLog(@"imageName = %@",imageName);
                
                UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
                
                imageView.frame = CGRectMake(itemX, itemY, KFacialSizeWidth, KFacialSizeHeight);
                
                [returnView addSubview:imageView];
               // [imageView release];
                
                itemX = KFacialSizeWidth+itemX; //这个
                
                if (ViewWidth <MAX_WIDTH) {
                    ViewWidth = itemX;
                }
                
            }else{
                //普通字符串,一个字一个字的贴
                for (int j = 0; j < [str length]; j++) {
                    
                    NSString *temp = [str substringWithRange:NSMakeRange(j, 1)];
                    
                    if (itemX >= MAX_WIDTH)
                    {
                        itemY = itemY + KFacialSizeHeight;
                        itemX = 0;
                        ViewWidth = MAX_WIDTH;
                        ViewHeight = itemY +KFacialSizeHeight;
                    }
                    
                    
                    CGSize size = [temp sizeWithFont:font constrainedToSize:CGSizeMake( MAX_WIDTH, 40)];
                    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(itemX,itemY,size.width,size.height + 50)];
                    label.font = font;
                    label.text = temp;
                    label.backgroundColor = [UIColor clearColor];
                    [returnView addSubview:label];
                   // [label release];
                    
                    itemX = itemX + size.width;
                    //                    NSLog(@"%f",itemX);
                    
                    if (ViewWidth < MAX_WIDTH)
                    {
                        ViewWidth = itemX;
                    }
                }
            }
        }
    }
    
    returnView.frame = CGRectMake(0, 0, ViewWidth, ViewHeight);
    
    //    NSLog(@"returnView.height = %f",returnView.height);
    //    NSLog(@"returnView.width = %f",returnView.width);
    return returnView.height;
    
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
