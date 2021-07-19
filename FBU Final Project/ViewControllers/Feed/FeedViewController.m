//
//  FeedViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "FeedViewController.h"
#import "SwipableCardViewContainer.h"
#import "SwipeableCardViewDataSource.h"
#import "SwipableCardViewCard.h"
#import "FirebaseFirestoreHelper.h"
#import "ItemListing.h"

@interface FeedViewController ()<SwipableCardViewDelegate, SwipeableCardViewDataSource>

@property (nonatomic, strong) SwipableCardViewContainer *cardContainerView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;

@end

@implementation FeedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpCardContainerView];
    [self fetchListings];
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

- (void)fetchListings{
    [FirebaseFirestoreHelper fetchAllListingsWithCompletion:^(NSArray<ItemListing *> * _Nullable results, NSError * _Nullable error) {
        if (error == nil){
            self.items = results;
            [self.cardContainerView reloadData];
        }else{
            NSLog(@"Fetching Listings Failure: %@",[error localizedDescription]);
        }
    }];
}

- (void)didSelectCard:(nonnull SwipableCardViewCard *)card atIndex:(NSInteger)index {}

- (void)didSwipeAwayView:(nonnull SwipableCardViewCard *)view towardsDirection:(PanelButtonPosition)direction {}


- (SwipableCardViewCard * _Nullable)cardForItemAtIndex:(NSInteger)index {
    SwipableCardViewCard* card = [self.cardContainerView dequeueReusableCardView];
    return card;
}

- (NSInteger)numberOfCards {
    return 10;
}

- (UIView * _Nullable)viewForEmptyCards {
    return nil;
}

@end
