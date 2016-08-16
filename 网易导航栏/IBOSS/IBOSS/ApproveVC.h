//
//  ApproveVC.h
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ApproveVC : BaseViewController
@property(strong) IBOutlet UIView *SelectView;
@property(strong) IBOutlet UIView *OutView;
@property(strong) IBOutlet UIView *TextView;
@property(strong) IBOutlet UITextView *txtView;
@property(nonatomic,strong) NSMutableArray * selectArr;
@property(assign,nonatomic) NSString *flowCode;
@property(weak,nonatomic) id ParentVC;
@end
