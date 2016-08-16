//
//  SearchCustomerWayCell.m
//  IBOSS
//
//  Created by iHope on 14-6-17.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "SearchCustomerWayCell.h"
#import "CustomerWayCategoryCell.h"
@interface SearchCustomerWayCell()
@property(strong) NSArray *infoArr;
@property(strong) NSMutableArray *cellArr;
@end
@implementation SearchCustomerWayCell
@synthesize infoArr;
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
        
    
}
-(void)headerClick1:(id)sender{
    [self rotateArrowImage];
    if([self.delegate respondsToSelector:@selector(refreshTableView)])
    {
        [self.delegate performSelector:@selector(refreshTableView) withObject:nil afterDelay:0.0 ];
    }
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.infoArr=@[@"小区",@"渠道",@"周边",@"渠道"];
    [self LoadView];
    self.cellArr=[[NSMutableArray alloc]initWithArray:@[@"0",@"0",@"0",@"0"]];
    
    
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




-(void)layoutSubviews
{
    [super layoutSubviews];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self LoadView];

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark- UITableView delegate
#pragma mark dataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int rowindex=indexPath.row;
    NSString *name=[self.infoArr objectAtIndex:indexPath.row];
    CustomerWayCategoryCell* Cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (Cell == nil) {
        Cell = [[CustomerWayCategoryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    Cell.textLabel.text =name;
    if([self.cellArr[rowindex] isEqualToString:@"1"])
    {
        Cell.leftView.hidden=NO;
        Cell.contentView.backgroundColor=[UIColor grayColor];
    }
    else
    {
        Cell.leftView.hidden=YES;
         Cell.contentView.backgroundColor=[UIColor whiteColor];
    }
    return Cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
  // CustomerWayCategoryCell* Cell=  [tableView cellForRowAtIndexPath:indexPath];
   // Cell.IsSelected=YES;
    int rowindex=indexPath.row;
    for(int i=0;i<self.cellArr.count;i++)
    {
       if(rowindex==i)
       self.cellArr[i]=@"1";
       else
       self.cellArr[i]=@"0";
    }
    
    [tableView reloadData];
    
    
}


@end
