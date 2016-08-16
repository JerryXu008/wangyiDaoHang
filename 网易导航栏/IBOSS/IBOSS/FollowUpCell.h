//
//  FollowUpCell.h
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "FollowUpInfoModel.h"

#import "FollowUpCellView.h"
@interface FollowUpCell : UITableViewCell<AVAudioPlayerDelegate>


@property(strong)FollowUpCellView *cellView;
@property(nonatomic,strong) FollowUpInfoModel * followModel;
-(void)DrawView;

@end
