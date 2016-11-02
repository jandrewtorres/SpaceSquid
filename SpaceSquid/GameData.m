//
//  GameData.m
//  SpaceSquid
//
//  Created by Andrew Torres on 10/27/14.
//  Copyright (c) 2014 Andrew Torres. All rights reserved.
//

#import "GameData.h"

@implementation GameData

static NSString* const SSGameDataHighScoreKey = @"highScore";
static NSString* const SSGameDataCoinsKey = @"totalCoins";
static NSString* const SSGameDataLvlCoinsKey = @"levelCoins";
static NSString* const SSGameDataLivesKey = @"lives";

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeDouble:self.highScore forKey: SSGameDataHighScoreKey];
    [encoder encodeDouble:self.coins forKey: SSGameDataCoinsKey];
    [encoder encodeDouble:self.levelCoins forKey: SSGameDataLvlCoinsKey];
    [encoder encodeDouble:self.lives forKey: SSGameDataLivesKey];
}


+(NSString*)filePath
{
    static NSString* filePath = nil;
    if (!filePath) {
        filePath =
        [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
         stringByAppendingPathComponent:@"gamedata"];
    }
    return filePath;
}

+(instancetype)loadInstance
{
    NSData* decodedData = [NSData dataWithContentsOfFile: [GameData filePath]];
    if (decodedData) {
        GameData* gameData = [NSKeyedUnarchiver unarchiveObjectWithData:decodedData];
        return gameData;
    }
    
    return [[GameData alloc] init];
}

- (instancetype)initWithCoder:(NSCoder *)decoder
{
    self = [self init];
    if (self) {
        _highScore = [decoder decodeDoubleForKey: SSGameDataHighScoreKey];
        _coins = [decoder decodeDoubleForKey: SSGameDataCoinsKey];
        _lives = [decoder decodeDoubleForKey: SSGameDataLivesKey];
        _levelCoins = [decoder decodeDoubleForKey: SSGameDataLvlCoinsKey];
    }
    return self;
}

+ (instancetype)sharedGameData {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [self loadInstance];
    });
    
    return sharedInstance;
}

-(void)save
{
    NSData* encodedData = [NSKeyedArchiver archivedDataWithRootObject: self];
    [encodedData writeToFile:[GameData filePath] atomically:YES];
}

-(void)reset
{
    self.score = 0;
    self.levelCoins = 0;
}

@end
