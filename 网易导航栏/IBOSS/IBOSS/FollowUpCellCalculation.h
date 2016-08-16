//
//  FollowUpCellCalculation.h
//  IBOSS
//
//  Created by iHope on 14-6-20.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FollowUpInfoModel;
@interface FollowUpCellCalculation : NSObject
@property(strong)UIView * FinalView;
-(BOOL)assembleMessageViewWithMessage: (NSString *) message;
+ (CGFloat) getViewHeight:(FollowUpInfoModel *)followModel;
@end
