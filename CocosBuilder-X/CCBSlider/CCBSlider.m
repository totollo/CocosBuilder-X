//
//  CCBControlSlider.m
//  CocosBuilder
//
//  Created by Higgx on 12/7/13.
//
//

#import "CCBSlider.h"

@implementation CCBSlider

-(id)init{
    if (self = [super init]) {
        self.ignoreAnchorPointForPosition   = NO;
        // Init default values
        minimumValue_                   = 0.0f;
        maximumValue_                   = 1.0f;
        self.value                      = minimumValue_;
    }
    return self;
}

-(void)calPosition{
    // Defines the content size
    // Add the slider background
    if (backgroundSprite_!=nil) {
        CGRect maxRect = CGRectUnion([backgroundSprite_ boundingBox], [thumbSprite_ boundingBox]);
        self.contentSize = CGSizeMake(maxRect.size.width, maxRect.size.height);
        
        backgroundSprite_.anchorPoint   = ccp (0.5f, 0.5f);
        backgroundSprite_.position      = ccp(self.contentSize.width / 2, self.contentSize.height / 2);
    }
    
    // Add the slider thumb
    if (thumbSprite_!=nil) {
        thumbSprite_.position           = ccp(0, self.contentSize.height / 2);
    }
    
    // Add the progress bar
    if (progressSprite_!=nil) {
        progressSprite_.anchorPoint     = ccp (0.0f, 0.5f);
        progressSprite_.position        = ccp (0.0f, self.contentSize.height / 2);
    }
}

-(void)setThumbSprite:(CCSpriteFrame *)thumbSprite{
    if (thumbSprite_!=nil) {
        [thumbSprite_ removeFromParent];
    }
    thumbSprite_ = [CCSprite spriteWithSpriteFrame:thumbSprite];
    [self calPosition];
    [self addChild:thumbSprite_ z:3];
}

-(void)setProgressSprite:(CCSpriteFrame *)progressSprite{
    if (progressSprite_!=nil) {
        [progressSprite_ removeFromParent];
    }
    progressSprite_ = [CCSprite spriteWithSpriteFrame:progressSprite];
    [self calPosition];
    [self addChild:progressSprite_ z:2];
}

-(void)setBackgroundSprite:(CCSpriteFrame *)backgroundSprite{
    if (backgroundSprite_!=nil) {
        [backgroundSprite_ removeFromParent];
    }
    backgroundSprite_ = [CCSprite spriteWithSpriteFrame:backgroundSprite];
    [self calPosition];
    [self addChild:backgroundSprite_ z:1];
}

@end
