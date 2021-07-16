//
//  SwipableCardViewContainer.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/16/21.
//

#import "SwipableCardViewContainer.h"
#import "SwipableCardViewCard.h"
#import "SwipeableCardViewDataSource.h"

@interface SwipableCardViewContainer ()<SwipeableCardViewDataSource>

@property (nonatomic) NSInteger const numberOfVisibleCards;
@property (nonatomic) NSInteger const horizontalInset;
@property (nonatomic) NSInteger const verticalInset;

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
        
        self.visibleCardViews = [[NSArray alloc]init];
        self.remainingCards = 0;
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
    
}

- (SwipableCardViewCard*)cardForItemAtIndex:(NSInteger)index {
    return nil;
}

- (void)removeAllCardViews{
    for (SwipableCardViewCard* card in self.visibleCardViews){
        [card removeFromSuperview];
    }
    self.visibleCardViews = [[NSArray alloc]init];
}

- (NSInteger)numberOfCards {
    return 20;
}

- (UIView *)viewForEmptyCards{
    return nil;
}

@end
