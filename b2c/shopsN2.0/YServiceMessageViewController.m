//
//  YServiceMessageViewController.m
//  shopsN
//
//  Created by imac on 2017/1/20.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YServiceMessageViewController.h"
#import "ChatViewController.h"

@interface YServiceMessageViewController ()

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic)  UIImageView *lineIV;

@property (strong,nonatomic) UILabel *mainLb;

@property (strong,nonatomic) UILabel *titleLb;

@property (strong,nonatomic) NSString *mainText;

@property (strong,nonatomic) UITextView *testV;

@end

@implementation YServiceMessageViewController

-(void)getData{
    WK(weakSelf)
    __typeof(&*weakSelf) strongSelf = weakSelf;
    [JKHttpRequestService POST:@"Pcenter/articleDetail" withParameters:@{@"id":_model.titleId} success:^(id responseObject, BOOL succe, NSDictionary *jsonDic) {
        if (succe) {
            NSString *str = jsonDic[@"data"];
            strongSelf.titleLb.text = _model.titleName;
            NSDictionary *options =@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
            NSData *data = [str dataUsingEncoding:NSUnicodeStringEncoding];
            NSAttributedString *attr = [[NSAttributedString alloc]initWithData:data options:options documentAttributes:nil error:nil];
            strongSelf.testV.attributedText = attr;

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
    self.title = @"详情页";
    [self.rightBtn setImage:MImage(@"head_service") forState:BtnNormal];
    [self initView];
    [self getData];
}

-(void)chooseRight{
    ChatViewController *vc = [[ChatViewController alloc]initWithConversationChatter:HXchatter conversationType:eConversationTypeChat];
    YNavigationController *navi = [[YNavigationController alloc]initWithRootViewController:vc];
    [self presentViewController:navi animated:NO completion:nil];
}

-(void)initView{
    [self.view addSubview:self.scrollV];
    [_scrollV addSubview:self.titleLb];
    [_scrollV addSubview:self.lineIV];
//    [_scrollV addSubview:self.mainLb];
    [_scrollV addSubview:self.testV];
}

#pragma mark ==懒加载==
-(UIScrollView *)scrollV{
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
        _scrollV.backgroundColor = [UIColor whiteColor];
        _scrollV.pagingEnabled = NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.showsHorizontalScrollIndicator = NO;
        _scrollV.contentSize = CGSizeMake(0, __kHeight-64);
    }
    return _scrollV;
}

-(UILabel *)titleLb{
    if (!_titleLb) {
        _titleLb = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, __kWidth, 20)];
        _titleLb.textAlignment = NSTextAlignmentCenter;
        _titleLb.textColor = [UIColor blackColor];
        _titleLb.font = MFont(18);
    }
    return _titleLb;
}

-(UIImageView *)lineIV{
    if (!_lineIV) {
        _lineIV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 44, __kWidth-20, 1)];
        _lineIV.backgroundColor = __BackColor;
    }
    return _lineIV;
}

-(UILabel *)mainLb{
    if (!_mainLb) {
        _mainLb = [[UILabel alloc]initWithFrame:CGRectMake(16, CGRectYH(_lineIV)+20, __kWidth-37, __kHeight-64-65-30)];
        _mainLb.textAlignment = NSTextAlignmentLeft;
        _mainLb.font = MFont(14);
        _mainLb.textColor = __DTextColor;
        _mainLb.numberOfLines = 0;
    }
    return _mainLb;
}

- (UITextView *)testV {
    if (!_testV) {
        _testV = [[UITextView alloc]initWithFrame:CGRectMake(10, CGRectYH(_lineIV)+20, __kWidth-20, __kHeight-64-65)];
        _testV.font = MFont(14);
        _testV.delegate = self;
        _testV.showsVerticalScrollIndicator = NO;
        _testV.showsHorizontalScrollIndicator = NO;
    }
    return _testV;
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
