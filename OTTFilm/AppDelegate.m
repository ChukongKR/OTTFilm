//
//  AppDelegate.m
//  OTTFilm
//
//  Created by 郭正豪 on 16/1/29.
//  Copyright © 2016年 郭正豪. All rights reserved.
//

#import "AppDelegate.h"
#import <SMS_SDK/SMSSDK.h>
#import "OTTWelcomeViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [SMSSDK registerApp:SMS_APPKEY withSecret:SMS_SECRET];
    
    if (![[NSUserDefaults standardUserDefaults] valueForKey:@"isFirstOpen"] || [[[NSUserDefaults standardUserDefaults] valueForKey:@"isFirstOpen"] isEqual:@NO]) {
        
        self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //  Welcome Page
        self.window.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"Welcome"];
        
        [self.window makeKeyAndVisible];
        [[NSUserDefaults standardUserDefaults] setValue:@YES forKey:@"isFirstOpen"];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CoreData
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)ottManagedObjectModel {
    if (!_ottManagedObjectModel) {
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"OTTFilm" withExtension:@"momd"];
        _ottManagedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    }
    return _ottManagedObjectModel;
}

- (NSPersistentStoreCoordinator *)ottPSCoordinator {
    if (!_ottPSCoordinator) {
        _ottPSCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self ottManagedObjectModel]];
        NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"OTTFilm.sqlite"];
        NSError *error = nil;
        NSString *failureReason = @"There was an error creating or loading the application's saved data.";
        if (![_ottPSCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data.";
            dict[NSLocalizedFailureReasonErrorKey] = failureReason;
            dict[NSUnderlyingErrorKey] = error;
            error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    return _ottPSCoordinator;
}

- (NSManagedObjectContext *)ottManagedObjectContext {
    if (!_ottManagedObjectContext) {
        NSPersistentStoreCoordinator *coordinator = [self ottPSCoordinator];
        if (!coordinator) {
            return nil;
        }
        _ottManagedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
        [_ottManagedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return _ottManagedObjectContext;
}

- (void)saveContext {
    NSManagedObjectContext *context = self.ottManagedObjectContext;
    if (context) {
        NSError *error = nil;
        if ([context hasChanges] && ![context save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        }
    }
}

@end
