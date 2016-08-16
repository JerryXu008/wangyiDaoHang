//
//  Created by xujinlei on 13-6-16.
//  Copyright (c) 2013年 xujinlei. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class BRDatePickerView;





typedef void (^XYPickerAlertRowSelectionBlock)(NSString *date);
typedef void (^XYPickerAlertCompletionBlock)(void);
typedef void (^XYPickerAlertCancelBlock)(void);

@interface BRDatePickerView : UIView


@property (nonatomic, strong) XYPickerAlertRowSelectionBlock selectionBlock;
@property (nonatomic, strong) XYPickerAlertCompletionBlock completionBlock;
@property (nonatomic, strong) XYPickerAlertCancelBlock cancelBlock;


-(void)configureSelectionBlock:(XYPickerAlertRowSelectionBlock)selBlock andCompletionBlock:(XYPickerAlertCompletionBlock)competionBlock andCancelBlock:(XYPickerAlertCancelBlock) cancelBlock;






+(BRDatePickerView *)PickerAlertWithTitle:(NSString *)title;

-(id)initWithTitle:(NSString *)title;

// Show the alert
-(void)show;
@end
