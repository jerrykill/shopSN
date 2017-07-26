//
//  YGoodDetailsAppraiseView.m
//  shopsN
//
//  Created by imac on 2016/12/14.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YGoodDetailsAppraiseView.h"
#import "YGoodAppraiseTypeView.h"
#import "YGoodAppraiseCell.h"
#import "YGoodAppraiseModel.h"

@interface YGoodDetailsAppraiseView ()<UITableViewDelegate,UITableViewDataSource,YGoodAppraiseTypeViewDelegate>

@property (strong,nonatomic) YGoodAppraiseTypeView *appraiseV;

@property (strong,nonatomic) UITableView *tableV;

@property (strong, nonatomic) UILabel *bottomMsgLabel;

@property (nonatomic) BOOL isHead;

@property (strong,nonatomic) NSMutableArray *dataArr;

@property (strong,nonatomic) NSString *status;

@property (assign,nonatomic) NSInteger page;

@property (assign,nonatomic) BOOL isPic;

@end

@implementation YGoodDetailsAppraiseView

-(void)loadMore{
    _page++;
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if (_isPic) {
        [JKHttpRequestService GET:@"Goods/displayImg" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"goods_id":_goodID} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSMutableArray *list = [YSParseTool getParseGoodAppraise:jsonDic[@"data"]];
                [strongSelf.dataArr addObjectsFromArray:list];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV footerEndRefreshing];
                if (list.count<10) {
                    [strongSelf.tableV setFooterHidden:YES];
                }
            }else{
                strongSelf.page--;
                [strongSelf.tableV.footer endRefreshing];
            }
        } failure:^(NSError *error) {

        } animated:NO];
    }else{
        [JKHttpRequestService GET:@"Goods/commentList" withParameters:@{@"status":_status,@"p":[NSString stringWithFormat:@"%ld",_page],@"goods_id":_goodID} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSMutableArray *list = [YSParseTool getParseGoodAppraise:jsonDic[@"data"]];
                [weakSelf.dataArr addObjectsFromArray:list];
                [weakSelf.tableV reloadData];
                [weakSelf.tableV footerEndRefreshing];
                if (list.count<10) {
                    [weakSelf.tableV setFooterHidden:YES];
                }
            }else{
                weakSelf.page--;
                [weakSelf.tableV footerEndRefreshing];
                [strongSelf.tableV setFooterHidden:YES];

            }
        } failure:^(NSError *error) {
            weakSelf.page--;
        } animated:NO];
    }
}

- (void)getdataStatus:(BOOL)sender{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    if (sender) {
        [JKHttpRequestService GET:@"Goods/commentList" withParameters:@{@"status":_status,@"p":[NSString stringWithFormat:@"%ld",_page],@"goods_id":_goodID} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                strongSelf.dataArr = [YSParseTool getParseGoodAppraise:jsonDic[@"data"]];
                if (strongSelf.dataArr.count<10) {
                    [strongSelf.tableV setFooterHidden:YES];
                }else{
                    [strongSelf.tableV setFooterHidden:NO];
                }
                [strongSelf.tableV reloadData];
            }else{
                [strongSelf.dataArr removeAllObjects];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV setFooterHidden:YES];

            }
        } failure:^(NSError *error) {
            
        } animated:NO];
    }else{
        [JKHttpRequestService GET:@"Goods/displayImg" withParameters:@{@"p":[NSString stringWithFormat:@"%ld",_page],@"goods_id":_goodID,@"status":@""} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                strongSelf.dataArr = [YSParseTool getParseGoodAppraise:jsonDic[@"data"]];
                if (strongSelf.dataArr.count<10) {
                    [strongSelf.tableV setFooterHidden:YES];
                }else{
                    [strongSelf.tableV setFooterHidden:NO];
                }
                [strongSelf.tableV reloadData];
            }else{
                [strongSelf.dataArr removeAllObjects];
                [strongSelf.tableV reloadData];
                [strongSelf.tableV setFooterHidden:YES];

            }
        } failure:^(NSError *error) {

        } animated:NO];
    }
}

