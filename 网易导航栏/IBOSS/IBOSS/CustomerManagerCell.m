//
//  CustomerManagerCell.m
//  IBOSS
//
//  Created by iHope on 14-6-6.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "CustomerManagerCell.h"

@implementation CustomerManagerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.seperatImage.backgroundColor=[UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:239.0f/255.0f alpha:1.0] ;
    //backgroundColor=[UIColor colorWithRed:239 green:239 blue:239 alpha:1.0];

}
-(void)setDicInfo:(NSDictionary *)dicInfo
{
    _dicInfo=dicInfo;
    if(_dicInfo!=nil){
        
        self.txtCustomerName.text=[_dicInfo objectForKey:@"客户名称"];
        self.txtCustomerWay.text=[_dicInfo objectForKey:@"渠道"];
        self.txtPhone.text=[_dicInfo objectForKey:@"联系电话"];
        self.txtDepartment.text=[_dicInfo objectForKey:@"业务部门"];
        self.txtSalesman.text=[_dicInfo objectForKey:@"业务员"];
        self.txtAddress.text=[_dicInfo objectForKey:@"地址"];
        
    }
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
