//
//  RadioButton.m
//  RadioButton
//
//  Created by xjl on 2013-6-6.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "RadioButton.h"

@interface RadioButton()
-(void)defaultInit;
-(void)otherButtonSelected:(id)sender;
-(void)handleButtonTap:(id)sender;
@end

@implementation RadioButton

@synthesize groupId=_groupId;
@synthesize index=_index;
@synthesize  Width;
@synthesize Height;
@synthesize title=_title;
@synthesize titleColor=_titleColor;
@synthesize isChecked=_isChecked;
//static const NSUInteger kRadioButtonWidth=80;
//static const NSUInteger kRadioButtonHeight=22;
static const NSUInteger kRadioButtonWidth=76;
static const NSUInteger kRadioButtonHeight=33;

static NSMutableArray *rb_instances=nil;
static NSMutableDictionary *rb_observers=nil;

#pragma mark - Observer

+(void)addObserverForGroupId:(NSString*)groupId observer:(id)observer{
    if(!rb_observers){
        rb_observers = [[NSMutableDictionary alloc] init];
    }
    
    if ([groupId length] > 0 && observer) {
        [rb_observers setObject:observer forKey:groupId];
        
    }
}

#pragma mark - Manage Instances

+(void)registerInstance:(RadioButton*)radioButton{
    if(!rb_instances){
        rb_instances = [[NSMutableArray alloc] init];
    }
    [rb_instances addObject:radioButton];
    
}

#pragma mark - Class level handler

+(void)buttonSelected:(RadioButton*)radioButton{
    
    // 通知对象，触发事件
    if (rb_observers) {
        id observer= [rb_observers objectForKey:radioButton.groupId];
        
        if(observer && [observer respondsToSelector:@selector(radioButtonSelectedAtIndex:inGroup:)]){
            [observer radioButtonSelectedAtIndex:radioButton.index inGroup:radioButton.groupId];
        }
    }
    
    //同一组的其他单选框不选择
    if (rb_instances) {
        for (int i = 0; i < [rb_instances count]; i++) {
            RadioButton *button = [rb_instances objectAtIndex:i];
            if (![button isEqual:radioButton] && [button.groupId isEqualToString:radioButton.groupId]) {
                [button otherButtonSelected:radioButton];
            }
        }
    }
}

#pragma mark - Object Lifecycle

-(id)initWithGroupId:(NSString*)groupId index:(NSUInteger)index{
    self = [self init];
    if (self) {
        _groupId = groupId;
        _index = index;
    }
    return  self;
}

- (id)init{
    self = [super init];
    if (self) {
        [self defaultInit];
    }
    return self;
}

#pragma mark - 设置是否选中
-(void)setChecked:(BOOL)check
{
    if(check)
        [_button setSelected:YES];
    else
        [_button setSelected:NO];
    
    [RadioButton buttonSelected:self];
}
-(BOOL)isChecked
{
    return [_button isSelected];
}
#pragma mark - Tap handling

-(void)handleButtonTap:(id)sender{
    [_button setSelected:YES];
    [RadioButton buttonSelected:self];
}

-(void)otherButtonSelected:(id)sender{
    
    if(_button.selected){
        [_button setSelected:NO];
    }
}
#pragma mark - 文本设置
-(void)setTitle:(NSString *)title
{
    _title=title;
    [_button setTitle:_title forState:UIControlStateNormal];
    [_button setTitle:_title forState:UIControlStateHighlighted];
    [_button setTitle:_title forState:UIControlStateSelected];
}
-(void)setTItleColor:(UIColor*)color
{
    _titleColor=[[UIColor alloc] initWithCGColor:color.CGColor];
    [_button setTitleColor:_titleColor forState:UIControlStateNormal];
    [_button setTitleColor:_titleColor forState:UIControlStateHighlighted];
    [_button setTitleColor:_titleColor forState:UIControlStateSelected];
    
}
#pragma mark - RadioButton init

-(void)defaultInit{
    self.userInteractionEnabled=YES;
    Width=kRadioButtonWidth;
    Height=kRadioButtonHeight;
    // Setup container view
    self.frame = CGRectMake(0, 0, kRadioButtonWidth, kRadioButtonHeight);
    //  self.frame = CGRectMake(0, 0, 300, 300);
    //  self.backgroundColor=[UIColor greenColor];
    //UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    // Customize UIButton
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(0, 0,kRadioButtonWidth, kRadioButtonHeight);
    // _button.adjustsImageWhenHighlighted = NO;
    // _button.backgroundColor=[UIColor redColor];
    [_button setBackgroundImage:[UIImage imageNamed:@"unselect.png"] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageNamed:@"select.png"] forState:UIControlStateSelected];
    
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_button setTitleColor:[[UIColor alloc] initWithRed:2/255.0 green:49/255.0 blue:101/255.0 alpha:1.0]
                  forState:UIControlStateSelected];
    //[_button setFont:[UIFont systemFontOfSize:13]];
    _button.titleLabel.font = [UIFont systemFontOfSize: 13.0];
    [_button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:_button];
    
    [RadioButton registerInstance:self];
}


@end
