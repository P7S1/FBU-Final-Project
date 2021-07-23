//
//  ListingItemViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/21/21.
//

#import <SDWebImage/SDWebImage.h>
#import "ListingItemDetailViewController.h"
#import "ItemListing.h"
#import "ZoomAnimatorDelegate.h"
#import "ZoomTransitionController.h"
#import "BasicButton.h"
#import "DesignHelper.h"

@interface ListingItemDetailViewController()<ZoomAnimatorDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView* imageView;
@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UILabel* priceLabel;
@property (nonatomic, strong) UILabel* descriptionLabel;
@property (nonatomic, strong) UILabel* dateLabel;
@property (nonatomic, strong) BasicButton* addToCartButton;
@property (nonatomic, strong) UIPanGestureRecognizer* panGestureRecognizer;

@end

@implementation ListingItemDetailViewController

- (instancetype)initWithListing:(ItemListing*)listing{
    self = [super init];
    if (self) {
        self.item = listing;
        self.transitionController = [[ZoomTransitionController alloc]init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpPanGestureRecognizer];
    [self setUpInitialViewElements];
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.navigationItem.title = self.item.name;
}

- (void)setUpInitialViewElements{
    self.imageView = [[UIImageView alloc]init];
    self.imageView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    self.imageView.layer.masksToBounds = YES;
    NSString* str = self.item.imageUrl;
    if (str){
        NSURL* url = [[NSURL alloc]initWithString:str];
        [self.imageView sd_setImageWithURL:url];
    }
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.imageView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width],
        [self.imageView.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width * 1.33]
    ]];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.view.layer.cornerRadius = 50;
    self.view.layer.shadowColor = UIColor.darkGrayColor.CGColor;
    self.view.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    self.view.layer.shadowRadius = 12.0;
    self.view.layer.shadowOpacity = 0.7;
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.text = @"Title goes here";
    self.titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.titleLabel.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
        [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.imageView.topAnchor constant:-8],
    ]];
    
    self.priceLabel = [[UILabel alloc]init];
    self.priceLabel.text = @"$2.99";
    self.priceLabel.textColor = UIColor.systemGreenColor;
    self.priceLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightBold];
    self.priceLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.titleLabel];
    
    self.descriptionLabel = [[UILabel alloc]init];
    self.descriptionLabel.text = @"Description Label la la la la la la la";
    self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.descriptionLabel.textColor = UIColor.labelColor;
    
    self.dateLabel = [[UILabel alloc]init];
    self.dateLabel.textColor = UIColor.secondaryLabelColor;
    self.dateLabel.text = @"3 days ago";
    self.dateLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.addToCartButton = [[BasicButton alloc]init];
    [self.addToCartButton setTitle:@"Add to Cart" forState:UIControlStateNormal];
    self.addToCartButton.backgroundColor = [DesignHelper buttonBackgroundColor];
    [self.addToCartButton setTitleColor:[DesignHelper buttonTitleLabelColor] forState:UIControlStateNormal];
    [[self.addToCartButton.heightAnchor constraintEqualToConstant:50.0] setActive:YES];
    
    UIStackView* stackView = [[UIStackView alloc]initWithArrangedSubviews:@[
        self.priceLabel,
        self.descriptionLabel,
        self.dateLabel,
        self.addToCartButton
    ]];
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    stackView.axis = UILayoutConstraintAxisVertical;
    
    [self.view addSubview:stackView];
    
    [NSLayoutConstraint activateConstraints:@[
        [stackView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16],
        [stackView.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:8],
        [stackView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16]
    ]];
}

//MARK:- UIPanGestureRecognizer

- (void)setUpPanGestureRecognizer{
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(didPanWith:)];
    self.panGestureRecognizer.delegate = self;
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)didPanWith: (UIPanGestureRecognizer*)gestureRecognizer{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            [self handlePangestureRecognizerBegan:gestureRecognizer];
            break;
        case UIGestureRecognizerStateEnded:
            [self handlePangestureRecognizerEnded:gestureRecognizer];
            break;
        default:
            if (self.transitionController.isInteractive){
                [self.transitionController didPanWith:gestureRecognizer];
            }
            break;
    }
}

- (void)handlePangestureRecognizerBegan: (UIPanGestureRecognizer*)gestureRecognizer{
    self.transitionController.isInteractive = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)handlePangestureRecognizerEnded: (UIPanGestureRecognizer*)gestureRecognizer{
    if (self.transitionController.isInteractive){
        self.transitionController.isInteractive = NO;
        [self.transitionController didPanWith:gestureRecognizer];
    }
}

//MARK:- ZoomAnimatorDelegate
- (UIImageView *)refereneImageViewFor:(ZoomAnimator *)zoomAnimator{
    return self.imageView;
}

- (CGRect)refereneImageViewFrameInTransitioningViewFor:(ZoomAnimator *)zoomAnimator{
    return CGRectMake(0, 162.667, UIScreen.mainScreen.bounds.size.width, UIScreen.mainScreen.bounds.size.width * 1.33);
}

- (void)transitionDidEndWith:(ZoomAnimator *)zoomAnimator {}

- (void)transitionWillStartWith:(ZoomAnimator *)zoomAnimator {}

@end
