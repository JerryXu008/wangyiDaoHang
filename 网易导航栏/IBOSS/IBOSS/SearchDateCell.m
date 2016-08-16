//
//  SearchDateCell.m
//  IBOSS
//
//  Created by iHope on 14-6-17.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "SearchDateCell.h"

@implementation SearchDateCell
@synthesize arrowImageView=_arrowImageView;
@synthesize control=_control;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)LoadView
{
    if(self.arrowImageView==nil){
        self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(280, 14, 30, 30)];
        self.arrowImageView.image = [UIImage imageNamed:@"group_table_header_arrow.png"];
        [self addSubview:_arrowImageView];
    }
    if(self.control==nil){
        self.control = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 58)];
        [_control addTarget:self action:@selector(headerClick1:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_control];
    }
    if(self.dateStartControl==nil){
        self.dateStartControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [self.dateStartControl addTarget:self action:@selector(filterStartDate) forControlEvents:UIControlEventTouchUpInside];
        [self.dateStartView addSubview:self.dateStartControl];
    }
    if(self.dateEndControl==nil){
        self.dateEndControl =[[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
        [self.dateEndControl addTarget:self action:@selector(filterEndDate) forControlEvents:UIControlEventTouchUpInside];
        [self.dateEndView addSubview:self.dateEndControl];
    }
    

}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self LoadView];
    
   // _dStartPick.hidden=YES;
    _dEndPick.hidden=YES;
    
    [_dEndPick addTarget:self action:@selector(dateEndPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
     [_dStartPick addTarget:self action:@selector(dateStartPickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_dStartPick setDatePickerMode:UIDatePickerModeDate];
    [_dEndPick setDatePickerMode:UIDatePickerModeDate];
    //时间
    [self getDateTime];

    
}
-(void)dateStartPickerValueChanged:(id)sender
{
    
    NSDate *start=[_dStartPick date];
	// 创建一个日期格式器
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	// 为日期格式器设置格式字符串
	[dateFormatter setDateFormat:@"yyyy-MM月dd日"];
	// 使用日期格式器格式化日期、时间
	NSString *destDateString = [dateFormatter stringFromDate:start];
    _lblStartTime.text=destDateString;
    
}

-(void)dateEndPickerValueChanged:(id)sender
{
    
     NSDate *end=[_dEndPick date];
	// 创建一个日期格式器
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	// 为日期格式器设置格式字符串
	[dateFormatter setDateFormat:@"yyyy-MM月dd日"];
	// 使用日期格式器格式化日期、时间
	NSString *destDateString = [dateFormatter stringFromDate:end];
   _lblEndTime.text=destDateString;

}

-(void)getDateTime
{
    NSDate *start = [_dStartPick date];
    NSDate *end=[_dEndPick date];
	// 创建一个日期格式器
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	// 为日期格式器设置格式字符串
	[dateFormatter setDateFormat:@"yyyy-MM月dd日"];
	// 使用日期格式器格式化日期、时间
	NSString *destDateString = [dateFormatter stringFromDate:start];
    _lblStartTime.text=destDateString;
    destDateString=[dateFormatter stringFromDate:end];
    _lblEndTime.text=destDateString;

    
}
-(void)filterStartDate
{
    if(_dStartPick.hidden==YES&&_dEndPick.hidden==NO){
    _dStartPick.hidden=NO;
    _dEndPick.hidden=YES;
    //其余坐标变化
   CGRect frame= _dateEndView.frame;
   CGRect frame2=_dEndPick.frame;
   CGRect frame3=_seprateView.frame;
    _dateEndView.frame=CGRectMake(frame.origin.x, frame.origin.y+162.0, frame.size.width, frame.size.height);
    _dEndPick.frame=CGRectMake(frame2.origin.x, frame2.origin.y+162.0, frame2.size.width, frame2.size.height);
   _seprateView.frame=CGRectMake(frame3.origin.x, frame3.origin.y+162.0, frame3.size.width, frame3.size.height);
    }
    
   /* if([self.delegate respondsToSelector:@selector(refreshTableView)])
    {
        [self.delegate performSelector:@selector(refreshTableView) withObject:nil afterDelay:0.1 ];
    }*/

}
-(void)filterEndDate
{
    if(_dStartPick.hidden==NO&&_dEndPick.hidden==YES){
    _dStartPick.hidden=YES;
    _dEndPick.hidden=NO;
    //其余坐标变化
    CGRect frame= _dateEndView.frame;
    CGRect frame2=_dEndPick.frame;
    CGRect frame3=_seprateView.frame;
    _dateEndView.frame=CGRectMake(frame.origin.x, frame.origin.y-162.0, frame.size.width, frame.size.height);
    _dEndPick.frame=CGRectMake(frame2.origin.x, frame2.origin.y-162.0, frame2.size.width, frame2.size.height);
    _seprateView.frame=CGRectMake(frame3.origin.x, frame3.origin.y-162.0, frame3.size.width, frame3.size.height);
    }
   /* if([self.delegate respondsToSelector:@selector(refreshTableView)])
    {
        [self.delegate performSelector:@selector(refreshTableView) withObject:nil afterDelay:0.1 ];
    }*/


}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self LoadView];
    _dEndPick.hidden=YES;
    _dStartPick.hidden=NO;
    
    
}
-(void)headerClick1:(id)sender{
    [self rotateArrowImage];
    if([self.delegate respondsToSelector:@selector(refreshTableView)])
    {
        [self.delegate performSelector:@selector(refreshTableView) withObject:nil afterDelay:0.0 ];
    }
}

-(void)rotateArrowImage{
    //如果已经展开,收缩
    if([_isOpen isEqualToString:@"1"]){
        [UIView animateWithDuration:0.2 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(0 / 180.0 * M_PI );
        }];
        _isOpen = @"0";
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            self.arrowImageView.transform = CGAffineTransformMakeRotation(90 / 180.0 * M_PI );
        }];
        _isOpen = @"1";
    }
}
-(void)setIsOpen:(NSString *)aIsOpen{
    _isOpen = aIsOpen;
    if([_isOpen isEqualToString:@"1"]){
        self.arrowImageView.transform = CGAffineTransformMakeRotation(90 / 180.0 * M_PI );
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
