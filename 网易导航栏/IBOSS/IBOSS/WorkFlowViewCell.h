//
//  WorkFlowViewCell.h
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WorkFlowDetailVC.h"
#import "WorkFlowInfoModel.h"
@interface WorkFlowViewCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UIButton *btnGoDetail;
@property(strong) IBOutlet UILabel *lblRow;
@property(strong) IBOutlet UILabel *lblNumber;
@property(strong) IBOutlet UILabel *lblType;
@property(strong) IBOutlet UILabel *lblReason;
@property(strong) IBOutlet UILabel *lblCreateMan;
@property(strong) IBOutlet UILabel *lblNote;
@property(strong) IBOutlet UILabel *lblTime;
@property(strong) IBOutlet UIButton *btnSelect;
//隐藏
@property(assign) NSString *InvoiceID; //ID
@property(assign) NSString *StepNo;
@property(assign) NSString *Status;

- (void) setCheckBackground: (BOOL) checked;

 @property(nonatomic) BOOL isSelect;
@property(nonatomic) int cellIndex;
@property(weak) id<WorkFlowCellDelegate> delegate;
-(void)ParseInfoModel:(WorkFlowInfoModel *)model;
@end
