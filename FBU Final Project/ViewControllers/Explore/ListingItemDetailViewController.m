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

@interface ListingItemDetailViewController()<ZoomAnimatorDelegate>

@property (nonatomic, strong) UIImageView* imageView;

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
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    self.navigationItem.title = self.item.name;
    
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
        [self.imageView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width],
        [self.imageView.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width * 1.33]
    ]];
}

- (void)setUpInitialViewElements{
    
    
}

- (UIImageView *)refereneImageViewFor:(ZoomAnimator *)zoomAnimator{
    return self.imageView;
}

- (CGRect)refereneImageViewFrameInTransitioningViewFor:(ZoomAnimator *)zoomAnimator{
    return self.imageView.frame;
}

- (void)transitionDidEndWith:(ZoomAnimator *)zoomAnimator {}

- (void)transitionWillStartWith:(ZoomAnimator *)zoomAnimator {}

@end
