//
//  SwipableCardViewContainer.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import "SwipableCardViewContainer.h"
#import "SwipableCardViewCard.h"
#import "SwipeableCardViewDataSource.h"

@interface SwipableCardViewContainer ()<SwipableViewDelegate>

@property (nonatomic) NSInteger const numberOfVisibleCards;
@property (nonatomic) NSInteger const horizontalInset;
@property (nonatomic) NSInteger const verticalInset;

@property (nonatomic, strong) NSMutableArray<SwipableCardViewCard*>* cardViews;
@property (nonatomic, strong) NSArray<SwipableCardViewCard*>* visibleCardViews;

@property (nonatomic) NSInteger remainingCards;

@end

@implementation SwipableCardViewContainer

- (instancetype)init{
    self = [super init];
    if (self) {
        self.numberOfVisibleCards = 3;
        self.horizontalInset = 12;
        self.verticalInset = 12;
        
        self.cardViews = [[NSMutableArray alloc]init];
        self.visibleCardViews = [[NSArray alloc]init];
        
        self.remainingCards = 0;
        
        self.backgroundColor = UIColor.clearColor;
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)reloadData{
    [self removeAllCardViews];
    if (self.dataSource == nil) { return; }
    
    NSInteger const numberOfCards = [self.dataSource numberOfCards];
    self.remainingCards = numberOfCards;
    
    for (int index = 0; index < (MIN(self.numberOfCards, self.numberOfVisibleCards)); index++){
        [self addCardView:[self.dataSource cardForItemAtIndex:index] atIndex:index];
    }
    
    [self setNeedsLayout];
}

- (void)addCardView:(SwipableCardViewCard*)cardView atIndex:(NSInteger)index{
    NSInteger index1 = index;
    cardView.delegate = self;
    [self setFrameForCardView:cardView atIndex:index];
    [self.cardViews addObject:cardView];
    [self insertSubview:cardView atIndex:0];
    self.remainingCards -= 1;
}

- (void)setFrameForCardView:(SwipableCardViewCard*)cardView atIndex:(NSInteger)index{
    [self layoutIfNeeded];
    CGRect cardViewFrame = self.bounds;
    CGFloat const horizontalInset = (CGFloat)index * self.horizontalInset;
    CGFloat const verticalInset = (CGFloat)index * self.verticalInset;
    
    cardViewFrame.size.width -= 2 * horizontalInset;
    cardViewFrame.origin.x += horizontalInset;
    cardViewFrame.origin.y += verticalInset;
    
    cardView.frame = cardViewFrame;
}

- (void)removeAllCardViews{
    for (SwipableCardViewCard* card in self.cardViews){
        [card removeFromSuperview];
    }
    [self.cardViews removeAllObjects];
}

- (NSInteger)numberOfCards {
    return 20;
}

- (UIView *)viewForEmptyCards{
    return nil;
}

//MARK:- SwipableViewDelegate
- (void)didBeginSwipeOnView:(nonnull SwipableCardViewCard *)view {}

- (void)didEndSwipeOnView:(nonnull SwipableCardViewCard *)view {}

- (void)didSwipeAwayView:(SwipableCardViewCard *)view towardsDirection:(PanelButtonPosition)direction{
    [self.cardViews removeObjectAtIndex:0];
    
    NSInteger const newIndex = [self.dataSource numberOfCards] - self.remainingCards;
    if (self.remainingCards > 0) {
        [self addCardView:[self.dataSource cardForItemAtIndex:newIndex] atIndex:2];
    }
    for (int i = 0; i < self.cardViews.count; i++){
        [UIView animateWithDuration:0.2 animations:^{
                    [self setFrameForCardView:self.cardViews[i] atIndex:i];
        }];
    }
    
    [self.delegate didSwipeAwayView:view towardsDirection:direction];
}

- (void)didTapView:(nonnull SwipableCardViewCard *)view {
    NSInteger const index = [self.cardViews indexOfObject:view];
    [self.delegate didSelectCard:view atIndex:index];
}

@end
