//
//  FollowUpInfoModel.h
//  IBOSS
//
//  Created by iHope on 14-6-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FollowUpInfoModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong) UIImage *imgView;
@property(nonatomic,copy) NSString *fileRecordName;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *time;
@end
