//
//  About.m
//  FlyBird
//
//  Created by Andrew Torres on 10/18/14.
//  Copyright (c) 2014 J.Tech. All rights reserved.
//

#import "About.h"
#import "HelloScene.h"

@implementation About

- (void)didMoveToView: (SKView *) view {
    if (!self.contentCreated)
    {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

- (void) backgroundNode1
{
    SKSpriteNode *backgroundNode1 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode1.name=@"aboutbg1";
    backgroundNode1.anchorPoint = CGPointZero;
    backgroundNode1.position = CGPointMake(0, 0);
    backgroundNode1.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode1];
}

- (void) backgroundNode2
{
    SKSpriteNode *backgroundNode2 = [SKSpriteNode spriteNodeWithImageNamed:@"bg_1.png"];
    backgroundNode2.name=@"aboutbg2";
    backgroundNode2.anchorPoint = CGPointZero;
    backgroundNode2.position = CGPointMake(self.frame.size.width - 1, 0);
    backgroundNode2.size = CGSizeMake(self.frame.size.width, self.frame.size.height);
    [self addChild:backgroundNode2];
}

- (void) mainMenuNode
{
    SKLabelNode *mainmenu = [SKLabelNode labelNodeWithFontNamed:@"CourierNewPS-BoldMT"];
    mainmenu.name = @"aboutmainmenu";
    mainmenu.text = @"Main Menu";
    mainmenu.fontSize = 30;
    mainmenu.fontColor = [SKColor whiteColor];
    mainmenu.position = CGPointMake(self.frame.size.width/5,self.frame.size.height/5);
    [self addChild:mainmenu];
    
}

- (void)createSceneContents {
    self.scaleMode = SKSceneScaleModeResizeFill;
    [self backgroundNode1];
    [self backgroundNode2];
    [self mainMenuNode];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        /*UITouch* touch = [touches anyObject];*/
        CGPoint loc = [touch locationInNode:self];
        SKNode *mainmenu = [self childNodeWithName:@"aboutmainmenu"];
        if([mainmenu containsPoint:loc])
        {
            SKAction *moveUp = [SKAction moveByX: 0 y: 10.0 duration: 0.30];
            SKAction *pause = [SKAction waitForDuration: 0.2];
            SKAction *fadeAway = [SKAction fadeOutWithDuration: 0.25];
            SKAction *remove = [SKAction removeFromParent];
            SKAction *moveSequence = [SKAction sequence:@[moveUp, pause, fadeAway, remove]];
            [mainmenu runAction: moveSequence completion:^{
                SKScene *MainMenuScene  = [[HelloScene alloc] initWithSize:self.size];
                [self.view presentScene:MainMenuScene];
            }];;
        }
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    SKNode *back1 = (SKSpriteNode *)[self childNodeWithName:@"aboutbg1"];
    SKNode *back2 = (SKSpriteNode *)[self childNodeWithName:@"aboutbg2"];
    back1.position = CGPointMake(back1.position.x - 1, back1.position.y);
    back2.position = CGPointMake(back2.position.x - 1, back2.position.y);
    if (back1.position.x < -(self.frame.size.width))
    {
        back1.position = CGPointMake(back2.position.x + self.frame.size.width, back1.position.y);
    }
    
    if (back2.position.x < -(self.frame.size.width))
    {
        back2.position = CGPointMake(back1.position.x + self.frame.size.width, back2.position.y);
    }
    
}


@end
