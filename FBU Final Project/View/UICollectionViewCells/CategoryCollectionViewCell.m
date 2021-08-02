//
//  CategoryCollectionViewCell.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.itemImageView = [[UIImageView alloc]init];
        self.itemImageView.contentMode = UIViewContentModeScaleAspectFill;
        self.itemImageView.layer.masksToBounds = YES;
        self.itemImageView.clipsToBounds = YES;
        self.itemImageView.layer.cornerRadius = 8;
        self.itemImageView.backgroundColor = UIColor.secondarySystemBackgroundColor;
        self.itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        [self.contentView addSubview:self.itemImageView];
        
        [NSLayoutConstraint activateConstraints:@[
            [self.itemImageView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
            [self.itemImageView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
            [self.itemImageView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
            [self.itemImageView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor]
        ]];
    }
    return self;
}

@end
