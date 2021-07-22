//
//  ExploreViewController.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "CategoryCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class CategoryTableViewCell;

@interface ExploreViewController : RootViewController

@property (nonatomic, strong) CategoryCollectionViewCell * _Nullable selectedCell;

@end

NS_ASSUME_NONNULL_END
