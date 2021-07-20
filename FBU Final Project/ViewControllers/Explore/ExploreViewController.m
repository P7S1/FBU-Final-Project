//
//  ExploreViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "ExploreViewController.h"
#import "CategoryTableViewCell.h"

@interface ExploreViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* headerView;

@end

@implementation ExploreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpHeaderView];
    [self setUpTableView];
    self.navigationItem.title = @"Explore";
}

- (void)setUpHeaderView{
    self.headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 150)];
    self.headerView.backgroundColor = UIColor.secondarySystemBackgroundColor;
}

- (void)setUpTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = UIColor.systemBackgroundColor;
    self.tableView.allowsSelection = NO;
    self.tableView.tableHeaderView = self.headerView;
    [self.tableView registerClass:[CategoryTableViewCell class] forCellReuseIdentifier:@"CategoryTableViewCell"];
    
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
        [self.tableView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor],
        [self.tableView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor]
    ]];
}

//MARK:- UITableViewDelegate + Datasource
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    return cell;
}

@end
