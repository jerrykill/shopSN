//
//  YMessageDetailViewController.m
//  shopsN
//
//  Created by imac on 2016/12/28.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YMessageDetailViewController.h"
#import "YMessageHeadView.h"

@interface YMessageDetailViewController ()

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) UILabel *mainLb;

@property (strong,nonatomic) YMessageHeadView *MessageHeadV;


@property (strong,nonatomic) NSString *eamilText;

@property (strong,nonatomic) YSMessageModel *model;

@end

@implementation YMessageDetailViewController

-(void)getdata{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"News/content" withParameters:@{@"news_id":_messageId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *data = jsonDic[@"data"];
            strongSelf.model = [YSParseTool getParsePersonNewsDetail:data];
            strongSelf.MessageHeadV.title = strongSelf.model.title;
            strongSelf.MessageHeadV.time = strongSelf.model.time;
            strongSelf.MessageHeadV.userName = @"系统消息";
            NSString *str = strongSelf.model.content;
            CGSize size =[YGetAttribute getSpaceHeight:str size:CGSizeMake(__kWidth-37, MAXFLOAT) rowHeight:6 font:MFont(14)];

            strongSelf.mainLb.attributedText = [YGetAttribute getSpaceString:str size:CGSizeMake(__kWidth-37, MAXFLOAT) rowHeight:6 font:MFont(14)];
            strongSelf.mainLb.frame = CGRectMake(16, CGRectYH(strongSelf.MessageHeadV)+18, __kWidth-37, size.height);
            strongSelf.scrollV.contentSize = CGSizeMake(0, size.height+38+74);
        }
    } failure:^(NSError *error) {

    } animated:YES];


}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息内容";
    self.rightBtn.hidden = YES;
    [self initView];
    [self getdata];
}

-(void)initView{
    _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_scrollV];
    _scrollV.backgroundColor = [UIColor whiteColor];
    _scrollV.pagingEnabled = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.contentSize = CGSizeMake(0, __kHeight-64);

    _MessageHeadV = [[YMessageHeadView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 74)];
    [_scrollV addSubview:_MessageHeadV];

    _mainLb = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectYH(_MessageHeadV)+18, __kWidth-37, __kHeight-64-74-38)];
    [_scrollV addSubview:_mainLb];
    _mainLb.textAlignment = NSTextAlignmentLeft;
    _mainLb.font = MFont(14);
    _mainLb.textColor = __DTextColor;
    _mainLb.numberOfLines = 0;



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
