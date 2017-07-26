//
//  YPopView.m
//  shopsN
//  气泡view
//  Created by imac on 2016/12/1.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPopView.h"
#import "YPopCell.h"

@interface YPopView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic) CGRect frames;

@property (strong,nonatomic) NSArray *titleList;

@property (strong,nonatomic) NSArray *images;



@end

UITableView *tableV;

@implementation YPopView


-(instancetype)initWithFrame:(CGRect)frame title:(NSArray *)titleList image:(NSArray *)images{
    if ( self = [super initWithFrame:frame]) {
    self.frame = [UIScreen mainScreen].bounds;
    self.titleList = titleList;
    self.images = images;
    self.backgroundColor = [UIColor clearColor];
    self.frames = frame;

    tableV = [[UITableView alloc]initWithFrame:CGRectMake(frame.origin.x, frame.origin.y+18, 65 ,33*titleList.count)];
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.layer.cornerRadius = 2;
    tableV.backgroundColor = LH_RGBCOLOR(82, 82, 82);
    tableV.rowHeight = 33;
    tableV.userInteractionEnabled = YES;
    tableV.separatorColor = [UIColor clearColor];
    tableV.scrollEnabled = NO;
    // 定点
    tableV.layer.anchorPoint = CGPointMake(1.0, 0);
    tableV.transform =CGAffineTransformMakeScale(0.0001, 0.0001);
    [self addSubview:tableV];

    tableV.transform = CGAffineTransformMakeScale(1.0, 1.0);

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
    [self.superview addGestureRecognizer:tap];
    }
    return self;
}


-(void)hidden{
        [UIView animateWithDuration:0.0001 animations:^{
             tableV.transform =CGAffineTransformMakeScale(0.0001, 0.0001);
            [self removeFromSuperview];
            [tableV removeFromSuperview];
            tableV = nil;
        } completion:nil];
}
#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect

{
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板

    CGContextRef  context = UIGraphicsGetCurrentContext();

    //利用path进行绘制三角形

    CGContextBeginPath(context);//标记
    CGContextMoveToPoint(context,
                        _frames.origin.x+5, 60);//设置起点

    CGContextAddLineToPoint(context,
                            _frames.origin.x+15 ,  52);

    CGContextAddLineToPoint(context,
                            _frames.origin.x+25, 60);

    CGContextClosePath(context);//路径结束标志，不写默认封闭

    [LH_RGBCOLOR(82, 82, 82) setFill];  //设置填充色

    [[UIColor clearColor] setStroke]; //设置边框颜色

    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path

}


#pragma mark ==UItableViewDelegate==
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YPopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YPopCell"];
    if (!cell) {
        cell = [[YPopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YPopCell"];
    }
    cell.imageName = self.images[indexPath.row];
    cell.title= _titleList[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate chooseIndex:indexPath.row];

    [self hidden];
}


@end
