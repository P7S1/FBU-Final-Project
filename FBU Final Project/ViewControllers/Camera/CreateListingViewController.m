//
//  CreateListingViewController.m
//  FBU Final Project
//
//  Created by Keng Fontem on 7/14/21.
//

#import "CreateListingViewController.h"
#import "XLForm/XLForm.h"

@interface CreateListingViewController ()

@end

@implementation CreateListingViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self){
        [self initializeForm];
    }
    return self;
}

- (void)initializeForm {
    XLFormDescriptor * form;
    XLFormSectionDescriptor * section;
    XLFormRowDescriptor * row;

    form = [XLFormDescriptor formDescriptorWithTitle:@"Create A Listing"];

    // First section
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
    
    
    //Price
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"price" rowType:XLFormRowDescriptorTypeDecimal title:@"Price"];
    [row.cellConfigAtConfigure setObject:@"$2.99" forKey:@"textField.placeholder"];
    [section addFormRow:row];

    // Second Section
    section = [XLFormSectionDescriptor formSection];
    [form addFormSection:section];
    
    // Quantity
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"quantity" rowType:XLFormRowDescriptorTypeInteger title:@"Quantity"];
    [row.cellConfigAtConfigure setObject:@"0" forKey:@"textField.placeholder"];
    [section addFormRow:row];

    // Starts
    row = [XLFormRowDescriptor formRowDescriptorWithTag:@"ending" rowType:XLFormRowDescriptorTypeDateTimeInline title:@"Ends in"];
    row.value = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    [section addFormRow:row];

    self.form = form;
}

@end
