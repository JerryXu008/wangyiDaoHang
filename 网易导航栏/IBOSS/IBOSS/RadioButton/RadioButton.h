//
//  RadioButton.h
//  RadioButton
//
//  Created by xjl on 2013-6-6.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RadioButtonDelegate <NSObject>
-(void)radioButtonSelectedAtIndex:(NSUInteger)index inGroup:(NSString*)groupId;
@end

@interface RadioButton : UIView {
    NSString *_groupId;
    NSUInteger _index;
    UIButton *_button;
}
@property(nonatomic,retain)NSString *groupId;
@property(nonatomic,assign)NSUInteger index;

//@property(nonatomic,assign)UIButton *_button;
@property(nonatomic) NSUInteger Width;
@property(nonatomic) NSUInteger Height;
@property(nonatomic) NSString *title;
@property(nonatomic) UIColor *titleColor;
@property(nonatomic,readonly) BOOL isChecked;
-(id)initWithGroupId:(NSString*)groupId index:(NSUInteger)index;
+(void)addObserverForGroupId:(NSString*)groupId observer:(id)observer;
-(void)setChecked:(BOOL)check;
@end
