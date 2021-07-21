//
//  ListingItemViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/21/21.
//

#import <SDWebImage/SDWebImage.h>
#import "ListingItemDetailViewController.h"
#import "ItemListing.h"

@interface ListingItemDetailViewController ()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation ListingItemDetailViewController

- (instancetype)initWithListing: (ItemListing*)listing{
    self = [super init];
    if (self) {
        self.item = listing;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.imageView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    NSString* str = self.item.imageUrl;
    if (str){
        NSURL* url = [[NSURL alloc]initWithString:str];
        [self.imageView sd_setImageWithURL:url];
    }
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.imageView];
    [NSLayoutConstraint activateConstraints:@[
        [self.imageView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.imageView.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.imageView.widthAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width],
        [self.imageView.heightAnchor constraintEqualToConstant:UIScreen.mainScreen.bounds.size.width * 1.33]
    ]];
}

@end
