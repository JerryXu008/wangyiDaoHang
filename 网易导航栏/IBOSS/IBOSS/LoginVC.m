//
//  LoginVCViewController.m
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "LoginVC.h"
#import "AppDelegate.h"
#import "ServerSettingVC.h"
#import "ASIDownManager.h"
#import "CommonCrypto/CommonDigest.h"
#import "ImageDownManager.h"

@interface LoginVC ()
{
   // BOOL autoLogin;
}
@property(nonatomic)BOOL keyboardShow;
@property (strong, nonatomic) IBOutlet UIView *viewOutlet;
@property (nonatomic, strong) ASIDownManager *mDownManager;

@end

@implementation LoginVC
@synthesize txtAccount=_txtAccount;
@synthesize txtPwd=_txtPwd;
@synthesize txtUserName=_txtUserName;
@synthesize btnLogin=_btnLogin;
@synthesize btnSetting=_btnSetting;
@synthesize keyboardShow,bgImageView=_bgImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)OnLoadFinish:(ImageDownManager *)sender {
    
    NSDictionary *dic = [sender.mWebStr JSONValue];
    NSLog(@"dic=%@",dic);
    [self Cancel];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        int iStatus = [[dic objectForKey:@"Status"] intValue];
        if (iStatus == 0) {
            //返回值正确，登陆成功
            [self automatic:dic];
            kkUserPwdOrinal=_txtPwd.text;
            kkUserPwd=[self md5:_txtPwd.text];
            kkUserCode=_txtUserName.text;
            kkAccountCode=_txtAccount.text;
            [Appdelegate changeViewDidLogin];
          
            
                
        }
        else  {
            [self showAlertViewText:@"登录失败"];
        }
        
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
    [self showAlertViewText:@"登录失败"];
}
- (void)Cancel {
   [self hideLoading];
   SAFE_CANCEL_ARC(self.mDownManager);
}
-(IBAction)btn_Login:(id)sender
{
    self.mDownManager = [[ASIDownManager alloc] init];
    self.mDownManager = [[ASIDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);

    [self showLoadingText:@"正在登录..."];
  //  ((AppDelegate *)[UIApplication sharedApplication].delegate)
    NSString *urlStr = ServerURL;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   // NSString *sessonkey= @"0c15f301-4c78-4d41-a443-32ccdad3ea85";
    /* 登录 */
    [dict setObject:@"SMDLogin" forKey:@"Action"];
    [dict setObject:_txtAccount.text forKey:@"AccountCode"];
    [dict setObject:_txtUserName.text forKey:@"UserCode"];
    [dict setObject:[self md5:_txtPwd.text ] forKey:@"UserPassword"];
    [dict setObject:[self IPAddress] forKey:@"MACAddress"];
    [dict setObject:[self IPAddress] forKey:@"IPAddress"];
    [dict setObject:UDID forKey:@"PhoneCode"];
    [dict setObject:PhoneType  forKey:@"PhoneType"];
    [dict setObject:AppVersion forKey:@"AppVersion"];
    [dict setObject:@"IOS" forKey:@"SystemType"];
    [dict setObject:SystemVersion forKey:@"SystemVersion"];
    [_mDownManager PostHttpRequest:urlStr :dict :nil :nil];
    // [Appdelegate changeViewDidLogin];
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

-(IBAction)btn_Setting:(id)sender
{
    ServerSettingVC *detailVC=[[ServerSettingVC alloc] initWithNibName:@"ServerSettingView" bundle:nil];
    //[self.navigationController
    [self presentViewController:detailVC animated:YES completion:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[self.navigationController.navigationBar setHidden:NO];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification
                                                  object:nil];
}

-(void)viewDidAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    
}
-(void)keyboardWillShow {
    // Animate the current view out of the way
    if(!keyboardShow){
        [UIView animateWithDuration:0.3f animations:^ {
            self.viewOutlet.frame = CGRectMake(self.viewOutlet.frame.origin.x, self.viewOutlet.frame.origin.y-160, self.viewOutlet.frame.size.width, self.viewOutlet.frame.size.height);
            
        }];}
    keyboardShow=YES;
    
}

-(void)keyboardWillHide {
    // Animate the current view back to its original position
    if(keyboardShow){
        [UIView animateWithDuration:0.3f animations:^ {
            self.viewOutlet.frame = CGRectMake(self.viewOutlet.frame.origin.x, self.viewOutlet.frame.origin.y+160, self.viewOutlet.frame.size.width, self.viewOutlet.frame.size.height);
            
        }];}
    keyboardShow=NO;
}
-(void)btnTouch:(id)sender
{

}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)ChangeAutoState
{
    if(kkAutoLogin!=nil)
    {
        if([[NSString stringWithFormat:@"%@",kkAutoLogin] isEqualToString:@"1"])
        {
            [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateNormal];
             kkAutoLogin=@"0";
            
        }
        else{
            [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateNormal];
             kkAutoLogin=@"1";
        }
    }
    else
    {
        [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateNormal];
        kkAutoLogin=@"1";
        
    }

    
   
}
-(void)CheckAutoLogin
{
    if(kkAutoLogin!=nil)
    {
        if([[NSString stringWithFormat:@"%@",kkAutoLogin] isEqualToString:@"1"])
        {
            [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateNormal];
        }
        else{
            [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateNormal];
        }
    }
    else
    {
        [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateNormal];
        
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
   // autoLogin=YES;
    [self CheckAutoLogin];
    [self getDeviceAndOSInfo];
    
   // [self ChangeAutoState];
  //  [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"guan.png"] forState:UIControlStateNormal];
    
	// Do any additional setup after loading the view.
    _txtAccount.borderStyle=UITextBorderStyleNone;
    _txtUserName.borderStyle=UITextBorderStyleNone;
    _txtPwd.borderStyle=UITextBorderStyleNone;
    _txtPwd.secureTextEntry = YES;
    //_txtAccount.text=@"dongke";
   // _txtUserName.text=@"yangl";
   // _txtPwd.text=@"1234";
   
   
    
    _txtAccount.text=kkAccountCode;
    _txtUserName.text=kkUserCode;
    _txtPwd.text=kkUserPwdOrinal;
    
   // [_btnAutoLogin setBackgroundImage:[UIImage imageNamed:@"kai.png"] forState:UIControlStateNormal];
    [_btnAutoLogin addTarget:self action:@selector(ChangeAutoState) forControlEvents:UIControlEventTouchUpInside];
    
    [_btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnLogin setBackgroundColor:[UIColor colorWithRed:211/255.0 green:1/255.0 blue:26/255.0 alpha:0.9]];
    [_btnLogin.layer setMasksToBounds:YES];
    [_btnLogin.layer setCornerRadius:5.0];
    [_btnLogin.layer setBorderWidth:0.0];
    
    [_btnSetting setTitle:@"设置" forState:UIControlStateNormal];
    [_btnSetting setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSetting setBackgroundColor:[UIColor colorWithRed:211/255.0 green:1/255.0 blue:26/255.0 alpha:0.9]];
    [_btnSetting.layer setMasksToBounds:YES];
    [_btnSetting.layer setCornerRadius:5.0];
    [_btnSetting.layer setBorderWidth:0.0];
    //UITapGestureRecognizer *singleTap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btnTouch:)];
    //[_bgImageView addGestureRecognizer:singleTap1];
}
- (void)automatic:(NSDictionary *)dic
{
    NSMutableDictionary *userinfodic = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSMutableDictionary *dict=[NSMutableDictionary new];
    [dict setObject:userinfodic forKey:@"userinfo"];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    [userDef setObject:dict forKey:@"dataDic"];
    [userDef synchronize];
}

-(void)dealloc
{
 [self Cancel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
