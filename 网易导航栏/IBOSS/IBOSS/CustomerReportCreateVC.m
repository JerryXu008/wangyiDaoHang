//
//  CustomerReportCreateVC.m
//  IBOSS
//
//  Created by iHope on 14-6-5.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerReportCreateVC.h"
#import "MBProgressHUD.h"
@interface CustomerReportCreateVC ()
@property(nonatomic,strong) NSMutableArray *typeArr;
@property(nonatomic,strong) NSDictionary *typeDic;

@end

@implementation CustomerReportCreateVC
@synthesize  customerWayCell;
@synthesize customerNameCell;
@synthesize customerPropotyCell;
@synthesize MegPhoneCell;
@synthesize MegPersonlCell;
@synthesize MegMobilePhoneCell;
@synthesize DepartmentCell;
@synthesize SaleManCell;
@synthesize MidCustomerCell;
@synthesize MidEmployeeCell;
@synthesize RoomAreaCell;
@synthesize ProgressCell;
@synthesize AddressCell;
@synthesize NoteInfoCell;
@synthesize SeprateCell1,SeprateCell2;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
    MBProgressHUD*   HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    HUD.labelText = @"数据保存成功";
    HUD.mode = MBProgressHUDModeText;
    
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
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
    [button2 setTitle:@"完成" forState:UIControlStateNormal];
    [button2 setTitleColor:NavBarItemColor forState:UIControlStateNormal];
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
-(void)LoadType
{ //CustomerManagerAddType
   /* customerWayType=0,
    customerNameType,
    customerPropotyType,
    MegPhoneType,
    MegPersonlType,
    MegMobilePhoneType,
    DepartmentType,
    SaleManType,
    MidCustomerType,
    MidEmployeeType,
    RoomAreaType,
    ProgressType,
    AddressType,
    NoteInfoType*/
    self.typeDic=@{@"labtxt": @"客户渠道",@"txtplace":@"小区",@"type":
                       @"0" };
    [self.typeArr addObject:self.typeDic];
    
    self.typeDic=@{@"": @"",@"":@"",@"":
                       @"" };
    [self.typeArr addObject:self.typeDic];
    
    self.typeDic=@{@"labtxt": @"客户名称",@"txtplace":@"输入客户名称",@"type":@"1" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"客户性质",@"txtplace":@"输入客户性质",@"type":@"2" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"联系电话",@"txtplace":@"输入联系电话",@"type":@"3" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"联系人",@"txtplace":@"输入联系人",@"type":@"4" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"联系方式",@"txtplace":@"输入联系方式",@"type":@"5" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"": @"",@"":@"",@"":@"" };
    [self.typeArr addObject:self.typeDic];

    
    
    self.typeDic=@{@"labtxt": @"业务部门",@"txtplace":@"输入业务部门",@"type":@"6" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"业务员",@"txtplace":@"输入业务员",@"type":@"7" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"中间客户",@"txtplace":@"输入中间客户",@"type":@"8" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"中间客户员工",@"txtplace":@"",@"type":@"9" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"室内面积",@"txtplace":@"输入室内面积",@"type":@"10" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"装修进度",@"txtplace":@"输入装修进度",@"type":@"11" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"地 址",@"txtplace":@"输入地址",@"type":@"12" };
    [self.typeArr addObject:self.typeDic];
    self.typeDic=@{@"labtxt": @"备注",@"txtplace":@"输入备注",@"type":@"13" };
    [self.typeArr addObject:self.typeDic];



}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.typeArr=[[NSMutableArray alloc]init];
    [self loadNavStyle];
    [self LoadType];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.title=@"新增报备";
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //return 100;
    switch (indexPath.row) {
        
        case 0:
            return  SELECTCELLHEIGHT;
            break;
        case 1:return SeprateCellHeight;
            break;
        case 2:
           return txtCellHeight;
            break;
        case 3:
            return SELECTCELLHEIGHT;
            break;
        case 4:
            return txtCellHeight;
            break;
            case 5:
            return txtCellHeight;
            break;
        case 6:
            return txtCellHeight;
            break;
        case 7:
            return SeprateCellHeight;
            break;
        case 8:
            return SELECTCELLHEIGHT;
            break;
        case 9:
            return SELECTCELLHEIGHT;
            break;
        case 10:
            return SELECTCELLHEIGHT;
            break;
        case 11:
            return SELECTCELLHEIGHT;
            break;
        case 12:
            return txtCellHeight;
            break;
        case 13:
            return txtCellHeight;
            break;
        case 14:
            return txtCellHeight;
            break;
        case 15:
            return NoteCellHeight;
            break;
        default:
            return 0;
            break;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 16;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic=[self.typeArr objectAtIndex:indexPath.row];
    switch (indexPath.row) {
          // "labtxt": @"中间客户",@"txtplace":@"输入中间客户",@"type":@"8"
        case 0:{
            if(customerWayCell==nil){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:self options:nil];
            customerWayCell = [nib objectAtIndex:0];
            }
             customerWayCell .lblTitle.text=[dic objectForKey:@"labtxt"];
            customerNameCell.type=[[dic objectForKey:@"type"] intValue];
            customerWayCell.lblContent.text=@"";
          //  customerNameCell.selectionStyle=UITableViewCellSelectionStyleNone;
            return customerWayCell;
            break;
        }
        case 1:{
            if(SeprateCell1==nil){
                SeprateCell1=[[SeprateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sepatecell1"];
            }
        
            return SeprateCell1;
            break;
        }
        case 2:{
            if(customerNameCell==nil){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                customerNameCell = [nib objectAtIndex:0];
            }
            customerNameCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            customerNameCell.type=[[dic objectForKey:@"type"] intValue];
            customerNameCell.txtPlace=[dic objectForKey:@"txtplace"];
            return customerNameCell;
            break;}
        case 3:{
            if(customerPropotyCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:self options:nil];
                customerPropotyCell = [nib objectAtIndex:0];
            }
            customerPropotyCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            customerPropotyCell.type=[[dic objectForKey:@"type"] intValue];
           customerPropotyCell.lblContent.text=@"";
            return customerPropotyCell;
            break;}
        case 4:{
            if(MegPhoneCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                MegPhoneCell = [nib objectAtIndex:0];
            }
            MegPhoneCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            MegPhoneCell.type=[[dic objectForKey:@"type"] intValue];
            MegPhoneCell.txtPlace=[dic objectForKey:@"txtplace"];

            return MegPhoneCell;
            break;}
        case 5:{
            if(MegPersonlCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                MegPersonlCell = [nib objectAtIndex:0];

            }
            MegPersonlCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            MegPersonlCell.type=[[dic objectForKey:@"type"] intValue];
            MegPersonlCell.txtPlace=[dic objectForKey:@"txtplace"];

            return MegPersonlCell;
            break;}
        case 6:{
            if(MegMobilePhoneCell==nil){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                MegMobilePhoneCell = [nib objectAtIndex:0];
            }
            MegMobilePhoneCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            MegMobilePhoneCell.type=[[dic objectForKey:@"type"] intValue];
            MegMobilePhoneCell.txtPlace=[dic objectForKey:@"txtplace"];
            return MegMobilePhoneCell;
            break;}
        case 7:{
            if(SeprateCell2==nil){
                SeprateCell2=[[SeprateCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sepatecell2"];
            }
            
            return SeprateCell2;
            break;
        }

        case 8:{
            if(DepartmentCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:self options:nil];
                DepartmentCell = [nib objectAtIndex:0];

            }
            DepartmentCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            DepartmentCell.type=[[dic objectForKey:@"type"] intValue];
            DepartmentCell.lblContent.text=@"";
            return DepartmentCell;
            break;}
        case 9:{
            if(SaleManCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:self options:nil];
                SaleManCell = [nib objectAtIndex:0];
            }
            SaleManCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            SaleManCell.type=[[dic objectForKey:@"type"] intValue];
            SaleManCell.lblContent.text=@"";
            return SaleManCell;
            break;}
        case 10:{
            if(MidCustomerCell==nil)
            {
                
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:self options:nil];
                MidCustomerCell = [nib objectAtIndex:0];
            }
             MidCustomerCell.lblTitle.text=[dic objectForKey:@"labtxt"];
             MidCustomerCell.type=[[dic objectForKey:@"type"] intValue];
             MidCustomerCell.lblContent.text=@"";
            return MidCustomerCell;
            break;}
        case 11:{
            if(MidEmployeeCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SelectCell" owner:self options:nil];
               MidEmployeeCell = [nib objectAtIndex:0];
            }
            MidEmployeeCell .lblTitle.text=[dic objectForKey:@"labtxt"];
            MidEmployeeCell.type=[[dic objectForKey:@"type"] intValue];
            MidEmployeeCell.lblContent.text=@"";
            return MidEmployeeCell;
            break;}
        case 12:{
            if(RoomAreaCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                RoomAreaCell = [nib objectAtIndex:0];
            }
            RoomAreaCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            RoomAreaCell.type=[[dic objectForKey:@"type"] intValue];
            RoomAreaCell.txtPlace=[dic objectForKey:@"txtplace"];
            return RoomAreaCell;
            break;}
        case 13:{
            if(ProgressCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                ProgressCell = [nib objectAtIndex:0];
            }
            ProgressCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            ProgressCell.type=[[dic objectForKey:@"type"] intValue];
            ProgressCell.txtPlace=[dic objectForKey:@"txtplace"];

            return ProgressCell;
            break;}
        case 14:{
            if(AddressCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"TextCell" owner:self options:nil];
                AddressCell = [nib objectAtIndex:0];
            }
            AddressCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            AddressCell.type=[[dic objectForKey:@"type"] intValue];
            AddressCell.txtPlace=[dic objectForKey:@"txtplace"];

            return AddressCell;
            break;}
        case 15:{
            if(NoteInfoCell==nil)
            {
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"NoteCell" owner:self options:nil];
                NoteInfoCell = [nib objectAtIndex:0];
            }
            NoteInfoCell.lblTitle.text=[dic objectForKey:@"labtxt"];
            NoteInfoCell.type=[[dic objectForKey:@"type"] intValue];
            
            return NoteInfoCell;
            break;}
        default:{
            return 0;
            break;}
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    //some functions
   // ......
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
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
