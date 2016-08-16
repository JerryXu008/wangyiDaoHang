//
//  AppDelegate.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "MainTabVC.h"
@implementation AppDelegate

-(void)changeViewDidLogin {
    MainTabVC *mainVC = [[MainTabVC alloc] init];
    self.window.rootViewController = mainVC;//mainVC.tabBarController;

}

-(void)changeViewDidLogout {
    LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginView" bundle:nil];
   // UINavigationController *navvc=[[UINavigationController alloc] initWithRootViewController:loginVC];
    self.window.rootViewController = loginVC;
   }




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    // Override point for customization after application launch.
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
        [[UINavigationBar appearance] setBarTintColor:NavColor];
    }
   /* //没有自动登录
    if(kkAutoLogin==nil||[[NSString stringWithFormat:@"%@",kkAutoLogin ]isEqualToString:@"0"]){
        [self changeViewDidLogout];
    }
    else {//自动登录了
    if(kkSessionKey!=nil&&![kkSessionKey isEqualToString:@""]){
        [self changeViewDidLogin];
    }
    else{
    [self changeViewDidLogout];
    }
    
    }*/
    [self changeViewDidLogin];
    [self.window makeKeyAndVisible];

   // NSLog(@"path=%@",NSHomeDirectory());
   // UIImage *img = [UIImage imageNamed:@"盘点.png"];
    //UIImageWriteToSavedPhotosAlbum(img, self, nil, NULL);
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
