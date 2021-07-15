//
//  CreateListingViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/14/21.
//

#import <FirebaseFirestore/FirebaseFirestore.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "CreateListingViewController.h"
#import "ListingImageViewTableViewCell.h"
#import "XLForm/XLForm.h"
#import "ItemListing.h"
#import "FirebaseStorageHelper.h"

@interface CreateListingViewController ()

@end

@implementation CreateListingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initializeForm];
    [self createPostButton];
    self.navigationItem.title = @"Create A Listing";
}

- (void)createPostButton{
    UIBarButtonItem* const createBarButtonItem = [[UIBarButtonItem alloc]initWithTitle: @"Finish" style: UIBarButtonItemStyleDone target: self action: @selector(createButtonPressed)];
    self.navigationItem.rightBarButtonItem = createBarButtonItem;
}

- (void)createButtonPressed{
    NSMutableDictionary *const dict = [[NSMutableDictionary alloc]initWithDictionary:self.formValues];;
    
    NSDate *const endsInNSDate = [dict valueForKey:@"endsInNSDate"];
    FIRTimestamp *const endsInTimestamp = [FIRTimestamp timestampWithDate:endsInNSDate];
    
    [dict setValue:endsInTimestamp forKey:@"endsInTimestamp"];
    [dict removeObjectForKey:@"endsInNSDate"];
    
    ItemListing * const item = [[ItemListing alloc]initWithDict:dict];
    
    [SVProgressHUD show];
    
    [FirebaseStorageHelper saveImageAtStorageReferenceString:[[@"listings/" stringByAppendingString:item.uid] stringByAppendingString:@".jpg"] image:self.listingImage completionHandler:^(NSURL * _Nullable url, NSError * _Nullable error) {
        if (error == nil){
            [item saveInBackgroundAtDefaultDirectoryWithCompletion:^(NSError * _Nullable error) {
                if (error){
                    [SVProgressHUD showErrorWithStatus:@"Error"];
                    NSLog(@"Error saving listing object: %@", error.localizedDescription);
                }else{
                    [SVProgressHUD dismiss];
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }];
        }else{
            [SVProgressHUD showErrorWithStatus:@"Error"];
            NSLog(@"Error saving listing image to Firebase: %@", [error localizedDescription]);
        }
    }];
}

- (void)initializeForm{
    self.tableView.rowHeight = 44;
    [[XLFormViewController cellClassesForRowDescriptorTypes] setObject:[ListingImageViewTableViewCell class] forKey:@"imageView"];
    
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    form = [XLFormDescriptor formDescriptorWithTitle:@"Create A Listing"];

    // First section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    // ImageView
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"imageView" rowType:@"imageView"];
    [row.cellConfigAtConfigure setObject:self.listingImage forKey:@"imageView.image"];
    [section addFormRow:row];
    
    // Second section
    section = [XLFormSectionDescriptor formSection];
    section.title = @"Tell us more about your item";
    [form addFormSection:section];

    // Title
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"name" rowType:XLFormRowDescriptorTypeText title:@"Name"];
    [row.cellConfigAtConfigure setObject:@"Name of your item" forKey:@"textField.placeholder"];
    [section addFormRow:row];

    // Description
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"description" rowType:XLFormRowDescriptorTypeText title:@"Description"];
    [row.cellConfigAtConfigure setObject:@"Describe your item" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    
    // Price
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"price" rowType:XLFormRowDescriptorTypeDecimal title:@"Price"];
    [row.cellConfigAtConfigure setObject:@"$2.99" forKey:@"textField.placeholder"];
    [section addFormRow:row];

    // Third Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    // Quantity
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"quantity" rowType:XLFormRowDescriptorTypeInteger title:@"Quantity"];
    [row.cellConfigAtConfigure setObject:@"0" forKey:@"textField.placeholder"];
    [section addFormRow:row];
    
    // Location
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"location" rowType:XLFormRowDescriptorTypeText title:@"Location"];
      [row.cellConfigAtConfigure setObject:@"Item Location" forKey:@"textField.placeholder"];
      [section addFormRow:row];

    // Starts
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"endsInNSDate" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Ends in"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    [section addFormRow:row];

    self.form = form;
}

@end
