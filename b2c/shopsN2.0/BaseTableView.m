//
//  BaseTableView.m
// shopSN
//
//  Created by Mac on 16/3/5.
//  Copyright © 2016年 imac. All rights reserved.
//

#import "BaseTableView.h"

@implementation BaseTableView

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self endEditing:YES];
    NSLog(@"tableViewTouchesBegan....");
}

@end
