//
//  YPutPictureView.m
//  shopsN
//
//  Created by imac on 2016/12/8.
//  Copyright © 2016年 联系QQ:1084356436. All rights reserved.
//

#import "YPutPictureView.h"
#import "YOrderPictureCell.h"

@interface YPutPictureView()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong,nonatomic) UICollectionView *mainV;

@end

@implementation YPutPictureView

-(instancetype)initWithFrame:(CGRect)frame{
    if ( self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView{
    UICollectionViewFlowLayout *flowLayout =[[UICollectionViewFlowLayout alloc]init];
    _mainV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, __kWidth, 80) collectionViewLayout:flowLayout];
    [self addSubview:_mainV];
    _mainV.delegate = self;
    _mainV.dataSource =self;
    _mainV.scrollEnabled = NO;
    _mainV.backgroundColor = [UIColor clearColor];

    [_mainV registerClass:[YOrderPictureCell class] forCellWithReuseIdentifier:@"YOrderPictureCell"];

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
    YOrderPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YOrderPictureCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[YOrderPictureCell alloc]init];
    }
    if (indexPath.row >= _imageArr.count) {
        cell.addIV.image = MImage(@"camera_add");

    }else{
        if ([_imageArr[indexPath.row] isKindOfClass:[NSString class]]) {
            [cell.goodIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",HomeADUrl,_imageArr[indexPath.row]]] placeholderImage:MImage(goodPlachorName)];
        }else{
            cell.goodIV.image = [UIImage imageWithData:_imageArr[indexPath.row]] ;
        }
        cell.addIV.hidden = YES;
    }
    return cell;
}

//内容距离屏幕边缘的距离 参数顺序是top,left,bottom,right
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return  UIEdgeInsetsMake(1, 10, 1, 10);
}

//x 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 7;
}
//y 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(79, 79);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row>=_imageArr.count) {
        [self.delegate addPhoto];
    }
}

-(void)setImageArr:(NSMutableArray *)imageArr{
    _imageArr = imageArr;
    [_mainV reloadData];
}
@end
