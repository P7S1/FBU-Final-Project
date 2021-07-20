//
//  CategoryType.h
//  FBU Final Project
//
//  Created by Keng Fontem on 7/20/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryType : NSObject

typedef enum {
    CategoryTypeBooks = 0,
    CategoryTypeElectronics = 1,
    CategoryTypePencils = 2,
    CategoryTypeCalculators,
    CategoryTypeBags = 3,
    CategoryTypeFurniture = 4
} ItemCategoryType;

@end

NS_ASSUME_NONNULL_END
