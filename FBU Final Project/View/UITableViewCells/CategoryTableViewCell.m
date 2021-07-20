//
//  CategoryTableViewCell.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/19/21.
//

#import "CategoryTableViewCell.h"
#import "CategoryCollectionViewCell.h"

@interface CategoryTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView* collectionView;
@property (nonatomic, strong) UIStackView* stackView;

@end

@implementation CategoryTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpStackView];
        [self setUpTitleView];
        [self setUpCollectionView];
    }
    return self;
}

- (void)setUpStackView{
    self.stackView = [[UIStackView alloc]init];
    self.stackView.axis = UILayoutConstraintAxisVertical;
    self.stackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.stackView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.stackView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],
        [self.stackView.leftAnchor constraintEqualToAnchor:self.contentView.leftAnchor],
        [self.stackView.rightAnchor constraintEqualToAnchor:self.contentView.rightAnchor]
    ]];
}

- (void)setUpTitleView{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"Title goes here";
    self.titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.titleLabel];
    
    UIView *const containerView = [[UIView alloc]init];
    containerView.translatesAutoresizingMaskIntoConstraints = NO;
    [containerView addSubview:self.titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [containerView.heightAnchor constraintEqualToAnchor:self.titleLabel.heightAnchor],
        [self.titleLabel.leftAnchor constraintEqualToAnchor:containerView.leftAnchor constant:16],
        [self.titleLabel.centerXAnchor constraintEqualToAnchor:containerView.centerXAnchor]
    ]];
    
    [self.stackView addArrangedSubview:containerView];
}

- (void)setUpCollectionView{
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 8.0;
    layout.minimumInteritemSpacing = 8.0;
    layout.itemSize = CGSizeMake(100, 133);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:UIScreen.mainScreen.bounds collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = UIColor.systemBackgroundColor;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 16, 0, 16);
    [self.contentView addSubview:self.collectionView];
    
    [self.stackView addArrangedSubview:self.collectionView];
    
    [self.collectionView registerClass:[CategoryCollectionViewCell class] forCellWithReuseIdentifier:@"CategoryCollectionViewCell"];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    CategoryCollectionViewCell* cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"CategoryCollectionViewCell" forIndexPath:indexPath];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

@end