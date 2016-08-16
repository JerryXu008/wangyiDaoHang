//
//  CustomerFollowUpVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerFollowUpVC.h"
#import "KeyBordVIew.h"
#import "ChartCell.h"
#import "FollowUpInfoModel.h"
@interface CustomerFollowUpVC ()
@property(strong) IBOutlet UIView* mainView;
@property(strong) IBOutlet UITableView *tableView;
@property(strong) UIImagePickerController *imagepicker ;
@property (nonatomic,assign) BOOL recording;
@property (nonatomic,strong) NSString *fileName;
@property (nonatomic,strong) AVAudioRecorder *recorder;
@property (nonatomic,strong) AVAudioPlayer *player;


//演示临时内容view
@property(strong) IBOutlet UIView *contentView;
//临时文本框
@property(strong) IBOutlet UITextView *txtView;
//临时照片
@property(strong) IBOutlet UIImageView *imagepic;
//临时音频
@property(strong) IBOutlet UIButton *btnRecord;
//当前播放文件名
@property(strong) NSString *curRecordFileName;



@property(strong) IBOutlet KeyBordVIew *keyBordView;
@end
static NSString *const cellIdentifier=@"FollowUpCell";
@implementation CustomerFollowUpVC
@synthesize keyBordView=_keyBordView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)savaData
{
   /* UIAlertView*alert = [[UIAlertView alloc]initWithTitle:@"提示"
                                                  message:@"保存成功！"
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    [alert show];*/
    FollowUpInfoModel *model=[FollowUpInfoModel new];
    model.title=_txtView.text;
    model.imgView= _imagepic.image;
    model.fileRecordName=_curRecordFileName;
    model.address=@"上地中关村";
   
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    //[dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    [dateFormater setDateFormat:@"MM-yy hh:mm"];
    NSString *time = [dateFormater stringFromDate:now];
    model.time=time;
    [self.parentVC.FollowUpArr addObject:model];
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)loadNavStyle
{
    //右边
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    // button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(savaData)
      forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0, 0, 40, 24);
    //button2.titleLabel.text=@"跟进";
    [button2 setTitle:@"确定" forState:UIControlStateNormal];
    [button2 setTitleColor:NavBarItemColor forState:UIControlStateNormal];
    //[ button2 setBackgroundImage:[UIImage imageNamed:@"xuan.png"]
        //              forState:UIControlStateNormal];
    UIBarButtonItem *menuButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = menuButton2;
    
    //返回
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
   button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
