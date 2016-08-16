//
//  FormReportVC.m
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "FormReportVC.h"
#import "StockInfoVC.h"
#import "DailyReconciliationVC.h"
@interface FormReportVC ()

@end

@implementation FormReportVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(IBAction)gotoDetail:(id)sender
{  UIButton *btn=(UIButton *)sender;
   if(btn.tag==1001)
   {
       DailyReconciliationVC *detailVC=[[DailyReconciliationVC alloc] initWithNibName:@"DailyReconciliationView" bundle:nil];
       [self.navigationController pushViewController:detailVC animated:YES];
   }
    else
    {
        StockInfoVC *detailVC=[[StockInfoVC alloc] initWithNibName:@"StockInfoView" bundle:nil];
        [self.navigationController pushViewController:detailVC animated:YES];

    }
    
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.navigationItem.title=@"报表";
    
    
    self.test2Button.backgroundColor=[UIColor clearColor];
    self.testButton.backgroundColor=[UIColor clearColor];
    [self.testButton setTitle:@"进入" forState:UIControlStateNormal];
    [self.test2Button setTitle:@"进入" forState:UIControlStateNormal];
    [self.testButton setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    [self.test2Button setTitleColor:[UIColor whiteColor]forState:UIControlStateNormal];
    self.testButton.tag=1001;
    self.test2Button.tag=1002;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
