//
//  FeedViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "FeedViewController.h"

@interface FeedViewController ()

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
    [self.view addSubview:self.collectionView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.collectionView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.collectionView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
}

@end
