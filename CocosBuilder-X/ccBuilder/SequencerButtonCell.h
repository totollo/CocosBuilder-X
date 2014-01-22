//
//  SequenerButtonCell.h
//  SpriteBuilder
//
//  Created by John Twigg on 2013-11-18.
//
//

#import <Cocoa/Cocoa.h>
#import "cocos2d.h"

@interface SequencerButtonCell : NSButtonCell
{
    NSImage * imgRowBgChannel;
    BOOL      imagesLoaded;
    
    CCNode * _node;
    
}

@property (nonatomic,assign) CCNode* node;

@property (nonatomic,assign) int type;

@end
