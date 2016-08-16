//
//  LogManagerVC.h
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogManagerVC : UIViewController
@property(strong,nonatomic) IBOutlet UIButton *testButton;
@property(strong,nonatomic) IBOutlet UIButton *test2Button;
-(IBAction)gotoDetail:(id)sender;
@end
