//
//  YPlistAddressTool.m
//  shopsN
//  网络地址解析存取
//  Created by imac on 2017/3/16.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YPlistAddressTool.h"

@implementation YPlistAddressTool

#pragma mark ==存入数据==
+(void)saveThePlistAddress:(NSArray *)data{
    NSString *PlistPath = [self FilePath];
    if ([data writeToFile:PlistPath atomically:YES]) {
        NSLog(@"存入成功");
    }else{
        NSLog(@"存入失败");
    }
}

#pragma mark ==提取plist地址==
+ (NSString *)FilePath{
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *PlistPath = [filePath stringByAppendingPathComponent:@"tests.plist"];
    if (![fm fileExistsAtPath:PlistPath]) {// 文件不存在

        [fm createFileAtPath:PlistPath contents:nil attributes:nil];
        NSMutableArray *arr=[[NSMutableArray alloc] init];
        [arr writeToFile:PlistPath atomically:YES];
    }
    return PlistPath;
}
#pragma mark ==获取地址信息==
+(NSMutableArray<YPlistAddressModel *> *)getTheDataAddress{
    NSString *PlistPath = [self FilePath];
    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:PlistPath];
    return [self getParseAddressList:data];
}
#pragma mark ==解析数据==
+(NSMutableArray<YPlistAddressModel*>*)getParseAddressList:(NSMutableArray*)data{
    NSMutableArray *list = [NSMutableArray array];
    for (NSDictionary*pvc in data) {
        @autoreleasepool {
            YPlistAddressModel *model = [[YPlistAddressModel alloc]init];
            model.province = pvc[@"name"];
            model.provinceID = pvc[@"id"];
            NSArray *citys = pvc[@"son"];
            NSMutableArray *clist = [NSMutableArray array];
            for (NSDictionary*ct in citys) {
                YPlistCityModel *city = [[YPlistCityModel alloc]init];
                city.city = ct[@"name"];
                city.cityId = ct[@"id"];
                NSArray *areas = ct[@"grandson"];
                NSMutableArray *alist = [NSMutableArray array];
                for (NSDictionary*ar in areas) {
                    YPlistAreaModel *area = [[YPlistAreaModel alloc]init];
                    area.area = ar[@"name"];
                    area.areaID = ar[@"id"];
                    [alist addObject:area];
                }
                city.datas = alist;
                [clist addObject:city];
            }
            model.list = clist;
            [list addObject:model];
        }
    }
    return list;
}

@end
