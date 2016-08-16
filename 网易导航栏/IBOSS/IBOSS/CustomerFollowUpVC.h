//
//  CustomerFollowUpVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyBordVIew.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "CustomerReportDetailVC.h"
@interface CustomerFollowUpVC : UIViewController<UITableViewDataSource,UITableViewDelegate,KeyBordVIewDelegate,UIImagePickerControllerDelegate,AVAudioPlayerDelegate>
@property(nonatomic,strong) CustomerReportDetailVC *parentVC;
@end