-(void)setGoodID:(NSString *)goodID{
    _goodID = goodID;
    _status = @"";
    if (IsNilString(_goodID)) {
        return;
    }
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [JKHttpRequestService GET:@"Goods/goodsComment" withParameters:@{@"goods_id":goodID} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                NSDictionary *data = jsonDic[@"data"];
                strongSelf.appraiseV.numArr = @[[NSString stringWithFormat:@"%@",data[@"allcount"]],
                                      [NSString stringWithFormat:@"%@",data[@"nice"]],
                                      [NSString stringWithFormat:@"%@",data[@"height"]],
                                      [NSString stringWithFormat:@"%@",data[@"bad"]],
                                      [NSString stringWithFormat:@"%@",data[@"isimg"]]];
            }
        } failure:^(NSError *error) {
            
        } animated:NO];

        [JKHttpRequestService GET:@"Goods/commentList" withParameters:@{@"status":_status,@"p":@"1",@"goods_id":goodID} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
            if (succe) {
                strongSelf.dataArr = [YSParseTool getParseGoodAppraise:jsonDic[@"data"]];
                [strongSelf.tableV reloadData];
            }else{
                [strongSelf.tableV setFooterHidden:YES];
            }
        } failure:^(NSError *error) {
           
        } animated:NO];
    });


}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = __BackColor;
        _page=1;
        _isPic =NO;
        [self initView];
    }
    return self;
}

-(void)initView{
    [self addSubview:self.appraiseV];
    [self addSubview:self.tableV];
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
   [_tableV addLegendFooterWithRefreshingBlock:^{
       [strongSelf loadMore];
   }];
}

#pragma mark ==懒加载==
-(YGoodAppraiseTypeView *)appraiseV{
    if (!_appraiseV) {
        _appraiseV = [[YGoodAppraiseTypeView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 52)];
        _appraiseV.delegate = self;
    }
    return _appraiseV;
}

-(UITableView *)tableV{
    if (!_tableV) {
        _tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectYH(_appraiseV), __kWidth, __kHeight-64-50-90)];
        _tableV.backgroundColor = [UIColor clearColor];
        _tableV.separatorColor = [UIColor clearColor];
        _tableV.delegate = self;
        _tableV.dataSource = self;
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YGoodAppraiseCell"];
    if (!cell) {
        cell = [[YGoodAppraiseCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YGoodAppraiseCell"];
    }
    YGoodAppraiseModel *model = _dataArr[indexPath.row];
    cell.model = model;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    YGoodAppraiseModel *model = _dataArr[indexPath.row];
    NSString *text = model.info;
    CGSize size  =[text boundingRectWithSize:CGSizeMake(__kWidth-25, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:MFont(12)} context:nil].size;
    NSInteger t =0;
    if (model.imageArr.count) {
        t=1;
    }
    CGFloat height = 33+size.height+10+t*70+15+20;
    return height;
}


#pragma mark ==YGoodAppraiseTypeViewDelegate==
-(void)chooseAppraiseType:(NSInteger)sender{
    NSLog(@"评价级别%ld",(long)sender);
    _page=1;
    _isPic = NO;
    switch (sender) {
        case 0:{
            _status = @"";
            [self getdataStatus:YES];
        }
            break;
        case 1:
        {
             _status = @"3";
            [self getdataStatus:YES];
        }
            break;
        case 2:
        {
            _status = @"2";
            [self getdataStatus:YES];
        }
            break;
        case 3:
        {
            _status = @"1";
            [self getdataStatus:YES];
        }
            break;
        case 4:
        {
            _isPic = YES;
            [self getdataStatus:NO];
        }
            break;

        default:
            break;
    }

}


#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.y;
    if (offset<-40&&!scrollView.dragging) {
        if (_isHead) {
            [self.delegate getGoodBack];
            _isHead = NO;
        }else{
            _isHead = YES;
        }
    }
}

@end
