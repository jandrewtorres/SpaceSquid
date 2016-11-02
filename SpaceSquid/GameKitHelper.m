//
//  GameKitHelper.m
//  SpaceSquid
//
//  Created by Andrew Torres on 11/22/14.
//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//

#import "GameKitHelper.h"

NSString *const PresentAuthenticationViewController = @"present_authentication_view_controller";

@implementation GameKitHelper
{
    BOOL _enableGameCenter;
}

//create and return singleton object
+(instancetype)sharedGameKitHelper
{
    static GameKitHelper *sharedGameKitHelper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedGameKitHelper = [[GameKitHelper alloc] init];
    });
    return sharedGameKitHelper;
}

-(id)init
{
    self = [super init];
    if (self) {
        _enableGameCenter = YES;
    }
    return self;
}

-(void)authenticateLocalPlayer
{
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    localPlayer.authenticateHandler = ^(UIViewController *viewController, NSError *error) {
        [self setLastError:error];
        if(viewController != nil) {
            [self setAuthenticationVC:viewController];
        }
        else if([GKLocalPlayer localPlayer].isAuthenticated) {
            _enableGameCenter = YES;
        }
        else {
            _enableGameCenter = NO;
        }
    };
}

- (void)setAuthenticationVC:(UIViewController *)authenticationVC
{
    if (authenticationVC != nil) {
        _authenticationVC = authenticationVC;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:PresentAuthenticationViewController
         object:self];
    }
}

- (void)setLastError:(NSError *)error
{
    _lastError = [error copy];
    if (_lastError) {
        NSLog(@"GameKitHelper ERROR: %@",
              [[_lastError userInfo] description]);
    }
}

-(void)reportScore
{
    _leaderboardIdentifier = @"SSleaderboard";
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:_leaderboardIdentifier];
    score.value = [GameData sharedGameData].score;
    
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }];
}


- (void)presentLeaderboardsOnViewController:(UIViewController *)viewController {
    GKGameCenterViewController *leaderboardViewController = [[GKGameCenterViewController alloc] init];
    leaderboardViewController.viewState = GKGameCenterViewControllerStateLeaderboards;
    leaderboardViewController.gameCenterDelegate = self;
    [viewController presentViewController:leaderboardViewController animated:YES completion:nil];
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController
{
    [gameCenterViewController dismissViewControllerAnimated:YES completion:nil];
}




@end
