//  Created by xujinlei on 13-6-16.
//  Copyright (c) 2013年 xujinlei. All rights reserved.
//

#import "BRDatePickerView.h"
//#define ALERTHEIGHT 216.0
#define ALERTHEIGHT 260.0
#define BUTTONHEIGHT 30.0
#define PICKERHEIGHT 216.0
#define VERTICALBUTTON_TOPMARGIN 7.0
#define VERTICALBUTTON_BOTTOMMARGIN 7.0
#define HORIZONTALBUTTON_LEFTMARGIN 10.0
#define BUTTONWIDTH 50.0
@interface BRDatePickerView()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) UIView *alertBg;


@property (strong, nonatomic) UIDatePicker *datePicker;


@end

@implementation BRDatePickerView
@synthesize datePicker;
//手势委托方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
      if([touch.view isMemberOfClass:[BRDatePickerView class]])
    {
        return YES;
    }
    else
        return NO;
    
    
}
-(void)singleTapAction:(UITapGestureRecognizer *)sender
{
    [self dismissAlertWithCancel];
}

-(void)dismissAlertWithCompletion
{
	[self animateOut];
    if (self.completionBlock != nil)
		self.completionBlock();
    
}
-(void)dismissAlertWithCancel
{
	[self animateOut];
    if (self.cancelBlock != nil)
		self.cancelBlock();
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)datePickerValueChanged:(id)sender
{
    
    NSDate *select = [datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:select];
    
    if (self.selectionBlock != nil)
		self.selectionBlock(dateAndTime);

}






+(BRDatePickerView *)PickerAlertWithTitle:(NSString *)title
{
    return [[self alloc] initWithTitle:title ];
    
}

-(id)initWithTitle:(NSString *)title {
        self = [super init];
	 if (self)
	 {
       
       
        UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(singleTapAction:)];
        singleTap.delegate=self;
        [self addGestureRecognizer:singleTap];
        
        
        
    }
	
	return self;
}











