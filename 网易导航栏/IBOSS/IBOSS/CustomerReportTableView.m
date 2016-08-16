//
//  CustomerReportTableView.m
//  IBOSS
//
//  Created by iHope on 14-6-18.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerReportTableView.h"
#import "FollowUpInfoModel.h"
#import "FollowUpCell.h"
#import "FollowUpCellView.h"
@implementation CustomerReportTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

 // tableview-delegate
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 return 1;
 }
 
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     return [self.dataArray count];
    // return 15;
 }
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
 {
    FollowUpInfoModel *tweetmodel = [self.dataArray objectAtIndex:indexPath.row];
     return [FollowUpCellView getViewHeight:tweetmodel];
    // return 200;
 }
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"FollowUpCell";
    
    
    FollowUpCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell=[[FollowUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // int rowIndex=indexPath.row;
    FollowUpInfoModel *model=[self.dataArray objectAtIndex:indexPath.row];
    
    cell.followModel=model;
  /*  cell.txtViewTitle.text=model.title;
    cell.imageView.image=model.imgView;
    ((UILabel *)[cell.messageView viewWithTag:1002]).text=@"24''" ;
    ((UILabel *)[cell.locationView viewWithTag:1003]).text=model.address ;
    cell.lblTime.text=model.time;
    cell.followModel=model;*/
    // [cell.messageView setTitle:@"24" forState:UIControlStateNormal];
    //int rowIndex=indexPath.row;
    // NSDictionary *dic=[self.reportArr objectAtIndex:rowIndex];
    [cell DrawView];
    return cell;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
