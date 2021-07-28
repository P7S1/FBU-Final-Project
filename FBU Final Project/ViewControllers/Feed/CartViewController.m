//
//  CartViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/28/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import "CartViewController.h"
#import "ItemListing.h"
#import "ItemListingTableViewCell.h"
#import "User.h"

@interface CartViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;

@end

@implementation CartViewController

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
    const FIRQuery* collectionRef = [[db collectionWithPath:@"/listings"] queryWhereField:@"buyers" arrayContains:[User sharedInstance].uid];
    
    [collectionRef getDocumentsWithCompletion:^(FIRQuerySnapshot * _Nullable snapshot, NSError * _Nullable error) {
            if (error == nil){
                for (const FIRQueryDocumentSnapshot* document in [snapshot documents]){
                    ItemListing* item = [[ItemListing alloc]initWithDict: [document data]];
                    if (item){
                        self.items = [self.items arrayByAddingObject:item];
                    }
                }
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
    return cell;
}

@end
