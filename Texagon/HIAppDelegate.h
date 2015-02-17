//
//  AppDelegate.h
//  SST Notes
//
//  Created by Ravern Koh on 11/7/14.
//  Copyright (c) 2014 Haxa Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface HIAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) AVAudioPlayer *player;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

