//
//  InspectorSpriteFrameButton.h
//  CocosBuilder
//
//  Created by Higgx on 12/13/13.
//
//

#import <Cocoa/Cocoa.h>

@class InspectorSpriteFrame;

@interface InspectorSpriteFrameButton : NSPopUpButton

@property (nonatomic,assign) InspectorSpriteFrame* root;

@end
