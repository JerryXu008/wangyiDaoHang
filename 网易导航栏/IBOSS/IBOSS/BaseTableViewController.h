//
//  BaseTableViewController.h
//  IBOSS
//
//  Created by iHope on 14-7-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonCrypto/CommonDigest.h"
@interface BaseTableViewController : UITableViewController
@property(nonatomic,strong) MBProgressHUD *hud;
-(void)showLoading;
-(void) hideLoading;
-(void)showLoadingText:(NSString*)text;
-(void)showAlertViewText:(NSString *)text;
- (NSString *) md5:(NSString *)str;
@end
