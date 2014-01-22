//
//  CCBSwitch.m
//  CocosBuilder
//
//  Created by Higgx on 12/9/13.
//
//

#import "CCBSwitch.h"

@implementation CCBSwitch

-(id)init{
    if (self = [super init]) {
        [self setTouchEnabled:NO];
    }
    
    return self;
}

-(void)cal{
    if (_fmask!=nil && _fon!=nil && _foff!=nil && _fthumb!=nil) {
        [self initWithMaskSprite:[CCSprite spriteWithSpriteFrame:_fmask] onSprite:[CCSprite spriteWithSpriteFrame:_fon] offSprite:[CCSprite spriteWithSpriteFrame:_foff] thumbSprite:[CCSprite spriteWithSpriteFrame:_fthumb]];
        [self setTouchEnabled:false];
    }
}

-(void)setFmask:(CCSpriteFrame *)fmask{
    if (_fmask!=fmask) {
        [_fmask release];
        _fmask = [fmask retain];
    }
    [self cal];
}

-(void)setFon:(CCSpriteFrame *)fon{
    if (_fon!=fon) {
        [_fon release];
        _fon = [fon retain];
    }
    [self cal];
}

-(void)setFoff:(CCSpriteFrame *)foff{
    if (_foff!=foff) {
        [_foff release];
        _foff = [foff retain];
    }
    [self cal];
}

-(void)setFthumb:(CCSpriteFrame *)fthumb{
    if (_fthumb!=fthumb) {
        [_fthumb release];
        _fthumb = [fthumb retain];
    }
    [self cal];
}

@end
