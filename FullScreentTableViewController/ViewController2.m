//
//  ViewController2.m
//  FullScreentScrollViewController
//
//  Created by tanson on 2017/1/11.
//  Copyright © 2017年 chatchat. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()<UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;
@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(UICollectionView *)collectionView{
    if(!_collectionView){
        UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
        layout.itemSize = CGSizeMake((self.view.bounds.size.width - 100) / 4, self.view.bounds.size.width / 4);
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect frame = self.view.bounds;
    self.collectionView.frame = frame;
}

-(UIScrollView *)scrollView{
    return self.collectionView;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 40;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

@end
