//
//  LevelOne.h
//  FlyBird
//
//  Created by Andrew Torres on 3/4/14.
//  Copyright (c) 2014 J.Tech. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "GameViewController.h"
#import "GameKitHelper.h"

@interface LevelOne : SKScene <SKPhysicsContactDelegate>
@property BOOL contentCreated;

@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastSpawn2TimeInterval;
@property (nonatomic) NSTimeInterval lastSpawn3TimeInterval;
@property (nonatomic) NSTimeInterval lastCoinSpawnInterval;
@property (nonatomic) NSTimeInterval lastDeathSpawnInterval;

@property (nonatomic) NSTimeInterval lastCoinUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval2;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval3;
@property (nonatomic) NSTimeInterval lastUpdateTimeIntervalDie;

@property (nonatomic) NSTimeInterval clickStartTime;
@property (nonatomic) NSTimeInterval startToCurrentTime;

@property (strong) NSMutableArray* contactQueue;

@property (nonatomic) BOOL gameEnding;


@property bool didcollide;
@property bool didcoincollide;
@property bool start;
@property bool inv_life;

@end
