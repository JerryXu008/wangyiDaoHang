//
//  NoteCell.h
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NoteCellHeight 175

@interface NoteCell : UITableViewCell
@property(nonatomic,strong) IBOutlet UILabel *lblTitle;
@property(nonatomic,strong) IBOutlet UITextView *txtView;
@property(nonatomic) CustomerManagerAddType type;
@end
