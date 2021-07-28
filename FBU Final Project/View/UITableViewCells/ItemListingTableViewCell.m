//
//  ItemListingTableViewCell.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import "ItemListingTableViewCell.h"

@interface ItemListingTableViewCell()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* descriptonLabel;
@property (nonatomic, strong) UILabel* priceLabel;

@property (nonatomic, strong) UIImageView* itemImageView;

@end

@implementation ItemListingTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self commonInit];
    }
    return self;
}

- (void)commonInit{
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"Title";
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.textColor = UIColor.labelColor;
    
    self.itemImageView = [[UIImageView alloc]init];
    self.itemImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.itemImageView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.itemImageView.translatesAutoresizingMaskIntoConstraints = NO;
    self.itemImageView.layer.cornerRadius = 20;
    self.itemImageView.layer.masksToBounds = YES;
    self.itemImageView.clipsToBounds = YES;
    CGFloat const itemImageViewSizeConstant = UIScreen.mainScreen.bounds.size.width - 32;
    [NSLayoutConstraint activateConstraints:@[
        [self.itemImageView.heightAnchor constraintEqualToConstant:itemImageViewSizeConstant],
        [self.itemImageView.widthAnchor constraintEqualToConstant:itemImageViewSizeConstant]
    ]];
    
    self.descriptonLabel = [[UILabel alloc]init];
    self.descriptonLabel.text = @"Description Label la la la la la la la";
    self.descriptonLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptonLabel.textColor = UIColor.labelColor;
    
    UIStackView* stackView = [[UIStackView alloc]initWithArrangedSubviews:@[
        self.titleLabel,
        self.itemImageView,
        self.descriptonLabel
    ]];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.spacing = 4;
    
    [self addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:32],
        [stackView.bottomAnchor constraintLessThanOrEqualToAnchor:self.bottomAnchor constant:-32],
        [stackView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor]
    ]];
}

- (void)setUpWithItemListing:(ItemListing*)item{
    
}

@end
