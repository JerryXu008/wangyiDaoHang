//
//  TextCell.h
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define  txtCellHeight 40
@interface TextCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *lblTitle;
@property(nonatomic,strong) IBOutlet UITextField *txtContent;
@property(nonatomic) CustomerManagerAddType type;
@property(nonatomic,copy) NSString * txtPlace;
@end
