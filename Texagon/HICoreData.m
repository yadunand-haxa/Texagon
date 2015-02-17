//
//  HICoreData.m
//  SST Notes
//
//  Created by Ravern Koh on 13/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import "HICoreData.h"
#import "HIConstants.h"

@implementation HICoreData

+ (NSArray *)fetchDataOfEntityName:(NSString *)name withPredicate:(NSPredicate *)predicate
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:name];
    request.predicate = predicate;
    return [[self context] executeFetchRequest:request error:nil];
}

+ (NSArray *)fetchDataOfEntityName:(NSString *)name
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:name];
    return [[self context] executeFetchRequest:request error:nil];
}

+ (void)deleteObject:(NSManagedObject *)object
{
    [[self context] deleteObject:object];
    [[self context] save:nil];
}

+ (void)saveContext
{
    [[self context] save:nil];
}

+ (NSManagedObjectContext *)context
{
    return ((HIAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectContext;
}

+ (NSManagedObjectModel *)model
{
    return ((HIAppDelegate *)[UIApplication sharedApplication].delegate).managedObjectModel;
}

+ (NSPersistentStoreCoordinator *)coordinater
{
    return ((HIAppDelegate *)[UIApplication sharedApplication].delegate).persistentStoreCoordinator;
}

@end
