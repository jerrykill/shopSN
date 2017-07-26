//
//  YSAnnounceDetailViewController.m
//  shopsN
//
//  Created by imac on 2017/2/6.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YSAnnounceDetailViewController.h"

@interface YSAnnounceDetailViewController ()<UITextViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) UILabel *mainLb;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) NSString *mainText;

@property (strong,nonatomic) UITextView *testV;

@end

@implementation YSAnnounceDetailViewController
-(void)getData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Index/announcement_list" withParameters:@{@"id":_warnId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSDictionary *dic = jsonDic[@"data"];
            strongSelf.titleLb.text = dic[@"title"];
            NSString *str = dic[@"content"];
            NSDictionary *options =@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
            NSData *data = [str dataUsingEncoding:NSUnicodeStringEncoding];

            NSAttributedString *attr = [[NSAttributedString alloc]initWithData:data options:options documentAttributes:nil error:nil];
            NSString *test = [NSString stringWithFormat:@"%@",attr];
            test = [self handleStringWithString:test];
            NSData *data1 = [test dataUsingEncoding:NSUnicodeStringEncoding];
            NSAttributedString *attrs = [[NSAttributedString alloc]initWithData:data1 options:options documentAttributes:nil error:nil];
            strongSelf.testV.attributedText = attrs;
//            CGSize size =[YGetAttribute getSpaceHeight:str size:CGSizeMake(__kWidth-37, MAXFLOAT) rowHeight:6 font:MFont(14)];
//            strongSelf.mainLb.attributedText = [YGetAttribute getSpaceString:str size:CGSizeMake(__kWidth-37, MAXFLOAT) rowHeight:6 font:MFont(14)];
//            strongSelf.mainLb.frame = CGRectMake(16, 45+20, __kWidth-37, size.height);
//            strongSelf.scrollV.contentSize = CGSizeMake(0, size.height+30+65);
        }
    } failure:^(NSError *error) {

    } animated:YES];

}
//去除字符串中用括号括住的位置
-(NSString *)handleStringWithString:(NSString *)str{

    NSMutableString * muStr = [NSMutableString stringWithString:str];
    while (1) {
        NSRange range = [muStr rangeOfString:@"{"];
        NSRange range1 = [muStr rangeOfString:@"}"];
        if (range.location != NSNotFound) {
            NSInteger loc = range.location;
            NSInteger len = range1.location - range.location;
            [muStr deleteCharactersInRange:NSMakeRange(loc, len + 1)];
        }else{
            break;
        }
    }

    return muStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"公告详情";
    [self initView];
    [self getData];
}
-(void)initView{
    _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:_scrollV];
    _scrollV.backgroundColor = [UIColor whiteColor];
    _scrollV.pagingEnabled = NO;
    _scrollV.showsVerticalScrollIndicator = NO;
    _scrollV.showsHorizontalScrollIndicator = NO;
    _scrollV.contentSize = CGSizeMake(0, __kHeight-64);

    _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, __kWidth, 20)];
    [_scrollV addSubview:_titleLb];
    _titleLb.textAlignment = NSTextAlignmentCenter;
    _titleLb.textColor = [UIColor blackColor];
    _titleLb.font = MFont(18);

    UIImageView *lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth-20, 1)];
    [_scrollV addSubview:lineIV];
    lineIV.backgroundColor = __BackColor;

    _testV = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectYH(lineIV)+20, __kWidth-20, __kHeight-64-65)];
    [_scrollV addSubview:_testV];
    _testV.font = MFont(14);
    _testV.delegate = self;
    _testV.showsVerticalScrollIndicator = NO;
    _testV.showsHorizontalScrollIndicator = NO;


}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
