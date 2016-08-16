//
//  MessageVC.m
//  IBOSS
//
//  Created by iHope on 14-7-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "MessageVC.h"
#import "HomeView.h"
@interface MessageVC (){
    HomeView *mHomeView;
}
@end

@implementation MessageVC

- (id) initWithNibName:(NSString *)aNibName bundle:(NSBundle *)aBuddle {
    self = [super initWithNibName:aNibName bundle:aBuddle];
    if (self != nil) {
     //   [self initCommonData];
      //  [self initTopNavBar];
    }
    return self;
}

//主要用来方向改变后重新改变布局
- (void) setLayout: (BOOL) aPortait {
    
    [self setViewFrame];
}

//重载导航条
-(void)initTopNavBar{
   
    self.navigationItem.leftBarButtonItem = Nil;
}

-(void)viewDidLoad{
    self.view.backgroundColor=[UIColor whiteColor];
    [self initView];
}

//初始化数据
-(void)initCommonData{
    
}

/*#if __has_feature(objc_arc)
#else
// dealloc函数
- (void) dealloc {
    [mHomeView release];
    [super dealloc];
}
#endif
*/
// 初始View
- (void) initView {
    
    if (IOS_7) {
        self.edgesForExtendedLayout =UIRectEdgeNone ;
    }
    //contentView大小设置
    int vWidth = (int)([UIScreen mainScreen].bounds.size.width);
    int vHeight = (int)([UIScreen mainScreen].bounds.size.height);
    //contentView大小设置
    
    CGRect vViewRect = CGRectMake(0, 0, vWidth, vHeight -44 -20);
    UIView *vContentView = [[UIView alloc] initWithFrame:vViewRect];
    if (mHomeView == nil) {
        mHomeView = [[HomeView alloc] initWithFrame:vContentView.frame];
    }
    [vContentView addSubview:mHomeView];
    
    self.view = vContentView;
    
    [self setViewFrame];
   
}

//设置View方向
-(void) setViewFrame{
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

//------------------------------------------------

@end
