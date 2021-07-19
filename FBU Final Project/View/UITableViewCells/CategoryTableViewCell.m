//
//  CategoryTableViewCell.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import "CategoryTableViewCell.h"

@interface CategoryTableViewCell()

@property (nonatomic, strong) UICollectionView* collectionView;

@end

@implementation CategoryTableViewCell

- (instancetype)init{
    self = [super init];
    if (self) {
        [self setUpCollectionView];
        [self setUpTitleView];
    }
    return self;
}

- (void)setUpTitleView{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"Title goes here";
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:16],
        [self.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor constant:16],
        [self.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor constant:-16]
    ]];
}

- (void)setUpCollectionView{
    self.collectionView = [[UICollectionView alloc]init];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.collectionView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.titleLabel.bottomAnchor constant:8],
        [self.collectionView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
        [self.collectionView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor]
    ]];
}

@end
