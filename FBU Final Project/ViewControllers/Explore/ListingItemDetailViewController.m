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

@interface ListingItemDetailViewController()<ZoomAnimatorDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIImageView* imageView;
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
}

- (void)setUpInitialViewElements{
    
    
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
            [self handlePangestureRecognizerDefault:gestureRecognizer];
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

- (void)handlePangestureRecognizerDefault: (UIPanGestureRecognizer*)gestureRecognizer{
    
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
