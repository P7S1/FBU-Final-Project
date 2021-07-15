//
//  ListingImageViewTableViewCell.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/14/21.
//

#import <XLForm/XLForm.h>
#import "ListingImageViewTableViewCell.h"

@interface ListingImageViewTableViewCell () <XLFormDescriptorCell>

@property (nonatomic, strong) UIImageView* cellImageView;

@end

@implementation ListingImageViewTableViewCell

- (void)configure{
    self.cellImageView = [[UIImageView alloc]init];
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cellImageView.image = [self.rowDescriptor.cellConfigAtConfigure valueForKey:@"imageView.image"];
    [self.contentView addSubview:self.cellImageView];
    
    CGFloat const width = UIScreen.mainScreen.bounds.size.width - 32;
    CGSize const imageViewSize = CGSizeMake(width, width * (4/3));
}

- (void)update{
    
}

+ (CGFloat)formDescriptorCellHeightForRowDescriptor:(XLFormRowDescriptor *)rowDescriptor{
    return 300;
}

@end
