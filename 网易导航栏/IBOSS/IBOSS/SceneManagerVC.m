//
//  SceneManagerVC.m
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "SceneManagerVC.h"
#import "SceneCheckVC.h"
@interface SceneManagerVC ()

@end

@implementation SceneManagerVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)gotoDetail:(id)sender
{
    // self.hidesBottomBarWhenPushed=YES;
    SceneCheckVC *detailVC=[[SceneCheckVC alloc] initWithNibName:@"SceneCheckView" bundle:nil];
    [self.navigationController pushViewController:detailVC animated:YES];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"现场";
    
    self.testButton.backgroundColor=[UIColor clearColor];
    [self.testButton setTitle:@"进入" forState:UIControlStateNormal];
       [self.testButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
