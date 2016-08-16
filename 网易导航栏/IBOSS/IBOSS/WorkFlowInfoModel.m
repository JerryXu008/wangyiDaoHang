//
//  WorkFlowInfoModel.m
//  IBOSS
//
//  Created by iHope on 14-7-9.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "WorkFlowInfoModel.h"

@implementation WorkFlowInfoModel
-(void)ParseDic:(NSDictionary *)dic
{
    if(dic!=nil){
        _InvoiceNo=[dic objectForKey:@"InvoiceNo"];
        _AuditTypeName=[dic objectForKey:@"AuditTypeName"];
        _CreateTime=[dic objectForKey:@"CreateTime"];
        _AuditReason=[dic objectForKey:@"AuditReason"];
        _CreateUserName=[dic objectForKey:@"CreateUserName"];
        _Remarks=[dic objectForKey:@"Remarks"];
        _InvoiceID=[dic objectForKey:@"InvoiceID"];
        _StepNo=[dic objectForKey:@"StepNo"];
        _Status=[dic objectForKey:@"Status"];
        _FlowCode=[dic objectForKey:@"FlowCode"];

        _isChecked=NO;
    }
    
}
-(void)setDicInfo:(NSDictionary *)dicInfo
{}
@end
