//
//  MainTabVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "MainTabVC.h"

@interface MainTabVC ()
@end
static MainTabVC *gHomeCtrl = nil;
@implementation MainTabVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       gHomeCtrl = self;
    }
    return self;
}
+ (UIViewController *)mRootCtrl {
    return gHomeCtrl;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    
    
    
    
    
    
   
   /* self.logmanagervc=[[LogManagerVC alloc] initWithNibName:@"LogManagerView" bundle:nil];
    self.logmanagernavvc = [[LogManagerNavVC alloc] initWithRootViewController: self.logmanagervc];
    UITabBarItem *logmanaItem= [[UITabBarItem alloc] initWithTitle: @"日志" image: nil tag: 2];
    logmanaItem.image=[UIImage imageNamed:@"newrizhi.png"];
     logmanaItem.selectedImage=[UIImage imageNamed:@"newrizhi2.png"];
    self.logmanagernavvc.tabBarItem = logmanaItem;
    */
    /*
    self.scenemanagervc=[[SceneManagerVC alloc] initWithNibName:@"SceneManagerView" bundle:nil];
    self.scenmanagernavvc = [[SceneManagerNavVC alloc] initWithRootViewController: self.scenemanagervc];
    UITabBarItem *sceneItem= [[UITabBarItem alloc] initWithTitle: @"现场" image: nil tag: 3];
    sceneItem.image=[UIImage imageNamed:@"newxianchang.png"];
    sceneItem.selectedImage=[UIImage imageNamed:@"newxianchang2.png"];
    self.scenmanagernavvc.tabBarItem = sceneItem;
    */
    /*
    self.formreportvc=[[FormReportVC alloc] initWithNibName:@"FormReportView" bundle:nil];
    self.formreportnavvc = [[FormReportNavVC alloc] initWithRootViewController: self.formreportvc];
    UITabBarItem *formreportItem= [[UITabBarItem alloc] initWithTitle: @"报表" image: nil tag: 4];
    formreportItem.image=[UIImage imageNamed:@"newbaobiao.png"];
    formreportItem.selectedImage=[UIImage imageNamed:@"newbaobiao2.png"];
    self.formreportnavvc.tabBarItem = formreportItem;
    */
    self.messagevc=[[MessageVC alloc] init];
    UINavigationController *messageNavVC=[[UINavigationController alloc]initWithRootViewController: self.messagevc];
   // UITabBarItem *messageItem= [[UITabBarItem alloc] initWithTitle: @"消息" image: nil tag: 2];
   // messageItem.image=[UIImage imageNamed:@"xiaoxi1.png"];
    //messageItem.selectedImage=[UIImage imageNamed:@"xiaoxi2.png"];
    //messageNavVC.tabBarItem = messageItem;

    self.workflowvc=[[WorkFlowVC alloc] init];
    self.workflownavvc = [[WorkFlowNavVC alloc] initWithRootViewController: self.workflowvc];
  //  UITabBarItem *workflowItem= [[UITabBarItem alloc] initWithTitle: @"审批" image: nil tag: 1];
 //   workflowItem.image=[UIImage imageNamed:@"shenpi1.png"];
  //  workflowItem.selectedImage=[UIImage imageNamed:@"shenpi2.png"];
   // self.workflownavvc.tabBarItem = workflowItem;
    
    self.customermanagervc=[[CustomerManagerVC alloc] initWithNibName:@"CustomerManaView" bundle:nil];
    self.customernavvc = [[CusotmerNavVC alloc] initWithRootViewController: self.customermanagervc];
   /* UITabBarItem *customerItem = [[UITabBarItem alloc] initWithTitle: @"客户" image: nil tag: 0];
    customerItem.image = [UIImage imageNamed:@"kehu1.png"];
    customerItem.selectedImage=[UIImage imageNamed:@"kehu2.png"];
    self.customernavvc.tabBarItem = customerItem;
*/
    
    self.moreinfovc=[[MoreInfoVC alloc] initWithNibName:@"MoreInfoView" bundle:nil];
    UINavigationController *moreinfoNavVC=[[UINavigationController alloc]initWithRootViewController:self.moreinfovc];
    /*UITabBarItem *moreinfoItem= [[UITabBarItem alloc] initWithTitle: @"更多" image: nil tag: 3];
    moreinfoItem.image=[UIImage imageNamed:@"gengduo1.png"];
    moreinfoItem.selectedImage=[UIImage imageNamed:@"gengduo2.png"];
    moreinfoNavVC.tabBarItem = moreinfoItem;
   */
   
    NSArray *array = [NSArray arrayWithObjects:messageNavVC, self.workflownavvc, self.customernavvc,moreinfoNavVC,nil];
    self.viewControllers = array;
    self.selectedIndex = 0;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
  //  mTabView = [[SelectTabBar alloc] initWithFrame:CGRectMake(0, window.frame.size.height-50, window.frame.size.width, 50)];
     mTabView = [[SelectTabBar alloc] initWithFrame:CGRectMake(0, 0, window.frame.size.width, 50)];
    mTabView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin;
    mTabView.delegate = self;
    [self.tabBar addSubview:mTabView];
  
    [self OnTabSelect:mTabView];
    
    
    
    
}
- (BOOL)CanSelectTab:(SelectTabBar *)sender :(int)index {
    return YES;
}

- (void)OnTabSelect:(SelectTabBar *)sender {
    int index = sender.miIndex;
    NSLog(@"OnTabSelect:%d", index);
    self.selectedIndex = index;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
