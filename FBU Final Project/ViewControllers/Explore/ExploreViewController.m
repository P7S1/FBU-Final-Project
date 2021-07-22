//
//  ExploreViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/13/21.
//

#import "ExploreViewController.h"
#import "CategoryTableViewCell.h"
#import "CategoryType.h"
#import "ItemListing.h"
#import "FirebaseFirestoreHelper.h"
#import "ZoomAnimatorDelegate.h"
#import "CategoryTableViewCell.h"
#import "ZoomAnimator.h"
#import "ZoomTransitionController.h"

@interface ExploreViewController()<UITableViewDelegate, UITableViewDataSource, ZoomAnimatorDelegate>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) UIImageView* headerView;

@property (nonatomic, strong) NSArray<ItemListing*>* books;
@property (nonatomic, strong) NSArray<ItemListing*>* electronics;
@property (nonatomic, strong) NSArray<ItemListing*>* pencils;
@property (nonatomic, strong) NSArray<ItemListing*>* calculators;
@property (nonatomic, strong) NSArray<ItemListing*>* bags;
@property (nonatomic, strong) NSArray<ItemListing*>* furniture;

@end

@implementation ExploreViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.books = [[NSArray alloc]init];
        self.electronics = [[NSArray alloc]init];
        self.pencils = [[NSArray alloc]init];
        self.calculators = [[NSArray alloc]init];
        self.bags = [[NSArray alloc]init];
        self.furniture = [[NSArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self setUpHeaderView];
    [self setUpTableView];
    [self fetchListings];
    self.navigationItem.title = @"Explore";
}

- (void)fetchListings{
    [FirebaseFirestoreHelper fetchListings:^(NSArray<ItemListing *> * _Nullable results, NSError * _Nullable error) {
        if (error == nil){
            for(ItemListing* item in results){
                switch (item.category) {
                    case CategoryTypeBooks:
                        self.books = [self.books arrayByAddingObject:item];
                        break;
                    case CategoryTypeElectronics:
                        self.electronics = [self.electronics arrayByAddingObject:item];
                        break;
                    case CategoryTypePencils:
                        self.pencils = [self.pencils arrayByAddingObject:item];
                        break;
                    case CategoryTypeCalculators:
                        self.calculators = [self.calculators arrayByAddingObject:item];
                        break;
                    case CategoryTypeBags:
                        self.bags = [self.bags arrayByAddingObject:item];
                        break;
                    case CategoryTypeFurniture:
                        self.furniture = [self.furniture arrayByAddingObject:item];
                        break;
                    default:
                        break;
                }
                [self.tableView reloadData];
            }
        }else{
            NSLog(@"Fetching Listings Failure: %@",[error localizedDescription]);
        }
    }];
}


- (void)setUpHeaderView{
    self.headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, UIScreen.mainScreen.bounds.size.width, 150)];
    self.headerView.backgroundColor = UIColor.secondarySystemBackgroundColor;
    self.headerView.image = [UIImage imageNamed:@"back_to_school"];
    self.headerView.contentMode = UIViewContentModeScaleAspectFill;
    self.headerView.clipsToBounds = YES;
    self.headerView.layer.masksToBounds = YES;
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
    return [CategoryType getAllCategories].count;
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"CategoryTableViewCell"];
    cell.titleLabel.text = [CategoryType getAllCategories][indexPath.row];
    switch (indexPath.row) {
        case CategoryTypeBooks:
            cell.items = self.books;
            break;
        case CategoryTypeElectronics:
            cell.items = self.electronics;
            break;
        case CategoryTypePencils:
            cell.items = self.pencils;
            break;
        case CategoryTypeCalculators:
            cell.items = self.calculators;
            break;
        case CategoryTypeBags:
            cell.items = self.bags;
            break;
        case CategoryTypeFurniture:
            cell.items = self.furniture;
            break;
        default:
            break;
    }
    
    [cell reloadCollectionViewData];
    cell.presentingViewController = self;
    return cell;
}

- (UIImageView*)refereneImageViewFor:(ZoomAnimator *)zoomAnimator{
    return self.selectedCell.itemImageView;
}

- (CGRect)refereneImageViewFrameInTransitioningViewFor:(ZoomAnimator *)zoomAnimator{
    return [self.selectedCell convertRect:self.selectedCell.bounds toView:self.view];
}

- (void)transitionDidEndWith:(ZoomAnimator *)zoomAnimator {}

- (void)transitionWillStartWith:(ZoomAnimator *)zoomAnimator {}

@end
