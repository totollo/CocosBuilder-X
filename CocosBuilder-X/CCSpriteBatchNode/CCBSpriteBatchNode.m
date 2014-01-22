//
//  CCBSpriteBatchNode.m
//  CocosBuilder
//
//  Created by Higgx on 12/28/13.
//
//

#import "CCBSpriteBatchNode.h"

const NSUInteger defaultCapacity = 29;

@implementation CCBSpriteBatchNode

- (id)init
{
    self = [super init];
    if (self) {
        [super initWithFile:@"alpha.png" capacity:defaultCapacity];
    }
    return self;
}

- (void) setSpriteSheet:(CCSpriteFrame *)spriteSheet{
    [self setTexture:spriteSheet.texture];
    _spriteSheet = spriteSheet;
}
@end
