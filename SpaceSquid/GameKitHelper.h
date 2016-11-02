//
//  GameKitHelper.h
//  SpaceSquid
//
//  Created by Andrew Torres on 11/22/14.
//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "GameData.h"

extern NSString *const PresentAuthenticationViewController;

@interface GameKitHelper : NSObject <GKGameCenterControllerDelegate>

@property (nonatomic, readonly) UIViewController *authenticationVC;
@property (nonatomic, readonly) NSError *lastError;


@property (nonatomic, assign) BOOL gameCenterEnabled;
@property (nonatomic, strong) NSString *leaderboardIdentifier;

+(instancetype)sharedGameKitHelper;
- (void)authenticateLocalPlayer;
- (void)reportScore;
- (void)presentLeaderboardsOnViewController:(UIViewController *)viewController;



@end
