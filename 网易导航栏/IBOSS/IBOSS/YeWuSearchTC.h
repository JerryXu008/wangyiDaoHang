//
//  YeWuSearchTC.h
//  IBOSS
//
//  Created by iHope on 14-7-10.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DailyReconciliationVC.h"
@interface YeWuSearchTC : BaseTableViewController
@property(strong) NSMutableArray *searchArr;
@property(nonatomic,weak) DailyReconciliationVC *parentVC;
@end
