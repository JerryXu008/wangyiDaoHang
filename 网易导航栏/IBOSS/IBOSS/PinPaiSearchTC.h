//
//  PinPaiSearchTC.h
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StockDetailVC.h"
@interface PinPaiSearchTC : BaseTableViewController
@property(strong) NSMutableArray *searchArr;
@property(nonatomic,weak) StockDetailVC *parentVC;
@end
