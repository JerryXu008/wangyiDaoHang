//
//  CustomerManagerVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerReportVC.h"
//#import "CustomerReportView.h"
#import "CustomerFollowUpVC.h"
#import "CustomerReportDetailVC.h"
#import "SNPopupView.h"
#import "SNPopupView+UsingPrivateMethod.h"
@interface CustomerManagerVC : UIViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,SNPopupViewModalDelegate>
@property(nonatomic,strong) IBOutlet UITableView *tbView;
@property(strong) IBOutlet UISearchBar *searchBar;
@end
