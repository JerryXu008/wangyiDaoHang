//
//  FormReportNavVC.m
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "FormReportNavVC.h"

@interface FormReportNavVC ()

@end

@implementation FormReportNavVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:NavTitleColor forKey:UITextAttributeTextColor];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0){
        self.navigationBar.tintColor=NavColor;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
