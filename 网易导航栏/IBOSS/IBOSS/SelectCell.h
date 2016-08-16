//
//  SelectCell.h
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SELECTCELLHEIGHT 40
@interface SelectCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *lblTitle;
@property(nonatomic,strong) IBOutlet UILabel *lblContent;
@property(nonatomic) CustomerManagerAddType type;

@end
