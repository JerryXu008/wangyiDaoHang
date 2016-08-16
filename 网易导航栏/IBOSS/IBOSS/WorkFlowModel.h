//
//  WorkFlowModel.h
//  IBOSS
//
//  Created by iHope on 14-7-9.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WorkFlowModel : NSObject
-(void)ParseWorkFlowArr:(NSArray *)arr;
@property(strong) NSMutableArray * workflowArr;
-(BOOL)updateCellChecked : (NSString *) checkDocId;
-(BOOL)IsSelectAtLeastOne;
-(BOOL)HasSameFlowCode;
-(NSArray *)CheckedArr;
@end
