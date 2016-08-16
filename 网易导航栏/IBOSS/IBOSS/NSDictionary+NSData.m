//
//  NSDictionary+NSData.m
//  IBOSS
//
//  Created by iHope on 14-7-14.
//  Copyright (c) 2014年 elongtian. All rights reserved.
//

#import "NSDictionary+NSData.h"

@implementation NSDictionary (NSData)
+ (NSDictionary *)dictionaryWithContentsOfData:(NSData *)data {
    CFPropertyListRef plist =  CFPropertyListCreateFromXMLData(kCFAllocatorDefault, (CFDataRef)data,
                                                               kCFPropertyListImmutable,
                                                               NULL);
    if(plist == nil) return nil;
    if ([(id)plist isKindOfClass:[NSDictionary class]]) {
        return [(NSDictionary *)plist autorelease];
    }
    else {
        CFRelease(plist);
        return nil;
    }
}

@end
