//
//  ArgumentSetting.h
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"
#import "UIImage+StrethImage.h"
#import "NSString+DocumentPath.h"
#import "MBProgressHUD.h"
#import "UIViewExt.h"
#import "UIImageView+WebCache.h"
#import "UserInfoManager.h"
#import "BaseViewController.h"
#import "ASIDownManager.h"
#import "BaseTableViewController.h"
#import "ImageDownManager.h"
#import "UIAlertView+Blocks.h"
#import "AppDelegate.h"
#define IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)

#define NavColor [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.0]

#define NavTitleColor [UIColor blackColor]
#define NavBarItemColor [UIColor colorWithRed:213/255.0 green:0/255.0 blue:33/255.0 alpha:1.0]

#define Screen_Height2 [[UIScreen mainScreen] bounds].size.height
#define Screen_Height [[UIScreen mainScreen] bounds].size.height-20
#define Screen_Width  [[UIScreen mainScreen] bounds].size.width
#define Appdelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_ON_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define SCREENHEIGHT    ([UIScreen mainScreen].bounds.size.height)
#define SCREENWIDTH     ([UIScreen mainScreen].bounds.size.width)
#define FONTCOLOR  [UIColor colorWithRed:0.6118 green:0.5961 blue:0.5529 alpha:1]



//#define ServerURL @"http://223.202.3.224:5679/WebService/SMD/DKSMD.aspx"
#define ServerURL ([NSString stringWithFormat:@"%@:%@/WebService/SMD/DKSMD.aspx",kkServerUrl,kkServerPort])
#define UDID @"fdsfdsfdsfdsfsdfsdfdsfdsfdsfsdfds"
#define SystemVersion ([[UIDevice currentDevice] systemVersion])
#define AppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])
//手机型号
#define PhoneType  ([[UIDevice currentDevice] model])
typedef enum {
    
    customerWayType=0,
    customerNameType,
     customerPropotyType,
    MegPhoneType,
    MegPersonlType,
    MegMobilePhoneType,
     DepartmentType,
    SaleManType,
    MidCustomerType,
     MidEmployeeType,
     RoomAreaType,
     ProgressType,
     AddressType,
     NoteInfoType
    
}CustomerManagerAddType;

/*NSUInteger DeviceSystemMajorVersion();
NSUInteger DeviceSystemMajorVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

#define MY_MACRO_NAME (DeviceSystemMajorVersion() < 7)
*/









