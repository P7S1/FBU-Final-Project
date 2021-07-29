//
//  CartViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import <FirebaseAuth/FirebaseAuth.h>
#import "CartViewController.h"
#import "ItemListing.h"
#import "ItemListingTableViewCell.h"

@interface CartViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;

@end

@implementation CartViewController

- (instancetype)init{
    self = [super init];
    if (self) {
        self.items = [[NSArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTableView];
    [self fetchItems];
    
    self.navigationItem.title = @"Your Cart";
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
    const FIRFirestore* db = [FIRFirestore firestore];
    const FIRQuery* collectionRef = [[db collectionWithPath:@"listings"] queryWhereField:@"buyers" arrayContains:[FIRAuth auth].currentUser.uid];
    
    [collectionRef getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            if (error == nil){
                for (const FIRQueryDocumentSnapshot* document in [snapshot documents]){
                    ItemListing* item = [[ItemListing alloc]initWithDict: [document data]];
                    if (item){
                        self.items = [self.items arrayByAddingObject:item];
                    }
                }
                [self.tableView reloadData];
            }else{
                NSLog(@"There was an error fetching cart items: %@", [error localizedDescription]);
            }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ItemListingTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"ItemListingTableViewCell"];
    [cell setUpWithItemListing:self.items[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}

@end
