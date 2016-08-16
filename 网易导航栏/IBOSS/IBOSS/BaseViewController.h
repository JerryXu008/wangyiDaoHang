//
//  BaseViewController.h
//  IBOSS
//
//  Created by iHope on 14-7-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCrypto/CommonDigest.h"
#import "sys/utsname.h"
@interface BaseViewController : UIViewController{
    UILabel *mlbTitle;
    MBProgressHUD *mLoadView;
  //  id delegate;
    UIImageView *mLogoView;
}

@property(nonatomic,strong) MBProgressHUD *hud;
- (void)getDeviceAndOSInfo;
- (NSString *)IPAddress;
-(void)showLoading;
-(void) hideLoading;
-(void)showLoadingText:(NSString*)text;
-(void)showAlertViewText:(NSString *)text;
-(NSString *)getArrToString:(NSArray *)arr;
- (NSString *) md5:(NSString *)str;
@property (nonatomic, retain) NSString *mLoadMsg;
@property (nonatomic, assign) id delegate;
@property (nonatomic, assign) SEL OnGoBack;

//topbar
@property (nonatomic, readonly) UILabel *mlbTitle;
@property (nonatomic, retain) UIColor *mTitleColor;
@property (nonatomic, retain) UIColor *mTopColor;
@property (nonatomic, retain) UIImage *mTopImage;
@property (nonatomic, assign) BOOL mbLightNav;
@property (nonatomic, assign) int mFontSize;


- (void)GoBack;
- (void)GoHome;
- (void)StartLoading;
- (void)StopLoading;
- (void)showMsg:(NSString *)msg;

- (void)HideLogo;
- (void)ShowLogo:(int)iOffset;

- (void)ClearNavItem;
- (void)AddRightTextBtn:(NSString *)name target:(id)target action:(SEL)action;
- (void)AddRightImageBtn:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddLeftImageBtn:(UIImage *)image target:(id)target action:(SEL)action;

- (UIButton *)GetImageButton:(UIImage *)image target:(id)target action:(SEL)action;
- (UIBarButtonItem *)GetImageBarItem:(UIImage *)image target:(id)target action:(SEL)action;
- (void)AddRightImageBtns:(NSArray *)array;

- (void)RefreshNavColor;

- (UIView *)GetInputAccessoryView;

@end
