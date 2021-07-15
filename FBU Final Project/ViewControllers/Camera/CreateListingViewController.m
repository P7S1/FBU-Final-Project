//
//  CreateListingViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/14/21.
//

#import "CreateListingViewController.h"
#import "ListingImageViewTableViewCell.h"
#import "XLForm/XLForm.h"

@interface CreateListingViewController ()

@end

@implementation CreateListingViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self initializeForm];
    
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
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ending" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Ends in"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    [section addFormRow:row];

    self.form = form;
}

@end
