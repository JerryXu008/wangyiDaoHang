//
//  WorkFlowVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "WorkFlowVC.h"
#import "WorkFlowViewCell.h"
#import "ApproveVC.h"
#import "ASIDownManager.h"
#import "WorkFlowModel.h"
#import "WorkFlowInfoModel.h"
@interface WorkFlowVC ()
@property(nonatomic,strong) NSMutableArray * flowArr;
@property(nonatomic,strong) NSDictionary*flowDic;
@property(nonatomic,strong) ASIDownManager *mDownManager;
@property(nonatomic,strong) WorkFlowModel *wfModel;

@property(nonatomic,strong) RefreshTableView *vCustomTableView;

@end

@implementation WorkFlowVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)reloadData
{
   // [self showLoading];
    [self StartLoading];
    self.flowArr=[[NSMutableArray alloc]init];
    NSString *urlStr = ServerURL;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
   
    [dict setObject:@"GetAuditList" forKey:@"Action"];
   
    [dict setObject:[NSString stringWithFormat:@"%@",kkAccountCode]forKey:@"AccountCode"];
    [dict setObject:kkUserCode forKey:@"UserCode"];
    [dict setObject:kkUserPwd forKey:@"UserPassword"];
    [dict setObject:kkSessionKey forKey:@"SessionKey"];
    
    self.mDownManager = [[ASIDownManager alloc] init];
    self.mDownManager = [[ASIDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
   

    
    [_mDownManager PostHttpRequest:urlStr :dict :nil :nil];
  }
-(void)shenpi
{
    if(![_wfModel IsSelectAtLeastOne])
    {
        [self showAlertViewText:@"至少选择一条审批内容"];
        return;
    }
    if(![_wfModel HasSameFlowCode])//审批类型不一致
    {
        [self showAlertViewText:@"选择的单据审批类型不一致"];
        
        return;
    }
    self.hidesBottomBarWhenPushed=YES;
    ApproveVC *detailVC=[[ApproveVC alloc] initWithNibName:@"ApproveView" bundle:nil];
    NSArray *checkeArr=[_wfModel CheckedArr];
    detailVC.selectArr=[checkeArr mutableCopy];
    WorkFlowInfoModel *model=checkeArr[0];
    detailVC.flowCode=model.FlowCode;
    detailVC.ParentVC=self;
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}
-(void) LoadNavStyle
{
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    // button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(shenpi)
      forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0, 0, 40, 24);
    //button2.titleLabel.text=@"跟进";
    [button2 setTitle:@"审批" forState:UIControlStateNormal];
    [button2 setTitleColor:NavBarItemColor forState:UIControlStateNormal];
    UIBarButtonItem *menuButton2 = [[UIBarButtonItem alloc] initWithCustomView:button2];
    self.navigationItem.rightBarButtonItem = menuButton2;
   

}
//cell 回調方法
-(void) btnCheckPressed:(WorkFlowViewCell *)cell
{
    
    BOOL checked = [self.wfModel updateCellChecked:cell.InvoiceID];
    [cell setCheckBackground:checked];
  
    
}



- (void)OnLoadFinish:(ImageDownManager *)sender {
    
    NSDictionary *dic = [sender.mWebStr JSONValue];
    NSLog(@"dic=%@",dic);
    [self Cancel];
    if (dic && [dic isKindOfClass:[NSDictionary class]]) {
        int iStatus = [[dic objectForKey:@"Status"] intValue];
        NSString *message=[dic objectForKey:@"Message"];
        
        if (iStatus == 0) {
            NSArray * approvArr=[dic objectForKey:@"Result"];
            if(approvArr!=nil)
            {
                [_flowArr removeAllObjects];
                [_flowArr addObjectsFromArray:approvArr];
                [_wfModel ParseWorkFlowArr:_flowArr];
                
                [_vCustomTableView FinishLoading];
                [_vCustomTableView reloadData];
                //[self.tableView reloadData];
            }
        }
        else if(iStatus==-2||iStatus==-3||iStatus==-4){
        __weak id weakapp=Appdelegate;
        __weak id userShare=[UserInfoManager Share] ;
       [UIAlertView showAlertViewWithTitle:@""
                    message:@"加载失败,请您重新登录"
                    cancelButtonTitle:nil
                    otherButtonTitles:[NSArray arrayWithObject:@"OK"]
                                      onDismiss:^(int buttonIndex)  {
                                        [userShare ClearUserData];
                                          [weakapp changeViewDidLogout];
                                         
                                      }
                                       onCancel:^ {}];

       
         
        
        }
        else  {
          //  [[UserInfoManager Share] ClearUserData];
            [_flowArr removeAllObjects];
             //[self.tableView reloadData];
            [_vCustomTableView FinishLoading];
            [_vCustomTableView reloadData];
            [self showAlertViewText:message];
           
            
        }
        
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
    [_flowArr removeAllObjects];
     //[self.tableView reloadData];
    [_vCustomTableView FinishLoading];
    [_vCustomTableView reloadData];
    [self showAlertViewText:@"加载失败"];
}
- (void)Cancel {
    //[self hideLoading];
    [self StopLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self LoadNavStyle];
    self.flowArr=[[NSMutableArray alloc]init];
  
    _wfModel=[WorkFlowModel new];
	// Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationItem.title=@"审批";
    
    _vCustomTableView = [[RefreshTableView alloc] initWithFrame:CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height)];
    _vCustomTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _vCustomTableView.backgroundColor = [UIColor whiteColor];
    _vCustomTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _vCustomTableView.delegate = self;
    [self.view addSubview:_vCustomTableView];
    //_vCustomTableView.mbMoreHidden = NO;
    [self reloadData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [_flowArr count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
		
	static NSString *CellIdentifier = @"WorkFlowCell";
	
	WorkFlowViewCell *cell = (WorkFlowViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //NSDictionary *dic=[self.flowArr objectAtIndex:indexPath.row];
    WorkFlowInfoModel *infoModel=_wfModel.workflowArr[indexPath.row];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"WorkFlowViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    [cell ParseInfoModel:infoModel];
    cell.delegate=self;
    cell.cellIndex=indexPath.row;
    
    BOOL checked = infoModel.isChecked;
    [cell setCheckBackground:checked];
    //分割线的样式和颜色
	tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
	tableView.separatorColor = [UIColor grayColor];
	
	
	
	return cell;
}

//行点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
    self.hidesBottomBarWhenPushed=YES;
    WorkFlowDetailVC *detailVC=[[WorkFlowDetailVC alloc] initWithNibName:@"WorkFlowDetailView" bundle:nil];
    WorkFlowInfoModel *model=_wfModel.workflowArr[indexPath.row];
   
    detailVC.FlowCode=model.FlowCode;
    detailVC.InvoiceID=model.InvoiceID;
    detailVC.dicInfo=model;
    [self.navigationController pushViewController:detailVC animated:YES];
    self.hidesBottomBarWhenPushed=NO;
}

#pragma mark - RefreshTableView

- (void)LoadMoreList:(RefreshTableView *)sender {
    [self reloadData];
}

- (void)ReloadList:(RefreshTableView *)sender{
   // miPage = 0;
    [self reloadData];
}

- (BOOL)CanRefreshTableView:(RefreshTableView *)sender {
    return !_mDownManager;
}

-(void)dealloc
{
    [self Cancel];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
