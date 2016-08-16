//
//  CustomerSearchVC.m
//  IBOSS
//
//  Created by iHope on 14-6-16.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerSearchVC.h"
#import "SearchCustomerNameCell.h"
#import "SearchCustomerWayCell.h"
#import "SearchDateCell.h"
#import "SearchOtherCell.h"
@interface CustomerSearchVC ()
@property(strong) IBOutlet UITableView *tbView;
@property(strong) NSArray *infoArr;
@property(strong) SearchCustomerNameCell *namecell;
@property(strong) SearchCustomerWayCell *waycell;
@property(strong) SearchDateCell *datecell;
@property(strong) SearchOtherCell *othercell;


@end

@implementation CustomerSearchVC
@synthesize infoArr;
@synthesize namecell,waycell,datecell,othercell;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)GotoBack
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)GoSearch
{
[self.navigationController popViewControllerAnimated:YES];
}
-(void)loadNavStyle
{
    //右边
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    // button2.backgroundColor=[UIColor redColor];
    [button2 addTarget:self action:@selector(GoSearch)
      forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(0, 0, 40, 24);
    //button2.titleLabel.text=@"跟进";
    [button2 setTitleColor:NavBarItemColor forState:UIControlStateNormal];
    [button2 setTitle:@"搜索" forState:UIControlStateNormal];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.infoArr=@[@"客户名称",@"客户渠道",@"日期",@"其他"];
    [self loadNavStyle];
    self.navigationItem.title=@"搜索";
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
    switch (indexPath.row) {
            
        case 0:{
              return SearchCustomerNameCellHeight;
            break;
        }
            
        case 1:{
            if(waycell!=nil){
                if([waycell.isOpen isEqualToString: @"1"])
                {
                    return SearchCustomerWayCellHeight2;
                }
                else
                {
                    return SearchCustomerWayCellHeight1;
                }
            }
            
            else
            {
                return SearchCustomerWayCellHeight1;
            }

            break;
        }

        case 2:{
            if(datecell!=nil){
             if([datecell.isOpen isEqualToString: @"1"])
             {
                 return SearchDateCellHeight2;
             }
             else
             {
                 return SearchDateCellHeight1;
                }
            }
           
            else
            {
                return SearchDateCellHeight1;
            }
            break;
        }

        case 3:{
            return SearchCustomerNameCellHeight;
            break;
        }
        default:{
            return 0;break;
        }

    }
    
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *name=[self.infoArr objectAtIndex:indexPath.row];
    switch (indexPath.row) {
           
        case 0:{
            if(namecell==nil){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SearchCustomerNameCell" owner:self options:nil];
                namecell = [nib objectAtIndex:0];
            }
                      //  customerNameCell.selectionStyle=UITableViewCellSelectionStyleNone;
           // namecell.textLabel.text=name;
            return namecell;
            break;
        }
        case 1:{
            if(waycell==nil){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SearchCustomerWayCell" owner:self options:nil];
                waycell = [nib objectAtIndex:0];
            }
            waycell.delegate=self;
           // waycell.textLabel.text=name;
            return waycell;
            break;
        }
        case 2:{
            if(datecell==nil){
                NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SearchDateCell" owner:self options:nil];
                datecell = [nib objectAtIndex:0];
            }
            //  customerNameCell.selectionStyle=UITableViewCellSelectionStyleNone;
          //  datecell.textLabel.text=name;
            datecell.delegate=self;
            return datecell;

            break;
        }
        case 3:
        { if(othercell==nil){
            NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"SearchOtherCell" owner:self options:nil];
            othercell = [nib objectAtIndex:0];
        }
            //  customerNameCell.selectionStyle=UITableViewCellSelectionStyleNone;
           // othercell.textLabel.text=name;
            return othercell;

            break;
        }
        default:{
            return 0;
            break;}
    
    }
}
-(void)refreshTableView
{
    [self.tbView reloadData];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
