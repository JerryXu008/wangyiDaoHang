//
//  CustomerReportCreateVC.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomerReportCreateViewCell.h"
#import "NoteCell.h"
#import "SelectCell.h"
#import "TextCell.h"
#import "SeprateCell.h"
@interface CustomerReportCreateVC :UITableViewController
@property(nonatomic,strong) IBOutlet SelectCell *customerWayCell;
@property(nonatomic,strong) IBOutlet TextCell *customerNameCell;
@property(nonatomic,strong) IBOutlet SelectCell *customerPropotyCell;
@property(nonatomic,strong) IBOutlet TextCell *MegPhoneCell;
@property(nonatomic,strong) IBOutlet TextCell *MegPersonlCell;
@property(nonatomic,strong) IBOutlet TextCell *MegMobilePhoneCell;
@property(nonatomic,strong) IBOutlet SelectCell *DepartmentCell;
@property(nonatomic,strong) IBOutlet SelectCell *SaleManCell;
@property(nonatomic,strong) IBOutlet SelectCell *MidCustomerCell;
@property(nonatomic,strong) IBOutlet SelectCell *MidEmployeeCell;
@property(nonatomic,strong) IBOutlet TextCell *RoomAreaCell;
@property(nonatomic,strong) IBOutlet TextCell *ProgressCell;
@property(nonatomic,strong) IBOutlet TextCell *AddressCell;
@property(nonatomic,strong) IBOutlet NoteCell *NoteInfoCell;

@property(nonatomic,strong) IBOutlet SeprateCell *SeprateCell1;
@property(nonatomic,strong) IBOutlet SeprateCell *SeprateCell2;

@end
