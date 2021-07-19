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

@end

@implementation ExploreViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpTableView];
}

- (void)setUpTableView{
    self.tableView = [[UITableView alloc]init];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    return cell;
}

@end
