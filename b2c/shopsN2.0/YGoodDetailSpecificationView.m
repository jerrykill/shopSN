//
//  YGoodDetailSpecificationView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailSpecificationView.h"
#import "YGoodeDetailsCell.h"

@interface YGoodDetailSpecificationView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UITableView *tableV;

@property (strong,nonatomic) NSMutableArray *titleArr;

@property (strong,nonatomic) NSMutableArray *detailArr;



@property (strong, nonatomic) UILabel *bottomMsgLabel;

@property (nonatomic) BOOL isHead;

@end

@implementation YGoodDetailSpecificationView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _titleArr = [NSMutableArray arrayWithObjects:@"商品名称",@"品牌",@"分类",@"类型", nil];
        _detailArr = [NSMutableArray array];
        [self initView];
    }
    return self;
}

-(void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
    if (IsNilString(_goodID)) {
        return;
    }
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    [JKHttpRequestService GET:@"Goods/specifications" withParameters:@{@"goods_id":goodID} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = jsonDic[@"data"];
            NSString *data1 = dic[@"title"];
            if (IsNull(data1)||IsNilString(data1)) {
                data1 = @"";
            }
            [strongSelf.detailArr addObject:data1];
            NSString *data2 = dic[@"brand"];
            if (IsNull(data2)||IsNilString(data2)) {
                data2 = @"";
            }
            [strongSelf.detailArr addObject:data2];
            NSString *data3 = dic[@"className"];
            if (IsNull(data3)||IsNilString(data3)) {
                data3 = @"";
            }
            [strongSelf.detailArr addObject:data3];
            NSString *data4 = dic[@"typename"];
            if (IsNull(data4)||IsNilString(data4)) {
                data4 =@"";
            }
            [strongSelf.detailArr addObject:data4];
            NSArray *att = dic[@"attra"];
            for (NSDictionary *ds in att) {
                [_titleArr addObject:ds[@"name"]];
                [_detailArr addObject:ds[@"item"]];
            }
            [strongSelf.tableV reloadData];
        }
    } failure:^(NSError *error) {

    } animated:NO];
    });
}

-(void)initView{
    [self addSubview:self.tableV];

}

#pragma mark ==懒加载==
-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, 4, __kWidth, __kHeight-64-50-42)];
        _tableV.backgroundColor =[UIColor clearColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
        _tableV.separatorColor = [UIColor clearColor];
        [_tableV addSubview:self.bottomMsgLabel];
    }
    return _tableV;
}

-(UILabel *)bottomMsgLabel{
    if (!_bottomMsgLabel) {
        _bottomMsgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, -40, __kWidth, 40)];
        _bottomMsgLabel.font = [UIFont systemFontOfSize:13.0f];
        _bottomMsgLabel.textAlignment = NSTextAlignmentCenter;
        _bottomMsgLabel.text = @"下拉返回商品详情";
    }
    return _bottomMsgLabel;
}

#pragma mark ==UITableViewDelegate==
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _detailArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodeDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGoodeDetailsCell"];
    if (!cell) {
        cell = [[YGoodeDetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGoodeDetailsCell"];
    }
    cell.title = _titleArr[indexPath.row];
    cell.detail = _detailArr[indexPath.row];
    if (indexPath.row==0) {
        cell.isHead = YES;
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        return 62;
    }else{
        return 45;
    }
}
#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset<-40&&!scrollView.dragging) {
        if (_isHead) {
            [self.delegate getFresh];
            _isHead = NO;
        }else{
            _isHead = YES;
        }
    }
}



@end
