//
//  AppDelegate.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTabVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) IBOutlet MainTabVC *mainTabVC;
-(void)changeViewDidLogin;
-(void)changeViewDidLogout;

@end
