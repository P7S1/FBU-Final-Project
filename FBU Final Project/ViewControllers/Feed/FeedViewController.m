//
//  FeedViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "FeedViewController.h"
#import "SwipeCollectionViewCell.h"
#import "SwipableCardViewContainer.h"
#import "SwipeableCardViewDataSource.h"
#import "SwipableCardViewCard.h"

@interface FeedViewController ()<SwipableCardViewDelegate, SwipeableCardViewDataSource>

@property (nonatomic, strong) SwipableCardViewContainer *cardContainerView;

@end

@implementation FeedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpCardContainerView];
    self.navigationItem.title = @"For You";
    self.view.backgroundColor = UIColor.systemBackgroundColor;
}

- (void)setUpCardContainerView{
    self.cardContainerView = [[SwipableCardViewContainer alloc]init];
    self.cardContainerView.delegate = self;
    self.cardContainerView.dataSource = self;
    
    self.cardContainerView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.cardContainerView];
    
    CGFloat const width = UIScreen.mainScreen.bounds.size.width - 32;
    
    [NSLayoutConstraint activateConstraints:@[
        [self.cardContainerView.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.cardContainerView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor],
        [self.cardContainerView.heightAnchor constraintEqualToConstant:width * 1.33],
        [self.cardContainerView.widthAnchor constraintEqualToConstant:width]
    ]];
    
    [self.cardContainerView reloadData];
}

- (void)didSelectCard:(nonnull SwipableCardViewCard *)card atIndex:(NSInteger)index {}

- (void)didSwipeAwayView:(nonnull SwipableCardViewCard *)view towardsDirection:(PanelButtonPosition)direction {}


- (SwipableCardViewCard * _Nullable)cardForItemAtIndex:(NSInteger)index {
    SwipableCardViewCard* card = [self.cardContainerView dequeueReusableCardView];
    
    NSInteger const remainder = index % 5;
    UIColor *color;
    
    switch (remainder) {
        case 0:
            color = UIColor.systemRedColor;
            break;
        case 1:
            color = UIColor.systemOrangeColor;
            break;
        case 2:
            color = UIColor.systemYellowColor;
            break;
        case 3:
            color = UIColor.systemGreenColor;
            break;
        case 4:
            color = UIColor.systemBlueColor;
            break;
        default:
            color = UIColor.systemPurpleColor;
            break;
    }
    
    card.backgroundColor = color;
    
    return card;
}

- (NSInteger)numberOfCards {
    return 20;
}

- (UIView * _Nullable)viewForEmptyCards {
    return nil;
}

@end
