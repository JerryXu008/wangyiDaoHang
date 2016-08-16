//
//  WorkFlowVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowDetailVC.h"
#import "RefreshTableView.h"
@interface WorkFlowVC : BaseViewController<UITableViewDataSource, UITableViewDelegate,RefreshTableViewDelegate,WorkFlowCellDelegate>
-(void)reloadData;
@end
