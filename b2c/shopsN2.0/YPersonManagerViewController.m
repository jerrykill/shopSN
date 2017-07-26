//
//  YPersonManagerViewController.m
//  shopsN
//
//  Created by imac on 2016/12/7.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPersonManagerViewController.h"
#import "YPersonManagerCell.h"

#import "YPersonInfoViewController.h"
#import "YChangePasswordViewController.h"

@interface YPersonManagerViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong,nonatomic) UICollectionView *mainV;


@property (strong,nonatomic) NSArray *titleArr;

@property (strong,nonatomic) NSArray *imageArr;



@end

@implementation YPersonManagerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户管理";
    _titleArr = @[@"个人资料",@"修改密码"];
    _imageArr =@[@"Account_ico_01",@"Account_ico_02"];
    [self initView];
}

-(void)initView{
    UIImageView *backIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64)];
    [self.view addSubview:backIV];
    backIV.image = MImage(@"manage_bg");
    [self.view sendSubviewToBack:backIV];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];

    _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, __kWidth, __kHeight-64) collectionViewLayout:flowLayout];
    [self.view addSubview:_mainV];
    _mainV.delegate = self;
    _mainV.dataSource = self;
    _mainV.backgroundColor = [UIColor clearColor];
    [_mainV registerClass:[YPersonManagerCell class] forCellWithReuseIdentifier:@"YPersonManagerCell"];
}

#pragma mark ==UICollectionViewDelegate And DataSource==
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YPersonManagerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPersonManagerCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YPersonManagerCell alloc]init];
    }
    cell.titleLb.text = _titleArr[indexPath.row];
    cell.headIV.image = MImage(_imageArr[indexPath.row]);
    return cell;
}
//内容距离屏幕边缘的距离 参数顺序是top,left,bottom,right
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(41, 26, 0, 26);
}

//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((__kWidth-54)/2, (__kWidth-54)*21/32);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
        {
            YPersonInfoViewController *vc = [[YPersonInfoViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            YChangePasswordViewController *vc = [[YChangePasswordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

        default:
            break;
    }
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
