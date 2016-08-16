//
//  ServerSetting.m
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "ServerSettingVC.h"

@interface ServerSettingVC ()

@property(nonatomic)BOOL keyboardShow;
@property (strong, nonatomic) IBOutlet UIView *viewOutlet;
@end

@implementation ServerSettingVC
@synthesize keyboardShow;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)btn_Save:(id)sender
{
    kkServerUrl=_txtUrl.text;
    kkServerPort=_txtpost.text;

    [self dismissViewControllerAnimated:YES completion:nil];
}
-(IBAction)btn_Cancel:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)viewDidLoad
{
   
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    _txtUrl.borderStyle=UITextBorderStyleNone;
    _txtpost.borderStyle=UITextBorderStyleNone;
    _txtUrl.text=kkServerUrl;
    _txtpost.text=kkServerPort;
    if(kkServerUrl==nil||kkServerUrl.length==0||kkServerPort==nil||kkServerPort.length==0)
    {
      //  #define ServerURL @"http://223.202.3.224:5679/WebService/SMD/DKSMD.aspx"
        _txtUrl.text=@"http://223.202.3.224";
        _txtpost.text=@"5679";
        kkServerUrl=@"http://223.202.3.224";
        kkServerPort=@"5679";
    }
    [_btnSave setTitle:@"保存" forState:UIControlStateNormal];
    [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnSave setBackgroundColor:[UIColor colorWithRed:211/255.0 green:1/255.0 blue:26/255.0 alpha:0.9]];
    [_btnSave.layer setMasksToBounds:YES];
    [_btnSave.layer setCornerRadius:5.0];
    [_btnSave.layer setBorderWidth:0.0];
    
    [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
    [_btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnCancel setBackgroundColor:[UIColor colorWithRed:211/255.0 green:1/255.0 blue:26/255.0 alpha:0.9]];
    [_btnCancel.layer setMasksToBounds:YES];
    [_btnCancel.layer setCornerRadius:5.0];
    [_btnCancel.layer setBorderWidth:0.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
