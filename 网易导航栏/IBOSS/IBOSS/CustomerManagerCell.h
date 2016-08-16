//
//  CustomerManagerCell.h
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerManagerCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *txtCustomerName;
@property(nonatomic,strong) IBOutlet UILabel *txtCustomerWay;
@property(nonatomic,strong) IBOutlet UILabel *txtPhone;
@property(nonatomic,strong) IBOutlet UILabel *txtDepartment;
@property(nonatomic,strong) IBOutlet UILabel *txtSalesman;
@property(nonatomic,strong) IBOutlet UILabel *txtAddress;

@property(nonatomic,strong) NSDictionary *dicInfo;
@property(nonatomic,strong) IBOutlet UIImageView *seperatImage;
@end
