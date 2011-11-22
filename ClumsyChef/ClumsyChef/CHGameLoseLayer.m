//
//  CHGameLoseLayer.m
//  ClumsyChef
//
//  Created by Tong on 3/11/11.
//  Copyright 2011 Team iUCI. All rights reserved.
//

#import "CHGameLoseLayer.h"
#import "CHGameScene.h"

@implementation CHGameLoseLayer

- (CHGameScene *)gameSceneParent
{
	CHGameScene *p = (CHGameScene *)self.parent;
	if ([p isKindOfClass:[CHGameScene class]])
		return p;
	return nil;
}

- (id)init
{
	if (self = [super init])
	{
		CGFloat screenCenterX = CHGetHalfWinWidth();
		
        CCLayerColor *bg = [CCLayerColor layerWithColor:ccc4(160, 160, 160, 255)];
        [self addChild:bg];
        
        CCSprite *lose = [CCSprite spriteWithFile:@"gameOver-title.png"];
        [lose setPositionSharp:ccp(screenCenterX, 290)];
        [self addChild:lose];
        
        CCMenuItemImage *retry = [CCMenuItemImage itemFromNormalImage:@"gameEnd-restart.png" 
														selectedImage:@"gameEnd-restart-high.png"
															   target:self 
															 selector:@selector(restartPressed:)];
        
        CCMenuItemImage *quit = [CCMenuItemImage itemFromNormalImage:@"gameEnd-menu.png" 
													   selectedImage:@"gameEnd-menu-high.png"
															  target:self
															selector:@selector(menuPressed:)];

        CCMenu *menu = [CCMenu menuWithItems:retry, quit, nil];
        menu.position = ccp(screenCenterX, 52);
        [menu alignItemsHorizontally];
		
		// Make sure they are at sharp position after the alignment
		[retry sharpenCurrentPosition];
		[quit sharpenCurrentPosition];
		
        [self addChild:menu];        
	}
	return self;
}


#pragma mark -
#pragma mark UI events

- (void)restartPressed:(id)sender
{
	[[self gameSceneParent] restartLevel];
}

- (void)menuPressed:(id)sender
{
	[[self gameSceneParent] quitGame];
}


@end
