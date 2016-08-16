//
//  MainTabVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowNavVC.h"
#import "WorkFlowVC.h"
#import "CusotmerNavVC.h"
#import "CustomerManagerVC.h"
#import "LogManagerNavVC.h"
#import "LogManagerVC.h"
#import "FormReportNavVC.h"
#import "FormReportVC.h"
#import "SceneManagerNavVC.h"
#import "SceneManagerVC.h"
#import "MessageVC.h"
#import "MoreInfoVC.h"
#import "SelectTabBar.h"
@interface MainTabVC : UITabBarController<SelectTabBarDelegate>
{
SelectTabBar *mTabView;
}
@property (nonatomic, readonly) UIViewController *mRootCtrl;
@property(nonatomic,strong) IBOutlet CusotmerNavVC *customernavvc;
@property(nonatomic,strong) IBOutlet WorkFlowNavVC *workflownavvc;
@property(nonatomic,strong) IBOutlet CustomerManagerVC *customermanagervc;
@property(nonatomic,strong) IBOutlet WorkFlowVC *workflowvc;
@property(nonatomic,strong) IBOutlet LogManagerNavVC *logmanagernavvc;
@property(nonatomic,strong) IBOutlet LogManagerVC *logmanagervc;
@property(nonatomic,strong) IBOutlet FormReportNavVC *formreportnavvc;
@property(nonatomic,strong) IBOutlet FormReportVC *formreportvc;
@property(nonatomic,strong) IBOutlet SceneManagerNavVC *scenmanagernavvc;
@property(nonatomic,strong) IBOutlet SceneManagerVC *scenemanagervc;

@property(nonatomic,strong) IBOutlet MessageVC *messagevc;
@property(nonatomic,strong) IBOutlet MoreInfoVC *moreinfovc;
@end
