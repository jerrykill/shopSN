
//
//  YPicPutView.m
//  shopsN
//
//  Created by imac on 2016/12/24.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPicPutView.h"
#import "YPicInputCell.h"

@interface YPicPutView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,YPicInputCellDelegate>

@property (strong,nonatomic) UICollectionView *mainV;

@end

@implementation YPicPutView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

-(void)initView{
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 82) collectionViewLayout:flowLayout];
    [self addSubview:_mainV];
    _mainV.delegate = self;
    _mainV.dataSource =self;
    _mainV.scrollEnabled = NO;
    _mainV.backgroundColor = [UIColor clearColor];

    [_mainV registerClass:[YPicInputCell class] forCellWithReuseIdentifier:@"YPicInputCell"];

    UILabel *warnLb = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectYH(_mainV)+8, __kWidth-20, 15)];
    [self addSubview:warnLb];
    warnLb.textAlignment = NSTextAlignmentLeft;
    warnLb.textColor = LH_RGBCOLOR(204, 204, 204);
    warnLb.font = MFont(11);
    warnLb.text = @"最多添加3张，每张不超过5M，支持jpg、bmp、png";

}

#pragma mark ==UICollectionViewDelegate==

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imageArr.count==3) {
        return _imageArr.count;
    }else{
        return _imageArr.count +1;
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YPicInputCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YPicInputCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YPicInputCell alloc]init];
    }
    cell.tag = indexPath.row;
    cell.delegate = self;
    if (indexPath.row == _imageArr.count) {
        cell.isAdd = YES;
    }else{
        cell.image =[UIImage imageWithData:_imageArr[indexPath.row]] ;
    }
    return cell;
}

//内容距离屏幕边缘的距离 参数顺序是top,left,bottom,right
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(0, 4, 0, 10);
}

//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 6;
}
//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(82, 82);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=_imageArr.count) {
        [self.delegate addPhoto];
    }
}

#pragma mark ==YPicInputCellDelegate==
-(void)deletePic:(NSInteger)index{
    [self.delegate deleteImgIndex:index];
}

-(void)setImageArr:(NSMutableArray *)imageArr{
    _imageArr = imageArr;
    [_mainV reloadData];
}


@end
