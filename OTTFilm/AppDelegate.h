//
//  AppDelegate.h
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/29.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** CoreData */
@property (strong, nonatomic) NSManagedObjectContext *ottManagedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *ottManagedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *ottPSCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

