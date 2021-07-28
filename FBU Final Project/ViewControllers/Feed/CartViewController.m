//
//  CartViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import "CartViewController.h"
#import "ItemListing.h"
#import "ItemListingTableViewCell.h"

@interface CartViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self fetchItems];
}

- (void)setUpTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.tableView registerClass:[ItemListingTableViewCell class] forCellReuseIdentifier:@"ItemListingTableViewCell"];
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints: @[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (void)fetchItems{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemListingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemListingTableViewCell"];
    return cell;
}

@end
