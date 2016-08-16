//
//  CustomerManaView.h
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerManaView : UIView<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)IBOutlet UISearchBar* searchBar;
@property(nonatomic,strong) IBOutlet UIView *menuView;
@end
