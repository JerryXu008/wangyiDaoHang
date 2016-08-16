//
//  FollowUpCellView.h
//  IBOSS
//
//  Created by iHope on 14-6-18.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FollowUpInfoModel.h"
@interface FollowUpCellView : UIView


@property (retain, nonatomic) UIView *view;

@property(nonatomic,strong) UIView *txtViewTitle;
//@property(nonatomic,strong)UILabel *lblTitle;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIButton *messageView;
@property(nonatomic,strong) UIView *locationView;
@property(nonatomic,strong) UILabel *lblTime;
//分割线
@property(nonatomic,strong) UIImageView *seperaView;
//底部阴影
@property(nonatomic,strong) UIImageView *topShadow;

@property(nonatomic,strong) FollowUpInfoModel * followModel;
+ (CGFloat) getViewHeight:(FollowUpInfoModel *)model;

@property (nonatomic, readwrite, strong) NSMutableSet *calculations;
-(void)Draw;
@end
