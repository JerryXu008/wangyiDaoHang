//
//  PersonSettingVC.m
//  IBOSS
//
//  Created by iHope on 14-7-11.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "PersonSettingVC.h"
#import "GeneralSettingCell.h"
#import "MoreBackgroundCell.h"
#import "AutoLoginCell.h"
#import "SceneManagerVC.h"
#import "FormReportVC.h"
#import "StockDetailVC.h"
#import "DailyReconciliationVC.h"
@interface PersonSettingVC ()
@property(strong) IBOutlet UITableView *tbView;

@end

@implementation PersonSettingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"设置";
    self.tbView=[[UITableView alloc]init];
    self.tbView.frame=self.view.bounds;
    self.tbView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tbView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
    self.tbView.dataSource=self;
    self.tbView.delegate=self;
    [self.view addSubview:_tbView];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;

}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=indexPath.row;
    switch (row) {
            
        case 0:
        case 2:
        case 4:
       {
            
            return 20;
            
            break;
        }
        default:{
            return 60;
            break;
        }
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int row=indexPath.row;
    switch (row) {
            
        case 0: case 2: case 4: {
            MoreBackgroundCell *backcell=[[MoreBackgroundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            return backcell;
            
            break;
        }
        case 1:case 3:case 5:{
            GeneralSettingCell *genecell=[[GeneralSettingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            genecell.type=row;
            return genecell;
            
            break;
        }
            
        default:{
            return nil;
            break;
        }
            
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tbView deselectRowAtIndexPath:indexPath animated:NO];
    int row=indexPath.row;
    if(row==1)
    {
        __weak id weakApp=Appdelegate;
        [UIAlertView showAlertViewWithTitle:@""
                                    message:@"确定要切换用户吗？"
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:[NSArray arrayWithObject:@"确定"]
                                  onDismiss:^(int buttonIndex)  {
                                      //个人数据统统滴清除
                                      kkUserPwdOrinal=@"";
                                      kkUserPwd=@"";
                                      kkUserCode=@"";
                                      kkAccountCode=@"";
                                      [[UserInfoManager Share]ClearUserData ];
                                      //退回登录界面
                                      [weakApp changeViewDidLogout];

                                      
                                  }
                                   onCancel:^ {}];

           }
    else if(row==3)
    {
        [self showAlertViewText:@"当前为最新版本"];
    }
    else if(row==5){
       
      //  __weak id weakApp=Appdelegate;
        [UIAlertView showAlertViewWithTitle:@""
                                    message:@"确定要退出吗？"
                          cancelButtonTitle:@"取消"
                          otherButtonTitles:[NSArray arrayWithObject:@"确定"]
                                  onDismiss:^(int buttonIndex)  {
                                    // [self exitApplication];
                                       exit(0);
                                  }
                                   onCancel:^ {}];
       
    }
    
    
    
}

- (void)exitApplication {
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
   // self.window.bounds = CGRectMake(0, 0, 0, 0);
    
    [UIView commitAnimations];
     
}



- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}


-(void)gokucun
{
    self.hidesBottomBarWhenPushed=YES;
    StockDetailVC* scenemanagervc=[[StockDetailVC alloc] init];
    [self.navigationController pushViewController:scenemanagervc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}
-(void)gorijie
{
    self.hidesBottomBarWhenPushed=YES;
    DailyReconciliationVC* scenemanagervc=[[DailyReconciliationVC alloc] init];
    [self.navigationController pushViewController:scenemanagervc animated:YES];
    self.hidesBottomBarWhenPushed=NO;
    
}
-(void)refreshTableView
{
    [self.tbView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
