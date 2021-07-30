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
#import "BasicButton.h"
#import "DesignHelper.h"

@interface CartViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView* tableView;
@property (nonatomic, strong) NSArray<ItemListing*>* items;
@property (nonatomic, strong) BasicButton* checkoutButton;

@property (nonatomic) CGFloat total;

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
    [self setUpCheckoutButton];
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

- (void)setUpCheckoutButton{
    self.checkoutButton = [[BasicButton alloc]init];
    self.checkoutButton.backgroundColor = [DesignHelper buttonBackgroundColor];
    [self.checkoutButton setTitleColor:[DesignHelper buttonTitleLabelColor] forState:UIControlStateNormal];
    self.checkoutButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.checkoutButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.checkoutButton.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:16.0],
        [self.checkoutButton.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:-16.0],
        [self.checkoutButton.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-16],
        [self.checkoutButton.heightAnchor constraintEqualToConstant:50.0]
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

- (void)updateCheckoutButton{
    [self.checkoutButton setTitle:[[@"$" stringByAppendingString:@(self.total).stringValue] stringByAppendingString:@" Checkout"] forState:UIControlStateNormal];
}

- (CGFloat)total{
    CGFloat total = 0.0;
    for (int i = 0; i < self.items.count; i++){
        total += self.items[self.items.count-1].price;
    }
    return total;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    [self updateCheckoutButton];
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
