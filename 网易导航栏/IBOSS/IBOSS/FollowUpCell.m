//
//  FollowUpCell.m
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "FollowUpCell.h"
#import "Util.h"
#import "UILabel+VerticalAlign.h"
#import "MBProgressHUD.h"
@interface FollowUpCell()
@property (nonatomic,strong) AVAudioPlayer *player;
@end
@implementation FollowUpCell
//@synthesize lblTitle=_lblTitle;
- (void)prepareForReuse {
    //[self.calculations makeObjectsPerformSelector:@selector(cancel)];
    [self.cellView.calculations removeAllObjects];
    
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       // [self LoadSubView];
      /*  CGRect frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        frame.size.height=300;
        self.frame=frame;*/
        _followModel=[FollowUpInfoModel new];
        [self LoadUI];
      
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
   // _cellView.followModel=_followModel;
   // [_cellView setNeedsLayout];
}
-(void)LoadUI
{
    if(self.cellView==nil)
    {
   
    _cellView = [[FollowUpCellView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
        _cellView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.contentView addSubview:_cellView];
 
   
    }
}
/**********************************test****************************/
-(void)DrawView{

     _cellView.followModel=_followModel;
     //[_cellView setNeedsLayout];
    [_cellView Draw];
}

















/**********************************test****************************/





-(void)initPlayer{
    //初始化播放器的时候如下设置
    UInt32 sessionCategory = kAudioSessionCategory_MediaPlayback;
    AudioSessionSetProperty(kAudioSessionProperty_AudioCategory,
                            sizeof(sessionCategory),
                            &sessionCategory);
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //默认情况下扬声器播放
    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    [audioSession setActive:YES error:nil];
    audioSession = nil;
}

-(void)playRecord
{
    if(self.player.isPlaying){
        
        [self.player stop];
    }
    NSString *filename=self.followModel.fileRecordName;
    //播放
    NSString *filePath=[NSString documentPathWith:filename];
    //查找文件是否存在
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:filePath isDirectory:NO]&&![filename isEqualToString:@""]){
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
   [self initPlayer];
    NSError *error;
    self.player=[[AVAudioPlayer alloc]initWithContentsOfURL:fileUrl error:&error];
    [self.player setVolume:1];
    [self.player prepareToPlay];
    [self.player setDelegate:self];
    [self.player play];
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    }
    else
    {
     UIView *view=[[self superview] superview];
     MBProgressHUD*   HUD = [[MBProgressHUD alloc] initWithView:view];
        [view addSubview:HUD];
        HUD.labelText = @"录音文件不存在";
        HUD.mode = MBProgressHUDModeText;
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(2);
        } completionBlock:^{
            [HUD removeFromSuperview];
           
           
        }];
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
