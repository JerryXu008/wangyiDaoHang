//
//  MoreReportCell.h
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreReportCell : UITableViewCell
@property(nonatomic, copy, setter = setIsOpen:) NSString *isOpen;
@property(weak) id delegate;
@property SEL refreshTableView;
@property SEL gokucun;
@property SEL gorijie;

@end
