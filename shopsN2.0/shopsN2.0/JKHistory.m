//
//  JKHistory.m
//  shopsN
//
//  Created by imac on 2016/12/2.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "JKHistory.h"

@implementation JKHistory

+ (void)Savetext:(NSString *)str{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"history.plist"];
    NSMutableArray *arr = [NSMutableArray array];
    NSMutableArray *list = [NSMutableArray arrayWithContentsOfFile:filePath];
    if (list) {
        arr = list;
    }
    for (int i=0;i<arr.count;i++ ) {
        NSString *key =arr[i];
        if ([key isEqualToString:str]) {
            [arr removeObject:key];
        }
    }
    [arr addObject:str];
    [arr writeToFile:filePath atomically:YES];
}

+(NSMutableArray *)getHistory{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"history.plist"];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
    return arr;
}

+(void)clearHistory{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:@"history.plist"];
    NSMutableArray *arr = [NSMutableArray arrayWithContentsOfFile:filePath];
    [arr removeAllObjects];
    [arr writeToFile:filePath atomically:YES];
}

@end
