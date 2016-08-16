//
//  HomeView.m
//  ShowProduct
//
//  Created by lin on 14-5-22.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import "HomeView.h"



#define MENUHEIHT 40

@implementation HomeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self commInit];
    }
    return self;
}

#pragma mark UI初始化
-(void)commInit{
    NSArray *vButtonItemArray = @[@{
                                    TITLEKEY:@"未读",
                                    TITLEWIDTH:[NSNumber numberWithFloat:160]
                                    },
                                  @{
                                    TITLEKEY:@"已读",
                                    TITLEWIDTH:[NSNumber numberWithFloat:160]
                                    }
                                                                                                    ];
    
    if (mMenuHriZontal == nil) {
        mMenuHriZontal = [[MenuHrizontal alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, MENUHEIHT) ButtonItems:vButtonItemArray];
        mMenuHriZontal.delegate = self;
        
    }
   
    
    
    
    //初始化滑动列表
    if (mScrollPageView == nil) {
        mScrollPageView = [[ScrollPageView alloc] initWithFrame:CGRectMake(0, MENUHEIHT, self.frame.size.width, self.frame.size.height-MENUHEIHT-44 )];
        mScrollPageView.delegate = self;
    }
    [mScrollPageView setContentOfTables:vButtonItemArray.count];
    //默认选中第一个button
    [mMenuHriZontal clickButtonAtIndex:0];
    //-------
    [self addSubview:mScrollPageView];
    [self addSubview:mMenuHriZontal];
}

#pragma mark 内存相关
-(void)dealloc{
    mMenuHriZontal = nil;
    mScrollPageView = nil;
   
}

#pragma mark - 其他辅助功能
#pragma mark MenuHrizontalDelegate
-(void)didMenuHrizontalClickedButtonAtIndex:(NSInteger)aIndex{
   // NSLog(@"第%d个Button点击了",aIndex);
    [mScrollPageView moveScrollowViewAthIndex:aIndex];
}

#pragma mark ScrollPageViewDelegate
-(void)didScrollPageViewChangedPage:(NSInteger)aPage{
    //NSLog(@"CurrentPage:%d",aPage);
    [mMenuHriZontal changeButtonStateAtIndex:aPage];
//    if (aPage == 3) {
        //刷新当页数据
        [mScrollPageView freshContentTableAtIndex:aPage];
//    }
}


@end
