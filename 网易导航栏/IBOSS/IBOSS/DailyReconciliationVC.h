//
//  DailyReconciliationVC.h
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DailyReconciliationVC : BaseViewController
@property(nonatomic,strong)UIButton*  btnYeWu;
//@property(strong) UITextField *txtRiQi;
//@property(strong) UITextField *txtBuMen;
//@property(strong) UITextField *txtHeJi;

@property(strong) UIButton *btnStartRiQi;
@property(strong) UIButton *btnEndRiQi;
@property(strong) UIButton *btnBuMen;

@property(copy) NSString *YeWuHiddenStr; //业务类型Code
@property(copy) NSString *BuMenHiddenStr;//业务部门Code
@property(copy) NSString *StartRiQiStr; //开始日期
@property(copy) NSString *EndRiQiStr;//结束日期

@end
