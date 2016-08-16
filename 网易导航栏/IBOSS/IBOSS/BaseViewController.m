//
//  BaseViewController.m
//  IBOSS
//
//  Created by iHope on 14-7-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "BaseViewController.h"
#include <ifaddrs.h>
#include <arpa/inet.h>
@interface BaseViewController ()

@end

@implementation BaseViewController
@synthesize hud;
@synthesize mlbTitle, delegate, OnGoBack, mTopColor, mTopImage, mLoadMsg, mTitleColor, mbLightNav, mFontSize;

-(NSString *)getArrToString:(NSArray *)arr
{
    if(!arr) return nil;
    NSMutableString *totalstr=[[NSMutableString alloc] init];
    for(int i=0;i<arr.count;i++)
    {
        NSString *tempStr=arr[i];
        [totalstr appendFormat:@"%@%@",tempStr,@"," ];
    }
    return  [totalstr substringToIndex:totalstr.length-1];
}

- (NSString *)IPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    // Free memory
    freeifaddrs(interfaces);
    
    return address;
}



- (void)getDeviceAndOSInfo
{
    //here use sys/utsname.h
    struct utsname systemInfo;
    uname(&systemInfo);
    //get the device model and the system version
    NSLog(@"%@", [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding]);
   
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        mbLightNav = YES;
        mFontSize = 20;
        self.mTopImage = [UIImage imageNamed:IOS_7?@"topbar7.png":@"topbar.png"];
      //  self.mTopColor = [UIColor colorWithRed:0.15 green:0.56 blue:0.9 alpha:1.0];
      //  self.mTitleColor = [UIColor whiteColor];

    }
    return self;
}

-(void)showLoadingText:(NSString*)text
{
    // self.hud=nil;
    // [hud release];
    
    
    //如果设置此属性则当前的view置于后台
    hud.dimBackground = YES;
    
    //设置对话框文字
    hud.labelText = text;
       [hud show:YES];
    
}

-(void)showLoading
{
     hud.dimBackground = YES;
     hud.labelText = @"正在加载";
    [hud show:YES];
    
}
-(void) hideLoading
{
    [hud hide:YES];
}
-(void)showAlertViewText:(NSString *)text
{
    UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:text
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];
   

}


- (void)GoHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)GoBack {
    if (delegate && OnGoBack) {
        [delegate performSelector:OnGoBack withObject:self];
    }
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (void)RefreshNavColor {
    if (mTopColor) {
        if (IOS_7) {
            self.navigationController.navigationBar.barTintColor = mTopColor;
            self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
        }
        else {
            self.navigationController.navigationBar.tintColor = mTopColor;
        }
    }
    if (mTopImage) {
        [self.navigationController.navigationBar setBackgroundImage:mTopImage forBarMetrics:UIBarMetricsDefault];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    hud = [[MBProgressHUD alloc] initWithView:self.view] ;
    [self.view addSubview:hud];
   // [self.view bringSubviewToFront:hud];
    self.view.backgroundColor = [UIColor colorWithWhite:0.96 alpha:1.0];
    if (IOS_7) {
        //去掉边缘化 适配
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
        if (!mbLightNav) {
            self.navigationController.navigationBar.translucent = NO;
        }
    }
    [self RefreshNavColor];
    
  /*  mlbTitle = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, self.view.frame.size.width-100, 44)];
    mlbTitle.backgroundColor = [UIColor clearColor];
    mlbTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:mFontSize];
    mlbTitle.textAlignment = NSTextAlignmentCenter;
    mlbTitle.textColor = self.mTitleColor;
    mlbTitle.text = self.title;
    self.navigationItem.titleView = mlbTitle;
    */
    
    
    [self AddLeftImageBtn:nil target:nil action:nil];
    [self AddRightImageBtn:nil target:nil action:nil];
}

- (void)ClearNavItem {
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
}

- (UIButton *)GetImageButton:(UIImage *)image target:(id)target action:(SEL)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    int iWidth = image.size.width/2;
    int iHeight = image.size.height/2;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake((40-iWidth)/2, (40-iHeight)/2, iWidth, iHeight);
    imageView.tag = 1300;
    [rightBtn addSubview:imageView];
    
    
    return rightBtn;
}

- (UIBarButtonItem *)GetImageBarItem:(UIImage *)image target:(id)target action:(SEL)action {
    int iBtnWidth = IOS_7?30:40;
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, iBtnWidth, 40);
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    int iWidth = image.size.width/2;
    int iHeight = image.size.height/2;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake((iBtnWidth-iWidth)/2, (40-iHeight)/2, iWidth, iHeight);
    imageView.tag = 1300;
    [rightBtn addSubview:imageView];
   
    
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn] ;
}

- (UIBarButtonItem *)GetTextBarItem:(NSString *)name target:(id)target action:(SEL)action {
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:name forState:UIControlStateNormal];
    [rightBtn setTitleColor:self.mTitleColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:rightBtn] ;
}

- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.leftBarButtonItem = [self GetImageBarItem:image target:target action:action];
}

- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [self GetImageBarItem:image target:target action:action];
}

- (void)AddRightImageBtns:(NSArray *)array {
    if (!array || array.count == 0) {
        return;
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, array.count*40, 40)] ;
    for (int i = 0; i < array.count; i ++) {
        UIButton *btn = [array objectAtIndex:i];
        btn.frame = CGRectMake(i*40, 0, 40, 40);
        [view addSubview:btn];
    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view] ;
}

- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action {
    self.navigationItem.rightBarButtonItem = [self GetTextBarItem:name target:target action:action];
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    mlbTitle.text = title;
}

- (UIView *)GetInputAccessoryView {
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)] ;
    inputView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(inputView.frame.size.width-50, 0, 50, inputView.frame.size.height);
    [btn setTitle:@"隐藏" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btn addTarget:self action:@selector(OnHideKeyboard) forControlEvents:UIControlEventTouchUpInside];
    [inputView addSubview:btn];
    
    return inputView;
}

- (void)OnHideKeyboard {
    [self.view endEditing:NO];
}

- (void)dealloc {
    self.mTopColor = nil;
    self.mTopImage = nil;
    self.mLoadMsg = nil;
    
}

- (void)ShowLogo:(int)iOffset {
    if (mLogoView) {
        return;
    }
    int iWidth = 150;
    int iHeight = 130;
    mLogoView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-iWidth)/2, (self.view.frame.size.height-iHeight)/2+iOffset, iWidth, iHeight)];
    mLogoView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    mLogoView.image = [UIImage imageNamed:@"default_logo.png"];
    [self.view addSubview:mLogoView];
}

- (void)HideLogo {
    if (mLogoView) {
        [mLogoView removeFromSuperview];
        mLogoView = nil;
    }
}

- (void)StartLoading
{
    if (mLoadView) {
        return;
    }
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
    if (mLoadMsg) {
        mLoadView.mode = MBProgressHUDModeCustomView;
        mLoadView.labelText = mLoadMsg;
    }
    [self.view addSubview:mLoadView];
   
    
    [mLoadView show:YES];
}

- (void)StopLoading
{
    [mLoadView hide:YES];
    mLoadView = nil;
}

- (void)showMsg:(NSString *)msg
{
    mLoadView = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:mLoadView];
    
    
	mLoadView.mode = MBProgressHUDModeCustomView;
	mLoadView.labelText = msg;
	[mLoadView show:YES];
	[mLoadView hide:YES afterDelay:1];
    mLoadView = nil;
}
- (NSString *) md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   // [SelectTabBar Share].hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end