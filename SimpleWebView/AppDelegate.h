//
//  AppDelegate.h
//  SimpleWebView
//
//  Created by Сергей on 11/21/17.
//  Copyright © 2017 home. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSNotificationName const kChangeDefaultURLNotification;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, copy) NSURL* defaultURL;

@end

@interface UIApplication(AppDelegate)
@property (nonatomic, readonly) AppDelegate* appDelegate;
@end

