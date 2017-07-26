//
//  YGuideViewController.m
//  shopsN
//
//  Created by imac on 2017/1/21.
//  Copyright © 2017年 联系QQ:1084356436. All rights reserved.
//

#import "YGuideViewController.h"

@interface YGuideViewController ()<UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollV;

@property (strong,nonatomic) UIButton *homeBtn;

/** 视图定时器 */
@property (nonatomic, strong) NSTimer *timer;

@property (assign,nonatomic) CGFloat cashLoc;


@end

@implementation YGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //开启定时器
    [_timer setFireDate:[NSDate distantPast]];
    [self initView];

}

- (void)initView {
    [self.view addSubview:self.scrollV];
    [_scrollV addSubview:self.homeBtn];

    //scrollView动画播放
    _timer = [NSTimer scheduledTimerWithTimeInterval:4.0f target:self selector:@selector(playingWelcomeImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];

}

#pragma mark ==懒加载==
- (UIScrollView *)scrollV {
    if (!_scrollV) {
        _scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, __kHeight)];
        _scrollV.pagingEnabled = YES;
        _scrollV.showsVerticalScrollIndicator =NO;
        _scrollV.showsVerticalScrollIndicator = NO;
        _scrollV.delegate = self;
        NSArray *imageArr = @[@"guide1",@"guide2",@"guide3"];
        for (int i=0; i<imageArr.count; i++) {
            UIImageView *imageIV = [[UIImageView alloc]initWithFrame:CGRectMake(__kWidth*i, 0, __kWidth, __kHeight)];
            [_scrollV addSubview:imageIV];
            imageIV.image = MImage(imageArr[i]);
        }
        _scrollV.contentSize = CGSizeMake(__kWidth*imageArr.count, 0);
    }
    return _scrollV;
}

- (UIButton *)homeBtn {
    if (!_homeBtn) {
        _homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(__kWidth*2+30, __kHeight-60, __kWidth-60, 38)];
        [_scrollV bringSubviewToFront:_homeBtn];
        _homeBtn.backgroundColor = [UIColor clearColor];
        [_homeBtn addTarget:self action:@selector(chooseHome) forControlEvents:BtnTouchUpInside];
    }
    return _homeBtn;
}


- (void)chooseHome {
    //第一次浏览完欢迎界面之后就不再显示了
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:@"isVisibled"];
    [ud synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark --- scrollView delegate
//************ 设置pageControl *************
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   _cashLoc = _scrollV.contentOffset.x;
}

#pragma mark - scrollView 动画播放
- (void)playingWelcomeImage {
    if (_cashLoc==__kWidth*2) {
        [_timer setFireDate:[NSDate distantFuture]];//暂停
    }else{
        _cashLoc +=__kWidth;
    }
    _scrollV.contentOffset = CGPointMake(_cashLoc, 0);
}

- (void)dealloc {
    //取消定时器
    [_timer invalidate];
    _timer = nil;
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
