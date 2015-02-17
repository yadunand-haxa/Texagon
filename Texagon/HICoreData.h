//
//  HICoreData.h
//  SST Notes
//
//  Created by Ravern Koh on 13/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "HIAppDelegate.h"

@interface HICoreData : NSObject

+ (NSArray *)fetchDataOfEntityName:(NSString *)name withPredicate:(NSPredicate *)predicate;
+ (NSArray *)fetchDataOfEntityName:(NSString *)name;
+ (void)deleteObject:(NSManagedObject *)object;
+ (void)saveContext;
+ (NSManagedObjectContext *)context;
+ (NSManagedObjectModel *)model;
+ (NSPersistentStoreCoordinator *)coordinater;

@end