-(void)createBackgroundView
{
		self.frame = [[UIScreen mainScreen] bounds];
	self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.0];
	self.opaque = NO;
	
	// adding it as subview of app's UIWindow
	UIWindow *appWindow = [[UIApplication sharedApplication] keyWindow];
	[appWindow addSubview:self];
	[self setBackgroundColor:[[UIColor alloc] initWithRed:0.329 green:0.423 blue:0.502 alpha:0.5]];
}
-(void)show
{
	[self createBackgroundView];
	
    CGRect frame = [self  bounds];
    frame.origin.y = frame.size.height-ALERTHEIGHT;
    frame.size.height=ALERTHEIGHT;
    
	//self.alertBg=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"customViewbg.png"] ];
    self.alertBg=[[UIImageView alloc] init ];
    self.alertBg.backgroundColor=[UIColor whiteColor];
    self.alertBg.userInteractionEnabled=YES;
    self.alertBg.layer.borderColor = [[UIColor clearColor] CGColor];
    [self addSubview:self.alertBg];
  
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"取消" forState:UIControlStateNormal];
    [button   setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    button.backgroundColor=[UIColor  colorWithWhite:1.0 alpha:0.9];
    //[button setBackgroundImage:[UIImage imageNamed:@"btnUnSelected.png"] forState:UIControlStateNormal];
    //[button setBackgroundImage:[UIImage imageNamed:@"btnSelected.png"] forState:UIControlStateHighlighted];
    button.backgroundColor=[UIColor grayColor];
    button.layer.masksToBounds = YES;
    button.layer.borderColor = [[UIColor clearColor] CGColor];
    button.layer.cornerRadius = 5.0f;
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    button.frame=CGRectMake(HORIZONTALBUTTON_LEFTMARGIN, VERTICALBUTTON_TOPMARGIN, BUTTONWIDTH, BUTTONHEIGHT);
    [button addTarget:self action:@selector(dismissAlertWithCancel) forControlEvents:UIControlEventTouchUpInside];
    [self.alertBg addSubview:button];
    UIButton *buttonOK=[UIButton buttonWithType:UIButtonTypeCustom];
    [buttonOK setTitle:@"确定" forState:UIControlStateNormal];
    [buttonOK   setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [buttonOK setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buttonOK setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    buttonOK.backgroundColor=[UIColor  colorWithWhite:1.0 alpha:0.9];
   // [buttonOK setBackgroundImage:[UIImage imageNamed:@"btnUnSelected.png"] forState:UIControlStateNormal];
    //[buttonOK setBackgroundImage:[UIImage imageNamed:@"btnSelected.png"] forState:UIControlStateHighlighted];
    buttonOK.backgroundColor=[UIColor grayColor];
    buttonOK.layer.masksToBounds = YES;
    buttonOK.layer.borderColor = [[UIColor clearColor] CGColor];
    buttonOK.layer.cornerRadius = 5.0f;
    buttonOK.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    buttonOK.frame=CGRectMake(frame.size.width-BUTTONWIDTH-HORIZONTALBUTTON_LEFTMARGIN ,VERTICALBUTTON_TOPMARGIN, BUTTONWIDTH, BUTTONHEIGHT);
     [buttonOK addTarget:self action:@selector(dismissAlertWithCompletion) forControlEvents:UIControlEventTouchUpInside];
    [self.alertBg addSubview:buttonOK];

   /* self.pickerView=[[UIPickerView alloc] initWithFrame:CGRectZero];
    self.pickerView.frame = CGRectMake(0, BUTTONHEIGHT+VERTICALBUTTON_BOTTOMMARGIN+VERTICALBUTTON_TOPMARGIN , [self  bounds].size.width,self.pickerView.bounds.size.height);
     self.pickerView.showsSelectionIndicator=YES;
    [self.pickerView selectRow:0 inComponent:0 animated:YES];
	self.pickerView.delegate = self;
	self.pickerView.dataSource = self;
   [self.alertBg addSubview:self.pickerView];*/
    datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, BUTTONHEIGHT+VERTICALBUTTON_BOTTOMMARGIN+VERTICALBUTTON_TOPMARGIN , [self  bounds].size.width,10)];
    // 设置时区
    [datePicker setTimeZone:[NSTimeZone timeZoneWithName:@"GMT"]];
    // 设置当前显示时间
    //[datePicker setDate:tempDate animated:YES];
    // 设置显示最大时间（此处为当前时间）
    [datePicker setMaximumDate:[NSDate date]];
    // 设置UIDatePicker的显示模式
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    // 当值发生改变的时候调用的方法
    [datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.alertBg addSubview:datePicker];
    
	

	self.alertBg.frame=frame;
   	// show the alert with animation
	[self animateIn];
    
    
     [self datePickerValueChanged:nil];
}





-(void) animateIn
{
    [self  setAlpha:0];
    [[self alertBg] setTransform:CGAffineTransformMakeTranslation(0, [[self alertBg] frame].size.height)];
    [UIView
     animateWithDuration:0.3
     animations:^{
         [self  setAlpha:1.0];
         [[self alertBg] setTransform:CGAffineTransformIdentity];//恢复开始位置
    }
     completion:^(BOOL finished) {
         
     }];

}
-(void)animateOut
{

    [UIView animateWithDuration:0.3
					 animations:^{
						 self.alpha = 0;
                       CGAffineTransform t = CGAffineTransformIdentity;
                       t=CGAffineTransformTranslate(t, 0, [self  bounds].size.height);//以歧视位置为参照进行移动
                       self.alertBg.transform = t;
					 }
					 completion:^(BOOL finished){
						 [self removeFromSuperview];
					 }];
}
#pragma mark - Actions

-(void)configureSelectionBlock:(XYPickerAlertRowSelectionBlock)selBlock andCompletionBlock:(XYPickerAlertCompletionBlock)competionBlock andCancelBlock:(XYPickerAlertCancelBlock) cancelBlock {
	self.selectionBlock = selBlock;
	self.completionBlock = competionBlock;
    self.cancelBlock=cancelBlock;
}


@end
