//
//  PinPaiSearchTC.m
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "PinPaiSearchTC.h"

@interface PinPaiSearchTC ()
@property(nonatomic,strong) ASIDownManager *mDownManager;
@end

@implementation PinPaiSearchTC
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
               
                _searchArr=[[NSMutableArray alloc]initWithArray:approvArr];
                [self.tableView reloadData];
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
            // [_flowArr removeAllObjects];
            [self.tableView reloadData];
            [self showAlertViewText:message];
            
            
        }
        
    }
}

- (void)OnLoadFail:(ImageDownManager *)sender {
    [self Cancel];
    // [_flowArr removeAllObjects];
    [self.tableView reloadData];
    [self showAlertViewText:@"加载失败"];
}
- (void)Cancel {
    [self hideLoading];
    SAFE_CANCEL_ARC(self.mDownManager);
}

-(void)reloadData
{
    [self showLoading];
    NSString *urlStr = [NSString stringWithFormat:ServerURL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"GetDataSource" forKey:@"Action"];
    
    [dict setObject:[NSString stringWithFormat:@"%@",kkAccountCode]forKey:@"AccountCode"];
    [dict setObject:kkUserCode forKey:@"UserCode"];
    [dict setObject:kkUserPwd forKey:@"UserPassword"];
    [dict setObject:kkSessionKey forKey:@"SessionKey"];
    [dict setObject:@"T_MST_Goods_Brand" forKey:@"DataSourceCode"];
    
    [_mDownManager PostHttpRequest:urlStr :dict :nil :nil];
}

-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    // self.flowArr=[[NSMutableArray alloc]init];
    // _dataSelect=[NSMutableArray new];
    _searchArr=[NSMutableArray new];
    self.mDownManager = [[ASIDownManager alloc] init];
    self.mDownManager = [[ASIDownManager alloc] init];
    _mDownManager.delegate = self;
    _mDownManager.OnImageDown = @selector(OnLoadFinish:);
    _mDownManager.OnImageFail = @selector(OnLoadFail:);
    [self reloadData];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title=@"库区列表";
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"fanhui_icon.png"]
                      forState:UIControlStateNormal];
    [button addTarget:self action:@selector(GotoBack)
     forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 44, 20);
    
    UIBarButtonItem *menuButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = menuButton;
    
    
}
-(void)dealloc
{
    [self Cancel];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return _searchArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier ];
    if(cell==nil)
    {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSDictionary *dic=_searchArr[indexPath.row];
    //  cell.tag=[[dic objectForKey:@"WarehouseID"] intValue];
    cell.textLabel.text=[dic objectForKey:@"BrandName"];
    //cell.tag=
    // Configure the cell...
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic=_searchArr[indexPath.row];
    NSString * str=[dic objectForKey:@"BrandName"];
    NSString *BrandID=[dic objectForKey:@"BrandID"];
    [_parentVC.btnPinPai setTitle:str forState:UIControlStateNormal];
    _parentVC.PinPaiHiddenStr=BrandID;
    [self.navigationController popViewControllerAnimated:YES];
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 
 */

@end
