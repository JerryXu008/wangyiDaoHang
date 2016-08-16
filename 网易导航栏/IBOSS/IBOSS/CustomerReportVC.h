//
//  CustomerReportVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerReportVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) IBOutlet UITableView *reportListTV;
@property(nonatomic,strong) IBOutlet UIView *searchView;
-(IBAction)btnSearch :(id)sender;
@end
