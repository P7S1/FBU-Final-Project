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

@interface FeedViewController ()<SwipableCardViewDelegate, SwipeableCardViewDataSource>

@property (nonatomic, strong) SwipableCardViewContainer *cardContainerView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;

@end

@implementation FeedViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpCardContainerView];
    [self startListingsSnapshotListener];
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

- (void)didSelectCard:(nonnull SwipableCardViewCard *)card atIndex:(NSInteger)index {}

- (void)didSwipeAwayView:(nonnull SwipableCardViewCard *)view towardsDirection:(PanelButtonPosition)direction {}


- (SwipableCardViewCard * _Nullable)cardForItemAtIndex:(NSInteger)index {
    SwipableCardViewCard* card = [self.cardContainerView dequeueReusableCardView];
    ItemListing* item = self.items[index];
    card.titleLabel.text = item.name;
    card.descriptionLabel.text = item.description;
    if (item.imageUrl != nil){
        NSURL* url = [[NSURL alloc]initWithString:item.imageUrl];
        [card.itemImageView sd_setImageWithURL:url];
    }else{
        card.itemImageView.image = nil;
    }
    switch (index % 3) {
        case 0:
            card.gradientLayer.colors = @[(id)[UIColor systemTealColor].CGColor, (id)[UIColor systemBlueColor].CGColor];
            break;
        case 1:
            card.gradientLayer.colors = @[(id)[UIColor systemOrangeColor].CGColor, (id)[UIColor systemRedColor].CGColor];
            break;
        case 2:
            card.gradientLayer.colors = @[(id)[UIColor systemGreenColor].CGColor, (id)[UIColor greenColor].CGColor];
            break;
        default:
            break;
    }
    return card;
}

- (NSInteger)numberOfCards {
    return self.items.count;
}

- (UIView * _Nullable)viewForEmptyCards {
    return nil;
}

@end
