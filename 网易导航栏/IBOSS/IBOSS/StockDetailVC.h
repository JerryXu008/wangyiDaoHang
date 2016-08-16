//
//  StockDetailVC.h
//  IBOSS
//
//  Created by iHope on 14-7-8.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StockDetailVC : BaseViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property(strong) UIButton *btnKunQu;
@property(strong) UIButton *btnPinPai;

@property(copy) NSString * KuQuHiddenStr;//库区id
@property(copy) NSString * PinPaiHiddenStr; //品牌id
@end
