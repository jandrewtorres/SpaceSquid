//
//  GameData.h
//  SpaceSquid
//
//  Created by Andrew Torres on 10/27/14.
//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject <NSCoding>

@property (assign, nonatomic) long score;
@property (assign, nonatomic) long highScore;
@property (assign, nonatomic) long coins;
@property (assign, nonatomic) long lives;
@property (assign, nonatomic) long levelCoins;

+(instancetype)sharedGameData;
-(void)reset;
-(void)save;

@end
