//
//  SearchDateCell.h
//  IBOSS
//
//  Created by iHope on 14-6-17.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SearchDateCellHeight1 58.f
#define SearchDateCellHeight2 313.0f
@interface SearchDateCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UIImageView *arrowImageView;
@property(nonatomic,strong) IBOutlet UIControl * control;
@property(nonatomic,strong) IBOutlet UIControl * dateStartControl;
@property(nonatomic,strong) IBOutlet UIControl * dateEndControl;
@property(strong) IBOutlet UIView *dateStartView;
@property(strong) IBOutlet UIView *dateEndView;
@property(nonatomic, copy, setter = setIsOpen:) NSString *isOpen;
@property(weak) id delegate;
@property SEL refreshTableView;

@property(strong) IBOutlet UILabel *lblStartTime;
@property(strong) IBOutlet UILabel *lblEndTime;
@property(strong) IBOutlet UIDatePicker *dStartPick;
@property(strong) IBOutlet UIDatePicker *dEndPick;
@property(strong) IBOutlet UIImageView *seprateView;
          
@end
