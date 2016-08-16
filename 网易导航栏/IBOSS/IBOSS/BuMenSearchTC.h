//
//  BuMenSearchTC.h
//  IBOSS
//
//  Created by iHope on 14-7-11.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DailyReconciliationVC.h"
@interface BuMenSearchTC : BaseTableViewController
@property(strong) NSMutableArray *searchArr;
@property(nonatomic,weak) DailyReconciliationVC *parentVC;
@end
