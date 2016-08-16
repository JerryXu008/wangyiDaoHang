//
//  WorkFlowInfoModel.h
//  IBOSS
//
//  Created by iHope on 14-7-9.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkFlowInfoModel : NSObject
@property(strong) NSString * InvoiceNo;
@property(strong) NSString * AuditTypeName;
@property(strong) NSString * CreateTime;
@property(strong) NSString * AuditReason;
@property(strong) NSString * CreateUserName;
@property(strong) NSString * Remarks;

@property(strong) NSString *InvoiceID; //ID
@property(strong) NSString *StepNo;
@property(strong) NSString *Status;
@property(strong) NSString *FlowCode;
@property(nonatomic) BOOL isChecked;

-(void)ParseDic:(NSDictionary *)dic;
//@property(nonatomic,strong) NSDictionary *dicInfo;
@end
