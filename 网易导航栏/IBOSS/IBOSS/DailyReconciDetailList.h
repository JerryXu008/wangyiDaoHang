//
//  DailyReconciDetailList.h
//  IBOSS
//
//  Created by iHope on 14-7-10.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DailyReconciDetailList  : BaseViewController

@property(copy) NSString * OrganizationCodestr;//业务部门Code
@property(copy) NSString *AccountDateFromstr;//财务日期开始
@property(copy) NSString *AccountDateTostr;//财务日期结束
@property(copy) NSString *BusinessTypestr;//业务类型
@end
