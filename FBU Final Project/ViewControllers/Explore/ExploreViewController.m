//
//  ExploreViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "ExploreViewController.h"

@interface ExploreViewController ()

@property (nonatomic, strong) UITableView* tableView;

@end

@implementation ExploreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
}

@end
