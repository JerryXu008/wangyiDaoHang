//
//  WorkFlowModel.m
//  IBOSS
//
//  Created by iHope on 14-7-9.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "WorkFlowModel.h"
#import "WorkFlowInfoModel.h"
@implementation WorkFlowModel

-(id)init
{
    self =[super init];
    if(self){
        _workflowArr=[NSMutableArray new];
    }
    return self;
}

-(void)ParseWorkFlowArr:(NSArray *)arr
{
 if(arr!=nil)
 {   [_workflowArr removeAllObjects];
     for(int i=0;i<arr.count;i++)
     {
         NSDictionary * dic=arr[i];
         WorkFlowInfoModel *infoMode=[WorkFlowInfoModel new];
         [infoMode ParseDic:dic];
         [_workflowArr addObject:infoMode];
     }
 
 }
}
//获得选中的集合
-(NSArray *)CheckedArr
{
    NSMutableArray *tempArr=[NSMutableArray new];
    for(int i=0;i<_workflowArr.count;i++)
    {
        WorkFlowInfoModel *model= [_workflowArr objectAtIndex:i] ;
        if(model.isChecked){
            [tempArr addObject:model];
        }
    }
    return tempArr;
}
-(BOOL)HasSameFlowCode
{
    int count=1;
    NSString *curFlowCode=@"";
    NSMutableArray *tempArr=[NSMutableArray new];
    for(int i=0;i<_workflowArr.count;i++)
    {
        WorkFlowInfoModel *model= [_workflowArr objectAtIndex:i] ;
        if(model.isChecked){
            [tempArr addObject:model];
        }
    }

    if(tempArr.count>=2){
    if(tempArr.count>0)
    {
        WorkFlowInfoModel *model= [tempArr objectAtIndex:0] ;
        curFlowCode=model.FlowCode;
    }
    for(int i=1;i<tempArr.count;i++)
    {
       WorkFlowInfoModel *model= [tempArr objectAtIndex:i] ;
        if([curFlowCode isEqualToString:model.FlowCode]){
            count++;
        }
    }
        return (count==tempArr.count);
    }
    else
    {
        return YES;
    }
}



-(BOOL)IsSelectAtLeastOne
{
    BOOL s=NO;
    for(WorkFlowInfoModel *wf in _workflowArr) {
        if(wf.isChecked)
        {
            s=YES;
            break;
        }
    }
    return s;
}
-(BOOL)updateCellChecked : (NSString *) checkDocId
{
    for(WorkFlowInfoModel *wf in _workflowArr) {
      //  int i=[wf.InvoiceID intValue];
       // int j=[checkDocId intValue];
        if([wf.InvoiceID intValue]==[checkDocId intValue] ) {
            wf.isChecked = !wf.isChecked;
            return wf.isChecked;
        }
    }
    

    return NO;
    
}

@end
