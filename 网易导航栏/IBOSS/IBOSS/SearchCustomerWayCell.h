//
//  SearchCustomerWayCell.h
//  IBOSS
//
//  Created by iHope on 14-6-17.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SearchCustomerWayCellHeight2 258.0f
#define SearchCustomerWayCellHeight1 58.f
@interface SearchCustomerWayCell : UITableViewCell<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong) IBOutlet UIImageView *arrowImageView;
@property(nonatomic,strong) IBOutlet UIControl * control;
@property(nonatomic, copy, setter = setIsOpen:) NSString *isOpen;
@property(weak) id delegate;
@property SEL refreshTableView;
@property(strong) IBOutlet UITableView *tableView;
@end
