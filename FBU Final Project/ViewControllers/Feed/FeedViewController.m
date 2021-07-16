//
//  FeedViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "FeedViewController.h"
#import "SwipeCollectionViewCell.h"

@interface FeedViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation FeedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpCollectionView];
    self.view.backgroundColor = UIColor.redColor;
}

- (void)setUpCollectionView{
    self.collectionView = [[UICollectionView alloc]init];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.collectionView registerClass:[SwipeCollectionViewCell class] forCellWithReuseIdentifier:@"SwipeCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 50;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SwipeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SwipeCollectionViewCell" forIndexPath:indexPath];
    
    UIColor *cellBackgroundColor;
    NSInteger cellRemainder = indexPath.row % 5;
    
    switch (cellRemainder) {
        case 0:
            cellBackgroundColor = UIColor.systemRedColor;
            break;
        case 1:
            cellBackgroundColor = UIColor.systemOrangeColor;
            break;
        case 2:
            cellBackgroundColor = UIColor.systemYellowColor;
            break;
        case 3:
            cellBackgroundColor = UIColor.systemGreenColor;
            break;
        case 4:
            cellBackgroundColor = UIColor.systemBlueColor;
            break;
        default:
            cellBackgroundColor = UIColor.systemPurpleColor;
            break;
    }
    
    cell.contentView.backgroundColor = cellBackgroundColor;
    
    return cell;
}

@end
