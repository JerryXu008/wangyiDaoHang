//
//  WorkFlowViewCell.m
//  IBOSS
//
//  Created by iHope on 14-6-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "WorkFlowViewCell.h"
#import "WorkFlowInfoModel.h"
@interface WorkFlowViewCell()
{
   // SEL btnCheckPressed;

}

@end
@implementation WorkFlowViewCell

-(void)ParseInfoModel:(WorkFlowInfoModel *)model
{
    if(model!=nil){
        
        _lblNumber.text=model.InvoiceNo;
        _lblType.text=model.AuditTypeName;
        _lblReason.text=model.AuditReason;
        _lblCreateMan.text=model.CreateUserName;
        _lblNote.text=model.Remarks;
        _lblTime.text=model.CreateTime;
        _isSelect=model.isChecked;
        _InvoiceID =model.InvoiceID;
        _StepNo=model.StepNo;
        _Status=model.Status;
        
    }
    
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
       [_btnSelect addTarget:self action:@selector(btnGoCheck) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
-(void)awakeFromNib
{
    [super awakeFromNib];
     [_btnSelect addTarget:self action:@selector(btnGoCheck) forControlEvents:UIControlEventTouchUpInside];
}
-(void)btnGoCheck
{
    if([self.delegate respondsToSelector:@selector(btnCheckPressed:)])
    {
     [self.delegate btnCheckPressed:self];
    
    }
}
- (void) setCheckBackground: (BOOL) checked
{
    if(!checked)
     {
     _isSelect=NO;
     [_btnSelect setBackgroundImage:[UIImage imageNamed:@"shenpiweixuanzhong.png"] forState:UIControlStateNormal];
     
     }
     else
     {
      _isSelect=YES;
     [_btnSelect setBackgroundImage:[UIImage imageNamed:@"shenpixuanzhong"] forState:UIControlStateNormal];
     }


}
-(void) gotoDetail:(id)sender
{
    if([self.delegate respondsToSelector:@selector(showWorkFlowDetail:)])
 {
     [self.delegate showWorkFlowDetail:_cellIndex];
 
 }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleBlue;
  
    [ self.btnGoDetail setTitle:@"详情" forState:UIControlStateNormal];
   // [ self.btnGoDetail setBackgroundImage:[UIImage imageNamed:@"goarrow.png"]
     //             forState:UIControlStateNormal];
    CGRect frame=self.btnGoDetail.frame;
    self.btnGoDetail.frame=CGRectMake(frame.origin.x, frame.origin.y, 300, 300);
    self.btnGoDetail.backgroundColor=[UIColor colorWithRed:61/255.0 green:169/255.0 blue:223/255.0 alpha:1.0];
    [self.btnGoDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.btnGoDetail.layer setMasksToBounds:YES];
    [self.btnGoDetail.layer setCornerRadius:5.0];
    [self.btnGoDetail.layer setBorderWidth:0.0];
   /*_lblNumber.textColor=[UIColor grayColor];
   _lblType.textColor=[UIColor grayColor];
   _lblReason.textColor=[UIColor grayColor];
   _lblCreateMan.textColor=[UIColor grayColor];
   _lblNote.textColor=[UIColor grayColor];
    _lblTime.textColor=[UIColor grayColor];*/
    [_btnGoDetail addTarget:self action:@selector(gotoDetail:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
