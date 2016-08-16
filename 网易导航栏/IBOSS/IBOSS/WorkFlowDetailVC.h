//
//  WorkFlowDetailVC.h
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowInfoModel.h"
@class WorkFlowViewCell;
@protocol WorkFlowCellDelegate <NSObject>
@optional
-(void)showWorkFlowDetail:(int)index;
-(void) btnCheckPressed:(WorkFlowViewCell *)cell;
 
@end

@interface WorkFlowDetailVC : BaseViewController <UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong) IBOutlet UIScrollView *scrollView;
@property(strong) IBOutlet UITableView *tbView;
//@property(strong,nonatomic) NSDictionary* dicInfo;
@property(nonatomic,strong) WorkFlowInfoModel *dicInfo;
@property(nonatomic,assign) NSString *FlowCode;
@property(nonatomic,assign) NSString *InvoiceID;
@end
