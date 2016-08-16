//
//  ServerSetting.h
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerSettingVC : UIViewController
@property(nonatomic,strong) IBOutlet UITextField *txtUrl;
@property(nonatomic,strong) IBOutlet UITextField *txtpost;
@property(nonatomic,strong) IBOutlet UIButton *btnSave;
@property(nonatomic,strong) IBOutlet UIButton *btnCancel;
-(IBAction)btn_Save:(id)sender;
-(IBAction)btn_Cancel:(id)sender;

@end