-(void)LoadLayOut
{
   //输入框
    self.keyBordView=[[KeyBordVIew alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
    self.keyBordView.delegate=self;
    [self.view addSubview:self.keyBordView];
    
   //显示视图
   /* self.tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-44-200) style:UITableViewStylePlain];
    [self.tableView registerClass:[ChartCell class] forCellReuseIdentifier:cellIdentifier];
    self.tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = NO;
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_bg_default.jpg"]];
  */
    self.contentView= [[UIView alloc] init];
    self.contentView.frame=CGRectMake(0, 200, self.view.frame.size.width, self.view.frame.size.height-44-200);
    self.contentView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_contentView];
    //演示文本框
    _txtView=[[UITextView alloc]init];
    _txtView.frame=CGRectMake(0, 0, self.view.frame.size.width, 150);
    _txtView.editable=NO;
    //_txtView.backgroundColor=[UIColor redColor];
    [_contentView addSubview:_txtView];
    //分割线
    UIImageView *image=[[UIImageView alloc] init];
    image.frame=CGRectMake(0, 160, self.view.frame.size.width, 1);
    image.image=[UIImage imageNamed:@"fengexian.png"];
    [_contentView addSubview:image];
    //演示照片
    _imagepic=[[UIImageView alloc] init];
    _imagepic.frame=CGRectMake(0, 165, 100, 100);
   // image.image=[UIImage imageNamed:@"fengexian.png"];
    _imagepic.backgroundColor=[UIColor whiteColor];
    [_contentView addSubview:_imagepic];
   
    image=[[UIImageView alloc] init];
    image.frame=CGRectMake(0, 270, self.view.frame.size.width, 1);
    image.image=[UIImage imageNamed:@"fengexian.png"];
    [_contentView addSubview:image];
    //演示录音按钮
    _btnRecord=[UIButton buttonWithType:UIButtonTypeCustom];
    _btnRecord.frame=CGRectMake(0, 275, 200, 30);
    [_btnRecord setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_btnRecord setBackgroundColor:[UIColor colorWithRed:109/255.0 green:148/255.0 blue:183/255.0 alpha:0.9]];
    [_btnRecord.layer setMasksToBounds:YES];
    [_btnRecord.layer setCornerRadius:5.0];
    [_btnRecord.layer setBorderWidth:0.0];
    [_btnRecord addTarget:self action:@selector(playRecord) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_btnRecord];
    // self.tableView.dataSource=self;
   // self.tableView.delegate=self;
   // [self.view addSubview:self.tableView];



}
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
    //播放
    NSString *filePath=[NSString documentPathWith:_curRecordFileName];
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
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.view.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
}
//keybordView Delegate
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledReturn:(UITextField *)textFiled
{
    _txtView.text=textFiled.text;
    textFiled.text=@"";
   /* ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int random=arc4random_uniform(2);
    NSLog(@"%d",random);
    chartMessage.icon=[NSString stringWithFormat:@"icon%02d.jpg",random+1];
    chartMessage.messageType=random;
    chartMessage.content=textFiled.text;
    cellFrame.chartMessage=chartMessage;
    
    [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    
    //滚动到当前行
    
    [self tableViewScrollCurrentIndexPath];
    textFiled.text=@"";*/
    
}
-(void)KeyBordView:(KeyBordVIew *)keyBoardView textFiledBegin:(UITextField *)textFiled
{
   // [self tableViewScrollCurrentIndexPath];
    
}
-(void)beginRecord
{
    if(self.recording)return;
    
    self.recording=YES;
    
    NSDictionary *settings=[NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithFloat:8000],AVSampleRateKey,
                            [NSNumber numberWithInt:kAudioFormatLinearPCM],AVFormatIDKey,
                            [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
                            [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsBigEndianKey,
                            [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                            nil];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: nil];
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    [dateFormater setDateFormat:@"yyyyMMddHHmmss"];
    NSString *fileName = [NSString stringWithFormat:@"rec_%@.wav",[dateFormater stringFromDate:now]];
    self.fileName=fileName;
    NSString *filePath=[NSString documentPathWith:fileName];
    NSURL *fileUrl=[NSURL fileURLWithPath:filePath];
    NSError *error;
    self.recorder=[[AVAudioRecorder alloc]initWithURL:fileUrl settings:settings error:&error];
    [self.recorder prepareToRecord];
    [self.recorder setMeteringEnabled:YES];
    [self.recorder peakPowerForChannel:0];
    [self.recorder record];
    
}
-(void)finishRecord
{
    self.recording=NO;
    [self.recorder stop];
    self.recorder=nil;
    
    [_btnRecord setTitle:self.fileName forState:UIControlStateNormal];
    _curRecordFileName=self.fileName;
    /* ChartCellFrame *cellFrame=[[ChartCellFrame alloc]init];
    ChartMessage *chartMessage=[[ChartMessage alloc]init];
    
    int random=arc4random_uniform(2);
    NSLog(@"%d",random);
    /*chartMessage.icon=[NSString stringWithFormat:@"icon%02d.jpg",random+1];
    chartMessage.messageType=random;
    chartMessage.content=self.fileName;
    cellFrame.chartMessage=chartMessage;
  //  [self.cellFrames addObject:cellFrame];
    [self.tableView reloadData];
    [self tableViewScrollCurrentIndexPath];
    */
}

-(void)LoadLocalImage
{
    _imagepicker = [[UIImagePickerController alloc]init];
    _imagepicker.delegate = self;
    //访问相册类型的类型
    //UIImagePickerControllerSourceTypePhotoLibrary,
    //UIImagePickerControllerSourceTypeCamera, =====  访问摄像头
    //UIImagePickerControllerSourceTypeSavedPhotosAlbum ======= 只能访问第一列的图片
    _imagepicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    //以摩擦动画的方式显示
    [self presentViewController:_imagepicker animated:YES completion:^{
        
    }];
}
-(void)TakePhoto
{
    BOOL isCamrma = [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
    if (!isCamrma) {
        NSLog(@"没有摄像头");
        return;
    }
    //摄像头
    _imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    //允许编辑
    _imagepicker.allowsEditing =YES;

}



#pragma mark - UIImagePickerControllerDelegate

//相册选中之后调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImagePickerControllerOriginalImage === 取原始图片
    //UIImagePickerControllerEditedImage === 去编辑以后的图片
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    _imagepic.image=image;
  
    [picker dismissViewControllerAnimated:YES completion:nil];
}
//取消按钮的点击事件
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
//将图片保存
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"error = %@",error);
}




- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"跟进";
    [self loadNavStyle];
    [self LoadLayOut];
    self.mainView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
