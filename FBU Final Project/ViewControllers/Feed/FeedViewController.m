//
//  FeedViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <SDWebImage/SDWebImage.h>
#import "FeedViewController.h"
#import "SwipableCardViewContainer.h"
#import "SwipeableCardViewDataSource.h"
#import "SwipableCardViewCard.h"
#import "FirebaseFirestoreHelper.h"
#import "ItemListing.h"
#import "ZoomAnimatorDelegate.h"
#import "ListingItemDetailViewController.h"
#import "CartHelper.h"
#import "BasicButton.h"

@interface FeedViewController ()<SwipableCardViewDelegate, SwipeableCardViewDataSource, ZoomAnimatorDelegate>

@property (nonatomic, strong) SwipableCardViewContainer *cardContainerView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;
@property (nonatomic, strong, nullable) SwipableCardViewCard* tappedCard;

@property (nonatomic, strong) BasicButton* yesDecisionButton;
@property (nonatomic, strong) BasicButton* noDecisionButton;

@end

@implementation FeedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpCardContainerView];
    [self startListingsSnapshotListener];
    [self setUpDecisionButtons];
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
        [self.cardContainerView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:16],
        [self.cardContainerView.centerXAnchor constraintEqualToAnchor: self.view.centerXAnchor],
        [self.cardContainerView.heightAnchor constraintEqualToConstant:width * 1.33],
        [self.cardContainerView.widthAnchor constraintEqualToConstant:width]
    ]];
    
    [self.cardContainerView reloadData];
}

//MARK:- Handling of Decision Buttons
- (void)setUpDecisionButtons{
    
}

- (BasicButton*)getDecisionButtonWithColor: (UIColor*)color{
    BasicButton* button = [[BasicButton alloc]init];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.tintColor = color;
    button.layer.borderColor = color.CGColor;
    button.layer.borderWidth = 4;
    
    [NSLayoutConstraint activateConstraints:@[
        [button.heightAnchor constraintEqualToConstant:50],
        [button.widthAnchor constraintEqualToConstant:50]
    ]];
    
    return button;
}

- (void)yesDecisionButtonPressed{
    
}

- (void)noDecisionButtonPressed{
    
}

- (void)hideDecisionButtons{
    
}

- (void)startListingsSnapshotListener{
    [FirebaseFirestoreHelper addSnapshotListenerWithCompletion:^(NSArray<ItemListing *> * _Nullable results, NSError * _Nullable error) {
        if (error == nil){
            self.items = results;
            [self.cardContainerView reloadData];
        }else{
            NSLog(@"Fetching Listings Failure: %@",[error localizedDescription]);
        }
    }];
}

- (void)didSelectCard:(nonnull SwipableCardViewCard *)card atIndex:(NSInteger)index {
    self.tappedCard = card;
    ListingItemDetailViewController* vc = [[ListingItemDetailViewController alloc]initWithListing:self.items[index]];
    
    self.navigationController.delegate = vc.transitionController;
    vc.transitionController.fromDelegate = self;
    vc.transitionController.toDelegate = vc;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didSwipeAwayView:(nonnull SwipableCardViewCard *)view towardsDirection:(PanelButtonPosition)direction{
    if (direction == right){
        [CartHelper addItemToCart:view.itemListing];
    }
}

- (SwipableCardViewCard * _Nullable)cardForItemAtIndex:(NSInteger)index {
    SwipableCardViewCard* card = [self.cardContainerView dequeueReusableCardView];
    ItemListing* item = self.items[index];
    card.itemListing = item;
    card.titleLabel.text = item.name;
    card.descriptionLabel.text = item.description;
    if (item.imageUrl != nil){
        NSURL* url = [[NSURL alloc]initWithString:item.imageUrl];
        [card.itemImageView sd_setImageWithURL:url];
        [card.backgroundImageView sd_setImageWithURL:url];
    }else{
        card.itemImageView.image = nil;
        card.backgroundImageView.image = nil;
    }
    return card;
}

- (NSInteger)numberOfCards {
    return self.items.count;
}

- (UIView * _Nullable)viewForEmptyCards {
    return nil;
}

- (UIImageView *)refereneImageViewFor:(ZoomAnimator *)zoomAnimator {
    return self.tappedCard.itemImageView;
}

- (CGRect)refereneImageViewFrameInTransitioningViewFor:(ZoomAnimator *)zoomAnimator {
    return [self.tappedCard.itemImageView convertRect:self.tappedCard.itemImageView.bounds toView:self.view];
}

- (void)transitionDidEndWith:(ZoomAnimator *)zoomAnimator {}

- (void)transitionWillStartWith:(ZoomAnimator *)zoomAnimator {}

@end
