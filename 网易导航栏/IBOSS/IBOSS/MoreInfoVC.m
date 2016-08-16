//
//  MoreInfoVC.m
//  IBOSS
//
//  Created by iHope on 14-7-7.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "MoreInfoVC.h"
#import "GeneralCell.h"
#import "MoreBackgroundCell.h"
#import "MoreReportCell.h"
#import "SceneManagerVC.h"
#import "FormReportVC.h"
#import "StockDetailVC.h"
#import "DailyReconciliationVC.h"
#import "PersonSettingVC.h"
@interface MoreInfoVC ()
@property(strong) IBOutlet UITableView *tbView;
@property(strong) MoreReportCell *reportcell;
@end

@implementation MoreInfoVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.navigationItem.title=@"更多";
  //  if(IOS_7){
        self.tbView.separatorStyle=UITableViewCellSeparatorStyleNone;
   // }
    self.tbView.backgroundColor=[UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1.0];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int row=indexPath.row;
    switch (row) {
            
        case 0:
        case 2:
        case 4:
        case 6:
        {
           
            return 20;
            
            break;
        }
        case 5:{
            if(_reportcell!=nil){
                if([_reportcell.isOpen isEqualToString: @"1"])
                {
                    return 182;
                }
                else
                {
                    return 61;
                }
            }
            
            else
            {
                return 61;
            }
            
            
            
            //return 182;
        }
        default:{
            return 60;
        }
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    int row=indexPath.row;
    switch (row) {
            
        case 0: case 2: case 4: case 6:{
            MoreBackgroundCell *backcell=[[MoreBackgroundCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
            return backcell;
            
            break;
        }
        case 1:case 3:case 7:{
            GeneralCell *genecell=[[GeneralCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
            genecell.type=row;
            return genecell;
            
            break;
        }
        case 5:{
            if(!_reportcell){
                _reportcell=[[MoreReportCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell3"];
            }
            _reportcell.delegate=self;
         //   _reportcell.isOpen=@"0";
            return _reportcell;
            
            break;
        }
            
        default:{
            return nil;
            break;
        }
    
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tbView deselectRowAtIndexPath:indexPath animated:NO];
    int row=indexPath.row;
     if(row==1)
     {   self.hidesBottomBarWhenPushed=YES;
         SceneManagerVC* scenemanagervc=[[SceneManagerVC alloc] initWithNibName:@"SceneManagerView" bundle:nil];
          [self.navigationController pushViewController:scenemanagervc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
     }
    else if(row==3)
    {
        self.hidesBottomBarWhenPushed=YES;
         LogManagerVC *  logmanagervc=[[LogManagerVC alloc] initWithNibName:@"LogManagerView" bundle:nil];
        [self.navigationController pushViewController:logmanagervc animated:YES];
        self.hidesBottomBarWhenPushed=NO;
    }
    else if(row==7)
    {
        self.hidesBottomBarWhenPushed=YES;
        PersonSettingVC *  logmanagervc=[[PersonSettingVC alloc] init];
        [self.navigationController pushViewController:logmanagervc animated:YES];
        self.hidesBottomBarWhenPushed=NO;

    }
    
    
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  cell.backgroundColor = [UIColor redColor];
}
-(void)gokucun
{
    self.hidesBottomBarWhenPushed=YES;
    StockDetailVC* scenemanagervc=[[StockDetailVC alloc] init];
    [self.navigationController pushViewController:scenemanagervc animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}
-(void)gorijie
{
    self.hidesBottomBarWhenPushed=YES;
    DailyReconciliationVC* scenemanagervc=[[DailyReconciliationVC alloc] init];
    [self.navigationController pushViewController:scenemanagervc animated:YES];
    self.hidesBottomBarWhenPushed=NO;

}
-(void)refreshTableView
{
    [self.tbView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
