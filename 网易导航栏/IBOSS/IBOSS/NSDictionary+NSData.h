//
//  NSDictionary+NSData.h
//  IBOSS
//
//  Created by iHope on 14-7-14.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NSData)
+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data;
@end
