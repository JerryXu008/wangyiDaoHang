//
//  LoginVCViewController.h
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : BaseViewController
@property(nonatomic,strong) IBOutlet UITextField *txtAccount;
@property(nonatomic,strong) IBOutlet UITextField *txtUserName;
@property(nonatomic,strong) IBOutlet UITextField *txtPwd;
@property(nonatomic,strong) IBOutlet UIButton *btnLogin;
@property(nonatomic,strong) IBOutlet UIButton *btnSetting;
@property(nonatomic,strong) IBOutlet UIImageView *bgImageView;
@property(nonatomic,strong) IBOutlet UIButton *btnAutoLogin;
-(IBAction)btn_Login:(id)sender;
-(IBAction)btn_Setting:(id)sender;
@end
