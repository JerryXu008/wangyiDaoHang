//
//  CustomerReportDetailVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerReportTableView.h"
#import "BaseTableView.h"
@interface CustomerReportDetailVC : UIViewController<UIScrollViewDelegate,UItableViewEventDelegate>
@property(nonatomic)int ReportIndex;
-(IBAction)btnBack:(id)sender;
@property(nonatomic) IBOutlet UIView *subTitleView;
@property(nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property(nonatomic,strong) IBOutlet CustomerReportTableView *tbView;//跟进
@property(nonatomic,strong) IBOutlet UIView *baseInfoView;

//跟进信息数组
@property(nonatomic,strong) NSMutableArray * FollowUpArr;

@end
